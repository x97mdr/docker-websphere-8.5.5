FROM rhel

MAINTAINER Jeffrey Cameron <jeffreycameron@gmail.com>

RUN yum -y install unzip
RUN yum -y install gtk2.i686
RUN yum -y install libXtst.i686

RUN mkdir /icosdata/
RUN mkdir /icosdata/IBM
RUN mkdir /icosdata/IBM/installer-package
RUN mkdir /icosdata/IBM/was
RUN mkdir /opt/WebSphere85/

ADD /tmp/DEVELOPERSILAN.agent.installer.linux.gtk.x86_64.zip /tmp/DEVELOPERSILAN.agent.installer.linux.gtk.x86_64.zip

RUN unzip /tmp/DEVELOPERSILAN.agent.installer.linux.gtk.x86_64.zip -d /icosdata/IBM/was


