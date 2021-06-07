FROM lsiobase/guacgui

LABEL maintainer="xthursdayx"

ENV APPNAME="gPodder" 
ENV GPODDER_TAG="3.10.20"

RUN \
    echo "**** Installing dep packages ****" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    at-spi2-core \
    ca-certificates \
    dbus \
    default-dbus-session-bus \
    ffmpeg \
    gir1.2-gtk-3.0 \
    gir1.2-ayatanaappindicator3-0.1 \
    gir1.2-webkit2-4.0 \
    git \
    help2man \
    intltool \
    jq \
    libgtk-3-0 \
    locales \
    locales-all \
    normalize-audio \
    python3 \
    python3-cairo \
    python3-dbus \
    python3-gi \
    python3-gi-cairo \
    python3-pip \
    python3-simplejson \
    wget \
    xfonts-75dpi \
    xfonts-100dpi
    
RUN \
    echo "**** Installing PyPI deps ****" && \
    pip3 install --no-cache-dir \
	mygpoclient==1.8 \
	podcastparser==0.6.6 \
	requests[socks]==2.25.1 \
	urllib3==1.26.5 \
	html5lib==1.1 \
	mutagen==1.45.1 \
	eyed3 \
	youtube_dl

RUN echo "**** Installing gPodder ****" && \
    git clone https://github.com/gpodder/gpodder.git && \
    cd gpodder && \
    git checkout $GPODDER_TAG && \
    echo "GPODDER_DOWNLOAD_DIR=/downloads" >> ~/.pam_environment

RUN apt-get clean && \
    rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

ENV LANG en_US.UTF-8 \
    LANGUAGE en_US.UTF-8 \
    LC_ALL en_US.UTF-8

COPY root/ /

VOLUME /config
EXPOSE 3389 8080
