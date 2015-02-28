FROM ubuntu

RUN apt-get update && apt-get -y install software-properties-common
RUN apt-add-repository ppa:webupd8team/java -y
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get update && apt-get -y install tasksel lamp-server^ oracle-java7-installer curl && apt-get purge openjdk-\*

ADD templates/mirthconnect /usr/local/mirthconnect
WORKDIR /usr/local/mirthconnect

RUN curl -O http://downloads.mirthcorp.com/connect/3.2.0.7628.b1617/mirthconnect-3.2.0.7628.b1617-unix.sh
RUN chmod +x mirthconnect-3.2.0.7628.b1617-unix.sh mirthconnect-install-wrapper.sh mirthconnect-wrapper.sh
RUN ./mirthconnect-install-wrapper.sh

RUN apt-get -y install nginx
ADD templates/etc /etc

EXPOSE 3000 9661

CMD ./mirthconnect-wrapper.sh
