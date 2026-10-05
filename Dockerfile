# Multi-stage build using Maven and Eclipse Temurin JDK 21
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app

# Copy POM and source code
COPY pom.xml .
COPY src ./src

# Build the WAR artifact
RUN mvn clean package -DskipTests

# Run stage using Official Apache Tomcat 10.1 with Temurin JDK 21
FROM tomcat:10.1-jdk21-temurin

# Clean default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy built WAR as ROOT application
COPY --from=build /app/target/FashionStore-*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
