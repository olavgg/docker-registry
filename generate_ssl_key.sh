#!/bin/bash

#Required
domain=$1
commonname=$domain
 
#Change to your company details
country=NO
state=Rogaland
locality=Sola
organization=example.org
organizationalunit=IT
email=olav@backupbay.com

openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 3600 \
	-nodes \
	-subj "/C=$country/ST=$state/L=$locality/O=$organization/\
	OU=$organizationalunit/CN=$commonname/emailAddress=$email"


#if (( $# != 2 ))
#then
#    echo "Usage: aliasname password"
#    exit 1
#fi

#keytool -genkey -keystore ./$1.p12 -deststoretype PKCS12 \
#	-storepass $2 -alias $1 -keyalg "RSA" -keysize 2048 -validity 9000
#openssl pkcs12 -in $1.p12
#keytool -v -importkeystore -srckeystore ./$1.p12 -srcstoretype PKCS12 \
#	-srcstorepass $2 -destkeystore ./$1.jks -deststoretype JKS -deststorepass $2 
