 
FROM golang:alpine as builder

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk update && apk add curl git bash

WORKDIR /src

ENV GO111MODULE=on
ENV GOPROXY=https://mirrors.aliyun.com/goproxy/
#RUN git clone https://github.com/EdgoraCN/guac.git
COPY . /src/go
RUN cd go && go mod download && go build main.go


FROM alpine:3

# Expose the application on port 4567*
EXPOSE 6060
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk update && apk add  --no-cache  curl bash

ENV CONFIG_PATH /app/app.yaml
ENV LOG_LEVEL INFO

COPY --from=builder /src/go/app.yaml /app/app.yaml
COPY --from=builder /src/go/GoMailer /app/GoMailer

WORKDIR /app

CMD ["/app/GoMailer"]