FROM ubuntu:latest

LABEL maintainer="github/jemyzhang"

ENV TZ 'Asia/Shanghai'
ENV LANG C.UTF-8

RUN groupadd -g 1000 debian-deluged \
        && useradd -r -u 1000 -g 1000 -m -d /home/debian-deluged debian-deluged

RUN apt update \
        && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:deluge-team/stable \
        && apt update \
        && apt -y dist-upgrade

RUN apt -y install \
        deluged deluge-web deluge-console \
        p7zip-full unrar unzip

RUN apt clean

EXPOSE 8112 58846 58946 58946/udp

VOLUME /config /downloads

RUN chown -R debian-deluged:debian-deluged /home/debian-deluged/ && \
        chown -R debian-deluged:debian-deluged /downloads

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

ADD root/ /

ENTRYPOINT ["/entrypoint.sh"]
