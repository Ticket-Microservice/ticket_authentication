FROM elixir:alpine

RUN apk update && apk add inotify-tools
# RUN apk add curl
# RUN curl -L https://github.com/fullstorydev/grpcurl/releases/download/v1.9.1/grpcurl_1.9.1_linux_x86_64.tar.gz -o grpcurl.tar.gz
# RUN tar -xzf grpcurl.tar.gz
# RUN mv grpcurl /usr/local/bin/
# RUN rm grpcurl.tar.gz
# RUN grpcurl --version
RUN apk add nano
RUN apk add --update alpine-sdk
RUN mkdir /app
WORKDIR /app
COPY . .
RUN mix do deps.get, deps.compile
# COPY test_entrypoint.sh .
# RUN chmod +x /app/test_entrypoint.sh

EXPOSE 4000 50051
# CMD ["/app/entrypoint.sh"]
CMD ["mix", "phx.server"]