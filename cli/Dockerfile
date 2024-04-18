FROM ubuntu:22.04

COPY --from=es3n1n/d8:latest /v8/* /usr/local/bin/
COPY --from=es3n1n/d8:latest /v8/lib/*.so /usr/local/lib/
ENV LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

ENTRYPOINT ["/bin/bash"]
CMD ["-i"]
