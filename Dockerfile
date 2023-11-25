FROM alpine:latest

RUN apk upgrade --no-cache

COPY hashable.txt /
COPY runner.sh /

ENTRYPOINT [ "sh", "/runner.sh" ]