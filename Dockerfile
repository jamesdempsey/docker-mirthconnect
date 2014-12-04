FROM ubuntu

RUN apt-get update && apt-get -y install software-properties-common
RUN apt-add-repository ppa:webupd8team/java -y
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get update && apt-get -y install tasksel lamp-server^ oracle-java7-installer curl && apt-get purge openjdk-\*

ADD templates/mirthconnect /usr/local/mirthconnect
WORKDIR /usr/local/mirthconnect

RUN curl -O http://downloads.mirthcorp.com/connect/3.1.1.7461.b23/mirthconnect-3.1.1.7461.b23-unix.sh
RUN chmod +x mirthconnect-3.1.1.7461.b23-unix.sh mirthconnect-install-wrapper.sh mirthconnect-wrapper.sh
RUN ./mirthconnect-install-wrapper.sh

EXPOSE 8080 8443 6661

CMD ./mirthconnect-wrapper.sh
