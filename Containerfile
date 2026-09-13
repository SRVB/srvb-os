# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /
COPY system_files /system_files
COPY logo.png /logo.png

# Base Image
FROM quay.io/fedora/fedora-bootc:latest

# MODIFICATIONS
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    /ctx/build.sh

# LINTING
RUN bootc container lint
