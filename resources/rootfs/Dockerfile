FROM zhaokundev/maven-mysql:mvn3.5.3-jdk8-sql5.7-slim AS builder

COPY     pom.xml /eurekaserver/pom.xml

WORKDIR  /eurekaserver

RUN 	 cd /eurekaserver/ && mvn dependency:go-offline -B

COPY     src /eurekaserver/src
COPY     resources /eurekaserver/resources

RUN      mvn package

FROM openjdk:8u171-jdk-slim

RUN mkdir /eurekaserver

COPY --from=builder /eurekaserver/target/eurekaserver-0.0.1-SNAPSHOT.jar /eurekaserver
COPY --from=builder /eurekaserver/resources/scripts/bootstrap.sh  /

VOLUME /tmp

WORKDIR /eurekaserver

EXPOSE 8761

CMD [ "/bootstrap.sh" ]
