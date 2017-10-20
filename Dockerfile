FROM alpine:3.6

RUN \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    apk add --no-cache --virtual .build-deps \
        python-dev \
        gdal-dev \
        sdl-dev \
        libx11 \
        build-base \
        py-numpy-dev \
        agg-dev \
    ; \
    apk add --no-cache \
        py-numpy \
        gdal \
        python \
        py-pip \
        git \
        py-gdal \
        py-six \
        py-click \
        py-enum34 \
        agg \
    ; \
    pip install \
        glob2 \
        pyproj \
        fiona \
        gippy \
    ; \
    apk del .build-deps

ADD ./bin /
