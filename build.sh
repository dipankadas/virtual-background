#!/bin/bash
set -eux

docker stop tflite
docker rm tflite
docker build -t tflite tflite
docker run -dit -v $PWD/tflite:/tflite_src -v $PWD/public/tflite:/tflite_build --name tflite tflite bash
docker exec -w /tflite_src tflite bazel build --config=wasm -c opt :tflite
docker exec tflite tar xvf /tflite_src/bazel-bin/tflite -C /tflite_build
docker exec -w /tflite_src tflite bazel build --config=wasm -c opt --copt='-msimd128' :tflite-simd
docker exec tflite tar xvf /tflite_src/bazel-bin/tflite-simd -C /tflite_build
