#!/usr/bin/env sh

KVERSION="$(echo "${KERNEL_VERSION}" | sed -r 's/r//')-${KERNEL_VARIANT}"
export KVERSION

echo "[INFO] Building for Kernel: $KVERSION"

if [ -d /output ]; then
  echo "[INFO] output dir exists already"
else
  echo "[INFO] creating output dir"
  echo "[WARN] this likely means you don't have the volumes setup properly and won't get the compiled files."
  mkdir /output
fi

echo "[INFO] Patching Makefile KVERSION"
sed -ri "s/^KVERSION.*//" Makefile

echo "[INFO]"
make && \
find ./ -name "*.ko" -exec cp "{}" /output/ \;
