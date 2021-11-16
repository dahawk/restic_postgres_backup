ARG POSTGRESVERSION
FROM postgres:${POSTGRESVERSION:-14}-alpine3.14

WORKDIR /opt

COPY ./backup.sh .

RUN apk update && \
    apk add --no-cache postgresql-client openssh-client bzip2 restic && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    chmod +x /opt/backup.sh

USER postgres

CMD ["/opt/backup.sh"]
