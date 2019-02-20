FROM tomcat:7-jre8

ENV CATALINA_BASE:   /usr/local/tomcat
ENV CATALINA_HOME:   /usr/local/tomcat
ENV CATALINA_TMPDIR: /usr/local/tomcat/temp
ENV JRE_HOME:        /usr
ENV CLASSPATH:       /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar

RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
RUN apt-get update
RUN apt-get install -y git
RUN apt-get update
RUN apt-get install -y maven

RUN git clone http://a.denisova:Universeworks@qa-gitlab.itransition.corp/automation/docker-test-task.git 
WORKDIR docker-test-task
RUN mvn clean package
RUN cp ./target/*.war $CATALINA_HOME/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]
