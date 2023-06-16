#!/bin/bash

sed -i "s|__PROXY_PASS__|$PROXY_PASS|g" /etc/nginx/nginx.conf

# Vérifier si la variable ALLOWED_IPS est définie
if [ -n "$ALLOWED_IPS" ]; then
  # Séparer les adresses IP par la virgule
  IFS=',' read -ra IPS <<< "$ALLOWED_IPS"
  
  # Parcourir chaque adresse IP
  for IP in "${IPS[@]}"; do
    # Ajouter la ligne "allow" dans le fichier stream_ips_allowed.conf
    echo "allow $IP;" >> /etc/nginx/stream_ips_allowed.conf
  done
fi

# Exécuter l'entrypoint du parent nginx
exec /docker-entrypoint.sh "$@"