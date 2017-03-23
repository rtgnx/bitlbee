FROM ubuntu:16.04

RUN apt-get -y update && apt-get -y install \
    python2.7 python3.5 git build-essential pkg-config make gcc g++ \
    libglib2.0-dev libglib2.0-bin openssl libgnutls-dev libpurple-bin \
    libpurple-dev libevent-dev libgcrypt20 libgcrypt20-dev autoconf \
    libtool libtool-bin autotools-dev libjson-glib-1.0-0 libjson-glib-dev

RUN bash -c "mkdir -p /tmp/build/{bitlbee,bitlbee-facebook,bitlbee-discord}"
RUN git clone https://github.com/bitlbee/bitlbee /tmp/build/bitlbee
RUN git clone \
    https://github.com/bitlbee/bitlbee-facebook /tmp/build/bitlbee-facebook
RUN git clone \
    https://github.com/sm00th/bitlbee-discord /tmp/build/bitlbee-discord


# Build bitlbee

WORKDIR /tmp/build/bitlbee
RUN ./configure && make && make install && make install-etc && make install-dev

# Build bitlbee-facebook

WORKDIR /tmp/build/bitlbee-facebook
RUN ./autogen.sh && ./configure && make && make install

# Build bitlbee-discord

WORKDIR /tmp/build/bitlbee-discord
RUN ./autogen.sh && ./configure && make && make install

CMD ["bitlbee"]
