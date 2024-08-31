FROM alpine:3.20.2 AS base

ARG KERNEL_VERSION=6.6.48-r0
ENV KERNEL_VERSION=$KERNEL_VERSION
ARG KERNEL_VARIANT=virt
ENV KERNEL_VARIANT=$KERNEL_VARIANT

RUN \
apk update --no-check-certificate && \
apk add --no-cache --no-check-certificate \
alpine-sdk=1.0-r1 \
build-base=0.5-r3 \
git=2.45.2-r0 \
pahole=1.25-r0 \
linux-${KERNEL_VARIANT}-dev=${KERNEL_VERSION}

FROM base AS download
WORKDIR /coral-tpu-driver
RUN git clone "https://github.com/google/gasket-driver.git" "gasket-driver"
#&& \
RUN cp "/sys/kernel/btf/vmlinux" "/lib/modules/$(echo "${KERNEL_VERSION}" | sed -r 's/r//')-${KERNEL_VARIANT}/build/"

WORKDIR /coral-tpu-driver/gasket-driver/src
# compiled apex.ko and gasket.ko files are in the same directory as the source
COPY --chmod=766 entrypoint.sh entrypoint.sh

FROM download AS build

WORKDIR /coral-tpu-driver/gasket-driver/src
ENTRYPOINT ["./entrypoint.sh", "${KERNEL_VARIANT}", "${KERNEL_VERSION}"]


