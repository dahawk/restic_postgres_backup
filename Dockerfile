ARG POSTGRESVERSION
FROM postgres:${POSTGRESVERSION:-14}-alpine3.14

WORKDIR /opt

COPY ./backup.sh .

RUN apk --no-cache update && \
    apk --no-cache add postgresql-client openssh-client bzip2 restic && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    chmod +x /opt/backup.sh

CMD ["/opt/backup.sh"]
