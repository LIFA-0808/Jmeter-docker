FROM openjdk:11.0-jdk-slim

ARG JMETER_VERSION="5.4.1"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}

ENV JMETER_BIN ${JMETER_HOME}/bin
ENV JMETER_DOWNLOAD_URL https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

RUN mkdir /tmp/dependencies/
RUN apt-get update
RUN apt-get -y install curl
RUN	curl -L --silent ${JMETER_DOWNLOAD_URL} > /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz

RUN tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt && \
    rm -rf /tmp/dependencies

# Set global PATH such that "jmeter" command is found
ENV PATH $PATH:$JMETER_BIN

COPY plugins/lib/*.jar ${JMETER_HOME}/lib/
COPY plugins/lib/ext/*.jar ${JMETER_HOME}/lib/ext/

RUN mkdir /opt/JMeter-configs/

WORKDIR	${JMETER_HOME}

# COPY test.jmx /opt/JMeter-configs/

# ENTRYPOINT ["java", "-Dcom.sun.management.jmxremote", \
#	"-Dcom.sun.management.jmxremote.port=12345", \
#	"-Dcom.sun.management.jmxremote.ssl=false", \
#	"-Dcom.sun.management.jmxremote.authenticate=false", \
#	"-jar", "/opt/JMeter/bin/ApacheJMeter.jar", "-n", "-t"]
