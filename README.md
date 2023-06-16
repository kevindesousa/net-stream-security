# Nginx Stream Security

This Docker image allows you to configure an Nginx streaming server while allowing or denying specific IP addresses. It takes the following environment variables into account:

-   **`ALLOWED_IPS`**: a comma-separated list of allowed IP addresses (IPv4 and/or IPv6).
-   **`PROXY_PASS`**: the address and port to redirect the traffic to (including the port).

## Usage

To use this image, you need to specify the required environment variables when starting the container. Here's an example **`docker run`** command:

```shell
docker run -d \
	--network=net_portainer_agent \
	-p 8000:9000 \
	-e ALLOWED_IPS="192.168.0.1, 2001:0db8:85a3:0000:0000:8a2e:0370:7334" \
	-e PROXY_PASS="portainer_agent:9002" \
	kevindesousa/net-stream-security:latest
```

In this example, the Nginx streaming server will be accessible on port **`8000`**. The allowed IP addresses are **`192.168.0.1`** and **`2001:0db8:85a3:0000:0000:8a2e:0370:7334`**. The traffic will be redirected to **`portainer_agent:9002`**.

FYI: We assuming the container **`portainer_agent`** is on the same network of **`net_portainer_agent`**

## Usage with Docker Compose

You can also use Docker Compose to simplify container management. Here's an example configuration to integrate the **`kevindesousa/net-stream-security`** image with a **`portainer_agent`** container that doesn't expose any ports:

```yaml
version: "3.8"
services:
  stream_security:
    image: kevindesousa/net-stream-security:latest
    ports:
      - 9999:9000
    environment:
      - ALLOWED_IPS=192.168.0.1,2001:0db8:85a3:0000:0000:8a2e:0370:7334
      - PROXY_PASS=portainer_agent:9002
    depends_on:
      - portainer_agent

  portainer_agent:
    image: portainer/agent
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    networks:
      - net_portainer_agent

networks:
  net_portainer_agent:
```

In this example, the Nginx streaming server will be accessible on port **`9999`**, redirecting traffic to **`portainer_agent:9002`**. The allowed IP addresses are **`192.168.0.1`** and **`2001:0db8:85a3:0000:0000:8a2e:0370:7334`**.

Make sure to adapt the IP addresses and ports according to your specific needs.

---
Feel free to further customize this README file based on your specific requirements and additional functionality.
