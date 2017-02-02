FROM ubuntu:14.04
RUN apt-get update && apt-get -y upgrade

RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y update

# Accept the license
RUN echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections

RUN apt-get -y install oracle-java7-installer maven
# Here comes the tomcat installation
# Expose the default tomcat port
# Start the tomcat (and leave it hanging)i
RUN wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.14/bin/apache-tomcat-8.0.14.tar.gz

RUN mkdir /usr/local/tomcat

RUN mv apache-tomcat-8.0.14.tar.gz /usr/local/tomcat 

RUN cd /usr/local/tomcat && tar -zxvf apache-tomcat-8.0.14.tar.gz

RUN mkdir /mohit

ADD Test_Project /mohit/

RUN cd /mohit && mvn clean install 

RUN mv /mohit/target/Test_Project /usr/local/tomcat/apache-tomcat-8.0.14/webapps

#RUN mvn clean install 

#RUN mv /root/target/Test_Project /usr/local/tomcat/apache-tomcat-8.0.14/bin/webapps/

EXPOSE 8080
CMD ["/usr/local/tomcat/apache-tomcat-8.0.14/bin/catalina.sh", "run"]
#CMD service tomcat7 start
