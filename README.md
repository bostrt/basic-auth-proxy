# HTTP Basic Auth proxy
An Apache HTTPD based Basic auth proxy.

## Docker
You can specify a username and password using environment variables. This is useful for testing:
```
# docker run -e USERNAME=jamesbond -e PASSWORD=T0pSecret -e PROXY_TARGET=http://backend.example.com -p 8080:8080 -it bostrt/basic-auth-proxy
```

You can also include your own `htpasswd` file:
```
# mkdir /tmp/secret
# htpasswd -b -c /tmp/secret/htpasswd jamesbond T0pSecret
# docker run -v /tmp/secret:/etc/httpd/secret -e PROXY_TARGET=https://www.google.com -p 8080:8080 -it bostrt/basic-auth-proxy
```

## OpenShift 3
You can specify a username and password using environment variables. This is useful for testing. `PROXY_TARGET` is most useful when set to service host/port or another container's port inside same pod.
```
# oc new-app --env USERNAME=jamesbond --env PASSWORD=T0pSecret --env PROXY_TARGET=http://otherpod.project.svc:8000 bostrt/basic-auth-proxy
```

You can also include your own `htpasswd` file using a secret:
```
# htpasswd -b -c /tmp/htpasswd jamesbond T0pSecret
# oc create secret generic myhtpasswd --from-file=/tmp/htpasswd
# oc new-app --env PROXY_TARGET=http://otherpod.project.svc:8000 bostrt/basic-auth-proxy
# oc set volumes dc/basic-auth-proxy --add --overwrite --secret-name=myhtpasswd -m /etc/httpd/secret
```

You probably want a route too:
```
# oc create route edge --service=basic-auth-proxy
```

