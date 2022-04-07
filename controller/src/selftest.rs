use std::process::Command;
use std::str;
use std::fs;
use std::ffi::OsStr;
use std::time::{Duration, UNIX_EPOCH};
use libc::ENOENT;
use fuser::{BackgroundSession, FileType, FileAttr, Filesystem, Request, ReplyData, ReplyEntry, ReplyAttr, ReplyDirectory};
#[cfg(feature = "skipselftests")]
use log::warn;

// fusefs test adapted from https://github.com/cberner/fuser/blob/master/examples/hello.rs under the MIT license: 
// Copyright (c) 2020-present Christopher Berner
// Copyright (c) 2013-2019 Andreas Neuhaus https://zargony.com/
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. */

const TTL: Duration = Duration::from_secs(1);

const TEST_DIR_ATTR: FileAttr = FileAttr {
    ino: 1,
    size: 0,
    blocks: 0,
    atime: UNIX_EPOCH,
    mtime: UNIX_EPOCH,
    ctime: UNIX_EPOCH,
    crtime: UNIX_EPOCH,
    kind: FileType::Directory,
    perm: 0o755,
    nlink: 2,
    uid: 501,
    gid: 20,
    rdev: 0,
    flags: 0,
    blksize: 512,
};

const TEST_TXT_CONTENT: &str = "Hello World!\n";

const TEST_TXT_ATTR: FileAttr = FileAttr {
    ino: 2,
    size: 13,
    blocks: 1,
    atime: UNIX_EPOCH,
    mtime: UNIX_EPOCH,
    ctime: UNIX_EPOCH,
    crtime: UNIX_EPOCH,
    kind: FileType::RegularFile,
    perm: 0o644,
    nlink: 1,
    uid: 501,
    gid: 20,
    rdev: 0,
    flags: 0,
    blksize: 512,
};

pub struct SelftestError {
    pub message: String,
}

impl From<std::io::Error> for SelftestError {
    fn from(error: std::io::Error) -> Self {
        SelftestError {
            message: format!("failed: io: {}", error),
        }
    }
}

impl From<str::Utf8Error> for SelftestError {
    fn from(error: str::Utf8Error) -> Self {
        SelftestError {
            message: format!("failed: utf8: {}", error),
        }
    }
}

struct TestFs {}

impl Filesystem for TestFs {
    fn lookup(&mut self, _req: &Request, parent: u64, name: &OsStr, reply: ReplyEntry) {
        if parent == 1 && name.to_str() == Some("test.txt") {
            reply.entry(&TTL, &TEST_TXT_ATTR, 0);
        } else {
            reply.error(ENOENT);
        }
    }

    fn getattr(&mut self, _req: &Request, ino: u64, reply: ReplyAttr) {
        match ino {
            1 => reply.attr(&TTL, &TEST_DIR_ATTR),
            2 => reply.attr(&TTL, &TEST_TXT_ATTR),
            _ => reply.error(ENOENT),
        }
    }

    fn read(&mut self, _req: &Request, ino: u64, _fh: u64, offset: i64, _size: u32, _flags: i32, _lock: Option<u64>, reply: ReplyData) {
        if ino == 2 {
            reply.data(&TEST_TXT_CONTENT.as_bytes()[offset as usize..]);
        } else {
            reply.error(ENOENT);
        }
    }

    fn readdir(&mut self, _req: &Request, ino: u64, _fh: u64, offset: i64, mut reply: ReplyDirectory) {
        if ino != 1 {
            reply.error(ENOENT);
            return;
        }

        let entries = vec![
            (1, FileType::Directory, "."),
            (1, FileType::Directory, ".."),
            (2, FileType::RegularFile, "test.txt"),
        ];

        for (i, entry) in entries.into_iter().enumerate().skip(offset as usize) {
            // i + 1 means the index of the next entry
            let _ = reply.add(entry.0, (i + 1) as i64, entry.1, entry.2);
        }
        reply.ok();
    }
}

#[cfg(not(feature = "skipselftests"))]
pub fn perform_selftest() -> Result<(), SelftestError> {
    let mut failed_tests = vec!();

    // Minijail self test
    let minijail_test = Command::new("minijail0")
        .args(["-c", "0", "--ambient", "-C", "/bin", "/true"])
        .status()?;
    
    if !minijail_test.success() {
        failed_tests.push("minijail0");
    }

    // Fusefs self test
    fs::create_dir("/selftest")?;
    let _test_fs: BackgroundSession;
    _test_fs = fuser::spawn_mount2(TestFs {}, &"/selftest", &[])?;
    let fusefs_test = fs::read_to_string("/selftest/test.txt")?;

    if fusefs_test != TEST_TXT_CONTENT {
        failed_tests.push("fusefs");
    }

    if failed_tests.len() > 0 {
        return Err(SelftestError {
            message: format!("failed: {}", failed_tests.join(", ")),
        });
    }
    
    Ok(())
}

#[cfg(feature = "skipselftests")]
pub fn perform_selftest() -> Result<(), SelftestError> {
    warn!("Skipping selftest");
    Ok(())
}