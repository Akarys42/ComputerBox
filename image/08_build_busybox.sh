set -e
source ./constants.sh

pushd ${BUSYBOX_BUILD} > /dev/null

echo ${STYLE_BOLD} CONFIGURING BUSYBOX ${STYLE_RESET}
make defconfig > /dev/null

# Replace a few keys in the config
python3 - CONFIG_STATIC=y CONFIG_SYSROOT=\"$SYSROOT\" CONFIG_PREFIX=\"$SYSROOT\" CONFIG_EXTRA_CFLAGS=\"-specs=${SYSROOT}/lib/musl-gcc.specs\" << EOF
import sys, re

with open(".config") as f:
    c = f.read()

for s in sys.argv[1:]:
    k, *_ = s.split("=")
    c = re.sub(f".*{k}.*", s, c, count=1)

with open(".config", "w") as f:
    f.write(c)
EOF

echo ${STYLE_BOLD} BUILDING BUSYBOX ${STYLE_RESET}
make -j$(nproc)

popd > /dev/null