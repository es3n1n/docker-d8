# docker-d8

Automated builds soon tm

## Docker hub

- [es3n1n/d8](https://hub.docker.com/repository/docker/es3n1n/d8)
- [es3n1n/d8-cli](https://hub.docker.com/repository/docker/es3n1n/d8-cli)

## Usage

### Within your dockerfile

```Dockerfile
FROM ubuntu:22.04

COPY --from=es3n1n/d8:latest /v8/* /usr/local/bin/
COPY --from=es3n1n/d8:latest /v8/lib/*.so /usr/local/lib/
ENV LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

# do your stuff with d8
```

### CLI

`docker run -it es3n1n/d8-cli:latest`
