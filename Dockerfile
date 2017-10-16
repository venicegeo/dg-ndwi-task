FROM alpine:3.6

COPY ./agg-2.5-r0.apk /opt/packages/agg-2.5-r0.apk
COPY ./agg-dev-2.5-r0.apk /opt/packages/agg-dev-2.5-r0.apk

RUN \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    apk add --no-cache --allow-untrusted --virtual .build-deps \
        python-dev \
        gdal-dev \
        sdl-dev \
        libx11 \
        build-base \
        py-numpy-dev \
    ; \
    apk add --no-cache --allow-untrusted \
        py-numpy \
        gdal \
        python \
        py-pip \
        git \
        /opt/packages/agg-dev-2.5-r0.apk \
        /opt/packages/agg-2.5-r0.apk \
    ; \
    pip install \
        glob2 \
        six \
        pyproj \
        fiona \
        gippy \
        gdal==2.1.3 \
    ; \
    apk del .build-deps; \
    rm /opt/packages/agg*

ADD ./bin /
