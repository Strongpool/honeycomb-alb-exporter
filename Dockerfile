ARG IMAGE_TAG
FROM debian:${IMAGE_TAG}

RUN apt-get -y update && apt-get -y install curl

RUN curl -s -L -o honeyalb https://honeycomb.io/download/honeyaws/v1.4.1/honeyalb-linux-amd64 \
    && echo '8eedfba621a2fdc958aa8a2d50a096f48ce5c861db56aa80794ef99d041c93d9  honeyalb' | sha256sum -c \
    && chmod 755 ./honeyalb \
    && mv ./honeyalb /usr/local/bin

CMD /usr/local/bin/honeyalb --samplerate "${SAMPLE_RATE}" --writekey="${HONEYCOMB_API_KEY}" ingest $LOAD_BALANCERS
