#!/bin/bash
set -e

# Remove specific arguments from the command line
removed_args="-lfuse3 -lfuse"
args=$(python3 -c "import sys; print(' '.join(arg for arg in sys.argv[1:] if arg not in '$removed_args'.split()))" $@)

# Add some new arguments
args="$args ../image/sysroot/usr/local/lib/libfuse.a ../image/sysroot/lib/libc.a -static"

echo cc $@ > .original-link-args.txt
echo cc $args > .link-args.txt
cc $args