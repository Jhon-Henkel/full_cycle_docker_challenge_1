FROM golang:latest as build

WORKDIR /src

RUN touch main.go

RUN go mod init main

RUN echo 'package main\n\nimport "fmt"\n\nfunc main() {\n\tfmt.Println("Full Cycle Rocks!!")\n}' > main.go

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM scratch

COPY --from=build /src/main /main

ENTRYPOINT ["./main"]