FROM debian:9 as build
RUN apt update && apt install -y wget gcc make
RUN apt install -y libssl-dev openssl build-essential zlib1g-dev libpcre3 libpcre3-dev zlibc unzip
RUN wget https://nginx.org/download/nginx-1.21.1.tar.gz && tar xvfz nginx-1.21.1.tar.gz && cd nginx-1.21.1 && ./configure$
FROM debian:9
WORKDIR /usr/local/nginx/sbin
COPY --from=build /usr/local/nginx/sbin/nginx .
RUN mkdir ../logs ../conf && touch ../logs/error.log && chmod +x nginx
CMD ["./nginx" ,"-g", "daemon off;"]
