FROM ubuntu:latest

RUN apt-get update && upt-get -y upgrade && apt-get install -y bash coreutils uuid-runtime

WORKDIR /lab

COPY script.sh /lab/script.sh

RUN chmod +x /lab/script.sh

CMD ["./script.sh"]
