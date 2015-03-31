FROM dockerfile/java:oracle-java7

ADD templates/mirthconnect /usr/local/mirthconnect
WORKDIR /usr/local/mirthconnect

RUN curl -O http://downloads.mirthcorp.com/connect/3.2.0.7628.b1617/mirthconnect-3.2.0.7628.b1617-unix.sh
RUN chmod +x mirthconnect-3.2.0.7628.b1617-unix.sh mirthconnect-install-wrapper.sh mirthconnect-wrapper.sh
RUN ./mirthconnect-install-wrapper.sh

RUN apt-get update && apt-get -y install nginx
ADD templates/etc /etc

EXPOSE 3000 9661

CMD ./mirthconnect-wrapper.sh
