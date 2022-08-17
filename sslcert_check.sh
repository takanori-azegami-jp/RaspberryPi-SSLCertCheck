#!/bin/bash

LANG=C

SSLDOMAIN_FILE="./ssl_cert_domain.txt"
SSLKEY_DIR="/etc/letsencrypt/live/"
MAIL_FILE="/var/tmp/sslmail.txt"
TODAY=`date +%Y%m%d`

cat ${SSLDOMAIN_FILE} | while read DOMAIN

do
  CSRFILE="${SSLKEY_DIR}${DOMAIN}/cert.pem"
  if [ -f ${CSRFILE} ]; then
    TMP_DAYS=`openssl x509 -noout -text -in $CSRFILE | grep "Not" | grep "Not After" | sed 's/Not After : //'`
    DAYS=`date -d "$TMP_DAYS" +%Y%m%d`
    DAYS_10AGO=`date -d "$DAYS 10 days ago" +%Y%m%d`
    echo "domain: $DOMAIN" | tee $MAIL_FILE
    echo "deadline: $DAYS" | tee -a $MAIL_FILE
    echo "10age: $DAYS_10AGO" | tee -a $MAIL_FILE
    if [ $TODAY -ge $DAYS_10AGO ]; then
      cat $MAIL_FILE | mailx -s $HOSTNAME [通知先メールアドレス]
    fi
  fi
done
