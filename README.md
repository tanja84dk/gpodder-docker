<p align="center">
    <img src="https://raw.githubusercontent.com/xthursdayx/docker-templates/master/images/gpodder-icon.png" alt="" width="150"/>  
</p>

# gPodder Docker

[![Docker Build and Publish](https://github.com/xthursdayx/gpodder-docker/actions/workflows/docker-build-and-publish.yml/badge.svg)](https://github.com/xthursdayx/gpodder-docker/actions/workflows/docker-build-and-publish.yml)

A dockerized version of the [gPodder](https://gpodder.github.io/) podcast client with a built-in browser-based GUI.

[gPodder](https://gpodder.github.io/) is a simple, open source podcast client written in Python using GTK+. In development since 2005 with a proven, mature codebase.

## Setup Instructions:

Here are some examples to help you get started creating a container. If you are an UNRAID user you can access my [UNRAID gPodder template](https://raw.githubusercontent.com/xthursdayx/docker-templates/master/gpodder.xml) in Community Apps.

### docker cli

```bash
docker run -d \
  --name=gPodder \
  -e PUID=99 \
  -e PGID=100 \
  -e TZ=America/new_York \
  -e GUAC_USER=abc `#optional` \
  -e GUAC_PASS=900150983cd24fb0d6963f7d28e17f72 `#optional` \
  -p 8080:8080 \
  -p 3389:3389 \
  -v /path/to/config:/config \
  -v /path/to/downloads:/downloads \
  --restart unless-stopped \
  xthursdayx/gpodder-docker
```

### docker-compose

Compatible with docker-compose v2 schemas.

```yaml
---
version: "2.1"
services:
  gpodder:
    image: xthursdayx/gpodder-docker
    container_name: gPodder
    environment:
      - PUID=99
      - PGID=100
      - TZ=America/New_York
      - GUAC_USER=abc #optional
      - GUAC_PASS=900150983cd24fb0d6963f7d28e17f72 #optional
    volumes:
      - /path/to/config:/config
      - /path/to/downloads:/downloads
    ports:
      - 8080:8080
      - 3389:3389
    restart: unless-stopped
```

### Parameters

Container images are configured using parameters passed at runtime (such as those listed above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container. You can change the external/host port and volume mappings to suit your needs.

| Parameter | Function |
| :----: | --- |
| `-p 8080` | HTTP access to the gPodder GUI. |
| `-p 3389` | RDP access to the gPodder GUI. |
| `-e PUID=99` | for UserID - see below for more information. |
| `-e PGID=100` | for GroupID - see below for more information. |
| `-e TZ=America/New_York` | Specify a timezone to use, e.g. America/New_York. |
| `-e GUAC_USER=abc` | Specify the username for Guacamole's web interface. |
| `-e GUAC_PASS=900150983cd24fb0d6963f7d28e17f72` | Specify the password's MD5 hash for Guacamole's web interface. |
| `-v /config` | Directory where gPodder's configuration and database files will reside, so you won't lose data when you update, reinstall, etc. |
| `-v /downloads` | The directory gPodder will download your podcasts to. |

### User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, you can avoid this by specifying the user `PUID` and group `PGID`.

Ensure any mapped volume directories on your host machine are owned by the same user you specify and you will avoid any permissions issues.

In this instance `PUID=99` and `PGID=100`, to find yours using the following command:

```bash
  $ id <username> # Replace with your username
    uid=99(nobody) gid=100(users) groups=100(users)
```   

### Authentication

If you want to use authentication, specify `GUAC_USER` with the user name of your choice and `GUAC_PASS` with the MD5 hash of your chosen password. You can do this by running the command: 
```
echo -n password | openssl md5
```
```
printf '%s' password | md5sum
```
If `GUAC_USER` and `GUAC_PASS` are not set, there will be no authentication. Please be aware that this image is not hardened for internet usage. If you want to access gPodder from outside of your home network please use a reverse ssl proxy such as NGINX to increase security.
  
## Usage Instructions:

To access the gPodder GUI, point your web browser to 

* `http://SERVERIP:8080/#/client/c/gPodder` (Replace `SERVERIP` with the correct value). 

* You can access gPodder via RDP using port 3389. 

You can access advanced features of the Guacamole remote desktop using ctrl+alt+shift, which will allow you to changing input options and use remote copy/paste or an onscreen keyboard.


If you appreciate my work please consider buying me a coffee, cheers! 😁

<a href="https://www.buymeacoffee.com/xthursdayx"><img src="https://www.paypal.com/en_US/i/btn/btn_donate_SM.gif" alt="Donate" style="width:74px;height:auto;" width="74"></a>
