use std::time::SystemTime;
use serde_derive::Serialize;

#[derive(Debug, Serialize)]
pub enum SerializableTimeOrNow {
    SpecificTime(SystemTime),
    Now,
}

#[derive(Debug, Serialize)]
pub enum FsRequest {
    LookupDirectory {
        id: u64,
        path: String
    },
    GetAttributes {
        id: u64,
        path: String
    },
    SetAttributes {
        id: u64,
        path: String,
        mode: Option<u32>,
        uid: Option<u32>,
        gid: Option<u32>,
        size: Option<u64>,
        atime: Option<SerializableTimeOrNow>,
        mtime: Option<SerializableTimeOrNow>,
        ctime: Option<SystemTime>,
        crtime: Option<SystemTime>,
        chgtime: Option<SystemTime>,
        bkuptime: Option<SystemTime>,
        flags: Option<u32>,
    },
    ReadLink {
        id: u64,
        path: String
    },
    MkNod {
        id: u64,
        path: String,
        mode: u32,
        umask: u32,
        rdev: u32,
    },
    MkDir {
        id: u64,
        path: String,
        mode: u32,
        umask: u32,
    },
    Unlink {
        id: u64,
        path: String,
    },
    RmDir {
        id: u64,
        path: String,
    },
    Symlink {
        id: u64,
        path: String,
        link: String,
    },
    Rename {
        id: u64,
        old_path: String,
        new_path: String,
    },
    Link {
        id: u64,
        path: String,
        target: String,
    },
    Open {
        id: u64,
        path: String,
        flags: u32,
    },
    Read {
        id: u64,
        path: String,
        file_handle: u64,
        offset: u64,
        size: u32,
        flags: i32,
        lock_owner: Option<u64>,
    },
    Write {
        id: u64,
        path: String,
        file_handle: u64,
        offset: u64,
        size: u32,
        flags: i32,
        lock_owner: Option<u64>,
        data: Vec<u8>,
    },
    Flush {
        id: u64,
        path: String,
        file_handle: u64,
        lock_owner: Option<u64>,
    },
    Release {
        id: u64,
        path: String,
        file_handle: u64,
        flags: i32,
        lock_owner: Option<u64>,
        flush: bool,
    },
    OpenDir {
        id: u64,
        path: String,
        flags: i32,
    },
    ReadDir {
        id: u64,
        path: String,
        file_handle: u64,
        offset: i64,
        size: usize
    },
    ReleaseDir {
        id: u64,
        path: String,
        file_handle: u64,
        flags: i32,
    },
    StatFs {
        id: u64,
        path: String,
    },
    SetXAttr {
        id: u64,
        path: String,
        name: String,
        value: Vec<u8>,
        flags: i32,
        position: u32,
    },
    GetXAttr {
        id: u64,
        path: String,
        name: String,
    },
    ListXAttr {
        id: u64,
        path: String,
    },
    RemoveXAttr {
        id: u64,
        path: String,
        name: String,
    },
}

impl FsRequest {
    pub fn id(&self) -> u64 {
        match self {
            FsRequest::LookupDirectory { id, .. } => *id,
            FsRequest::GetAttributes { id, .. } => *id,
            FsRequest::SetAttributes { id, .. } => *id,
            FsRequest::ReadLink { id, .. } => *id,
            FsRequest::MkNod { id, .. } => *id,
            FsRequest::MkDir { id, .. } => *id,
            FsRequest::Unlink { id, .. } => *id,
            FsRequest::RmDir { id, .. } => *id,
            FsRequest::Symlink { id, .. } => *id,
            FsRequest::Rename { id, .. } => *id,
            FsRequest::Link { id, .. } => *id,
            FsRequest::Open { id, .. } => *id,
            FsRequest::Read { id, .. } => *id,
            FsRequest::Write { id, .. } => *id,
            FsRequest::Flush { id, .. } => *id,
            FsRequest::Release { id, .. } => *id,
            FsRequest::OpenDir { id, .. } => *id,
            FsRequest::ReadDir { id, .. } => *id,
            FsRequest::ReleaseDir { id, .. } => *id,
            FsRequest::StatFs { id, .. } => *id,
            FsRequest::SetXAttr { id, .. } => *id,
            FsRequest::GetXAttr { id, .. } => *id,
            FsRequest::ListXAttr { id, .. } => *id,
            FsRequest::RemoveXAttr { id, .. } => *id,
        }
    }
}