FROM tensorflow/tensorflow:devel
RUN git -C /tensorflow_src checkout refs/tags/v2.4.1 -b v2.4.1
RUN git clone https://github.com/google/mediapipe.git /mediapipe_src
RUN sed -i 's/"crosstool_top": "\/\/external:android\/emscripten"/"crosstool_top": "\/\/emscripten_toolchain:everything"/' /tensorflow_src/tensorflow/BUILD \
  && sed -i '/":tvos_arm64": COMMON_SRCS + MACH_SRCS + MACH_ARM_SRCS,/a ":emscripten_wasm": COMMON_SRCS + EMSCRIPTEN_SRCS,' /tensorflow_src/third_party/cpuinfo/BUILD.bazel
COPY workspace.bzl.patch /tensorflow_src/tensorflow/
WORKDIR /tensorflow_src/tensorflow
RUN patch -u < workspace.bzl.patch