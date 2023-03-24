FROM alpine:latest
LABEL maintainer="kunyuan.yao@gmail.com"

RUN apk add bash coreutils wget --no-cache
RUN wget -qO- https://getcroc.schollz.com | bash
EXPOSE 9009-9013

WORKDIR /root
ENTRYPOINT ["croc"]
