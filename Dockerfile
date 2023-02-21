FROM gradle:8.0.0-jdk17-alpine AS build
COPY --chown=gradle:gradle . /caesar-cipher/src
WORKDIR /caesar-cipher/src
RUN gradle build
RUN gradle test

FROM openjdk:17-jdk-slim

RUN mkdir /app

COPY --from=build /caesar-cipher/src/build/libs/*.jar /app/caeser-cipher.jar

ENTRYPOINT [ "java", "-jar", "/app/caeser-cipher.jar"]


