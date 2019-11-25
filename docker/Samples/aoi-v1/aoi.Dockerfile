FROM tensorrt:v1 AS build
COPY . /root/AOI/
WORKDIR /root/AOI/build
RUN rm -rf ./* && cmake .. && make -j4

FROM tensorrt:v1
WORKDIR /root/AOI/build
# 拷贝的是 bin 和 lib 里面的文件夹，bin 和 lib 本身不会被拷贝
# COPY --from=build /root/AOI/build/bin /root/AOI/build/lib /root/AOI/build/
COPY --from=build /root/AOI/build/bin /root/AOI/build/bin/
COPY --from=build /root/AOI/build/lib /root/AOI/build/lib/

WORKDIR /root/AOI/build/bin
CMD ["./level5AOI"]

