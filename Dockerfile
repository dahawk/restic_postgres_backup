FROM alpine:3.13

WORKDIR /opt

COPY ./backup.sh .

RUN apk --no-cache update && \
    apk --no-cache add postgresql-client openssh-client bzip2 restic && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    chmod +x /opt/backup.sh

CMD ["/opt/backup.sh"]
