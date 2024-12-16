FROM amazonlinux:2.0.20241113.1

RUN amazon-linux-extras enable corretto8 nginx1

RUN yum -y install java-1.8.0-amazon-corretto initscripts nc nginx procps-ng tar wget

WORKDIR /usr/local/mirthconnect

ADD templates/mirthconnect/mirthconnect-install-wrapper.sh /usr/local/mirthconnect/mirthconnect-install-wrapper.sh

RUN wget https://s3.amazonaws.com/downloads.mirthcorp.com/connect/4.4.2.b326/mirthconnect-4.4.2.b326-unix.sh \
 && chmod +x mirthconnect-4.4.2.b326-unix.sh \
 && ./mirthconnect-install-wrapper.sh

ADD templates/etc /etc
ADD templates/mirthconnect /usr/local/mirthconnect

EXPOSE 3000 9661 9662

CMD ./mirthconnect-wrapper.sh
