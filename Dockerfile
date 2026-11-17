FROM alpine

COPY run_backups.sh / 
RUN mkdir /etc/simple_backup/ && mv /run_backups.sh /etc/simple_backup/ && chmod +x /etc/simple_backup/run_backups.sh &&\
    echo "30 2 * * * bash /etc/simple_backup/run_backups.sh" > /etc/crontabs/root && chown root:root /etc/crontabs/root &&\
    apk update && apk add bash rsync openssh-client tzdata &&\
    cp /usr/share/zoneinfo/Australia/Melbourne /etc/localtime &&\
    echo "Australia/Melbourne" > /etc/timezone &&\
    apk del tzdata && rm -rf /var/cache/apk/*

CMD /usr/sbin/crond -f
