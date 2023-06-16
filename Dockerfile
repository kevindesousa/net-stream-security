FROM nginx:alpine

ARG ALLOWED_IPS
ENV ALLOWED_IPS=$ALLOWED_IPS

ARG PROXY_PASS
ENV PROXY_PASS=$PROXY_PASS

# Installer curl pour configurer nginx
RUN apk add --no-cache curl bash

RUN touch /etc/nginx/stream_ips_allowed.conf;

# Copier le script d'initialisation
COPY init.sh /init.sh
RUN chmod +x /init.sh

# Copier la configuration nginx personnalisée
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 9000

# Définir l'entrée du conteneur
ENTRYPOINT ["/init.sh"]

# Définir la commande pour démarrer nginx
CMD ["nginx", "-g", "daemon off;"]