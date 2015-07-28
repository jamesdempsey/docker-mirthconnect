FROM java:7

RUN apt-get update && apt-get -y install nginx --no-install-recommends \
  && apt-get -y install netcat

WORKDIR /usr/local/mirthconnect

ADD templates/mirthconnect/mirthconnect-install-wrapper.sh /usr/local/mirthconnect/mirthconnect-install-wrapper.sh

RUN wget http://downloads.mirthcorp.com/connect/3.2.1.7650.b40/mirthconnect-3.2.1.7650.b40-unix.sh \
 && chmod +x mirthconnect-3.2.1.7650.b40-unix.sh \
 && ./mirthconnect-install-wrapper.sh

ADD templates/etc /etc
ADD templates/mirthconnect /usr/local/mirthconnect

EXPOSE 3000 9661

CMD ./mirthconnect-wrapper.sh
