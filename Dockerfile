# BUILD DOCKER IMAGE
FROM openjdk:8-jre

LABEL maintainer="SmartRent"
# ADD MAVEN LIBS
COPY target/classes/libs /opt/app/libs/

# ADD SERVICE LIB
COPY  target/logs-aggregator-service.jar /opt/app/app.jar

EXPOSE 9411
ENTRYPOINT ["java", \
           # Enable JMX
           "-Dcom.sun.management.jmxremote", \
           "-Dcom.sun.management.jmxremote.rmi.port=1088", \
           "-Dcom.sun.management.jmxremote.port=1088", \
           "-Dcom.sun.management.jmxremote.authenticate=false", \
           "-Dcom.sun.management.jmxremote.local.only=false", \
           "-Dcom.sun.management.jmxremote.ssl=false", \
           # Memory settings
           "-XX:+UseContainerSupport", \
           "-XX:MaxRAMPercentage=75.0", \
           "-classpath", "/opt/app/libs", \
           # Service entry point
           "-jar", "/opt/app/lib/zipkin-server-2.20.0-exec.jar", "--logging.level.zipkin2=DEBUG"]
#           "-jar", "/opt/app/app.jar", "--logging.level.zipkin2=DEBUG"]
