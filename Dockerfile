FROM ubuntu:22.04

WORKDIR /compilers

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update \
    && apt install -yq --no-install-recommends \
        ca-certificates \
        git \
        lsb-release \
        curl \
        xz-utils \
        file \
        binutils \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH=/compilers/depot_tools:$PATH

RUN fetch v8
WORKDIR /compilers/v8

RUN gclient sync

RUN sed -i -e 's/"sudo", //' ./build/install-build-deps.py \
    && ./build/install-build-deps.sh

RUN gn gen out/x64.release \
        --args='is_component_build=true is_debug=false target_cpu="x64" v8_enable_sandbox=false use_goma=false v8_enable_backtrace=true v8_enable_disassembler=true v8_enable_object_print=true v8_enable_verify_heap=true dcheck_always_on=false v8_use_external_startup_data=false v8_enable_i18n_support=false use_sysroot=false use_custom_libcxx=false' \
    && ninja -C out/x64.release d8

RUN strip out/x64.release/d8

RUN cp out/x64.release/d8 /usr/local/bin/ \
    && cp out/x64.release/*.so /usr/local/lib/ 

ENV LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

WORKDIR /
RUN rm -rf /compilers/
