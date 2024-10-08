FROM alpine:3.20.2 AS base

ARG KERNEL_VERSION=6.6.48
ENV KERNEL_VERSION=$KERNEL_VERSION
ARG KERNEL_RELEASE=0
ENV KERNEL_RELEASE=$KERNEL_RELEASE
ARG KERNEL_VARIANT=lts
ENV KERNEL_VARIANT=$KERNEL_VARIANT

RUN \
apk add -U --no-cache \
alpine-sdk=1.0-r1 \
build-base=0.5-r3 \
git=2.45.2-r0 \
pahole=1.25-r0 \
grep=3.11-r0 \
coreutils=9.5-r1 \
linux-${KERNEL_VARIANT}=${KERNEL_VERSION}-r${KERNEL_RELEASE} \
linux-${KERNEL_VARIANT}-dev=${KERNEL_VERSION}-r${KERNEL_RELEASE}

FROM base AS download
WORKDIR /coral-tpu-driver
RUN git clone "https://github.com/google/gasket-driver.git" "gasket-driver" && \
"/usr/src/linux-headers-${KERNEL_VERSION}-${KERNEL_RELEASE}-${KERNEL_VARIANT}/scripts/extract-vmlinux" \
"/boot/vmlinuz-${KERNEL_VARIANT}" > "/lib/modules/${KERNEL_VERSION}-${KERNEL_RELEASE}-${KERNEL_VARIANT}/build/vmlinux"

WORKDIR /coral-tpu-driver/gasket-driver/src
# compiled apex.ko and gasket.ko files are in the same directory as the source
COPY --chmod=766 entrypoint.sh entrypoint.sh

FROM download AS build

WORKDIR /coral-tpu-driver/gasket-driver/src
ENTRYPOINT ["./entrypoint.sh"]


