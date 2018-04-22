#!/bin/bash

# Check that a proxy target is set.
if [ -z "$PROXY_TARGET" ]; then
    echo "PROXY_TARGET environment variable must be set."
    exit 1
fi

if [ ! -f "/etc/httpd/secret/htpasswd" ] && [[ -z "$USERNAME" || -z "$PASSWORD" ]]; then
    echo "htpasswd file must be present or USERNAME/PASSWORD environment variables set."
    exit 1
fi

if [ ! -z "$USERNAME" ] && [ ! -z "$PASSWORD" ]; then
    htpasswd -b -c /etc/httpd/secret/htpasswd $USERNAME $PASSWORD
fi

/usr/sbin/httpd -k start -D FOREGROUND
