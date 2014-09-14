FROM centos

MAINTAINER Jeffrey Cameron <jeffreycameron@gmail.com>

RUN yum -y install unzip
RUN yum -y install gtk2.i686
RUN yum -y install libXtst.i686

RUN groupadd cmpteam
RUN useradd wasuser -g cmpteam

RUN mkdir /opt/software/
RUN mkdir /opt/software/IBM
RUN mkdir /opt/software/IBM/installer-package
RUN mkdir /opt/software/IBM/was
RUN mkdir /opt/WebSphere85/

ADD agent.installer.linux.gtk.x86_64_1.6.2000.20130301_2248.zip /tmp/agent.installer.linux.gtk.x86_64_1.6.2000.20130301_2248.zip
ADD was.repo.8550.developers.ilan_part1.zip /tmp/was.repo.8550.developers.ilan_part1.zip
ADD was.repo.8550.developers.ilan_part2.zip /tmp/was.repo.8550.developers.ilan_part2.zip
ADD was.repo.8550.developers.ilan_part3.zip /tmp/was.repo.8550.developers.ilan_part3.zip
ADD startWebsphere.sh /tmp/startWebsphere.sh

RUN unzip /tmp/agent.installer.linux.gtk.x86_64_1.6.2000.20130301_2248.zip -d /opt/software/IBM/installer-package
RUN unzip /tmp/was.repo.8550.developers.ilan_part1.zip -d /opt/software/IBM/was
RUN unzip /tmp/was.repo.8550.developers.ilan_part2.zip -d /opt/software/IBM/was
RUN unzip /tmp/was.repo.8550.developers.ilan_part3.zip -d /opt/software/IBM/was

#Install Package Manager
WORKDIR /opt/software/IBM/installer-package
RUN ./installc  -acceptLicense -accessRights admin -installationDirectory "/opt/WebSphere85/IMGR" -dataLocation "/opt/WebSphere85/Imdata" -silent

#Install WAS
# /opt/WebSphere85/IMGR/eclipse/tools/imcl listAvailablePackages -repositories /opt/software/IBM/was/repository.config
# [get the output and use that string in the next install command e.g. com.ibm.websphere.BASE.v85_8.5.0.20120501_1108]
WORKDIR /opt/WebSphere85/IMGR/eclipse/tools
RUN ./imcl -acceptLicense -showProgress install com.ibm.websphere.DEVELOPERSILAN.v85_8.5.5000.20130514_1044 -repositories  /opt/software/IBM/was/repository.config


#create a default profile
WORKDIR /opt/IBM/WebSphere/AppServer/bin
RUN ./manageprofiles.sh -create -templatePath /opt/IBM/WebSphere/AppServer/profileTemplates/default/

WORKDIR /tmp
RUN chmod +x startWebsphere.sh




