FROM golang:latest As build-env

WORKDIR /go/src/coding-prep/docker-go-server

COPY main.go .

RUN go get -d -v ./...
RUN go install -v ./...

COPY . /go/src/coding-prep/docker-go-server


RUN go build -o /bin/docker-go-server

ENTRYPOINT ["/bin/docker-go-server"]

FROM nginx
COPY --from=build-env /bin/docker-go-server /bin/docker-go-server
