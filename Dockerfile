FROM ubuntu:latest

WORKDIR /app

ENV USERNAME=admin
ENV PASSWORD=admin
ENV SERVE_REMOTE=
ENV SERVE_PROTOCOL=http
ENV CONF_BASE64="" 
ENV RCLONE_CONFIG=/app/.config/rclone.conf

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "LANG=en_US.UTF-8" >> /etc/environment
RUN echo "NODE_ENV=development" >> /etc/environment
RUN more "/etc/environment"

RUN apt-get update
RUN apt-get install curl git unzip zip -y

RUN curl -sL https://rclone.org/install.sh | bash
RUN rclone version

RUN curl -sL https://github.com/rclone/rclone-webui-react/releases/download/v2.0.5/currentbuild.zip -o  currentbuild.zip \
    && mkdir -p /root/.cache/rclone/webgui/current/ \
    && unzip currentbuild.zip -d /root/.cache/rclone/webgui/current/ \
    && echo "v2.0.5" > /root/.cache/rclone/webgui/tag \
    && rm currentbuild.zip


ADD run.sh /app/
RUN chmod a+x /app/run.sh

CMD ["./run.sh"]
