FROM dockerfile/java:oracle-java7

RUN apt-get update && apt-get -y install nginx --no-install-recommends

WORKDIR /usr/local/mirthconnect

ADD templates/mirthconnect/mirthconnect-install-wrapper.sh /usr/local/mirthconnect/mirthconnect-install-wrapper.sh

RUN curl -O http://downloads.mirthcorp.com/connect/3.2.0.7628.b1617/mirthconnect-3.2.0.7628.b1617-unix.sh \
 && chmod +x mirthconnect-3.2.0.7628.b1617-unix.sh \
 && ./mirthconnect-install-wrapper.sh

ADD templates/etc /etc
ADD templates/mirthconnect /usr/local/mirthconnect

EXPOSE 3000 9661

CMD ./mirthconnect-wrapper.sh
