# syntax=docker/dockerfile:1.3
# start with build image
FROM node:v22.3.0-alpine AS BUILD_IMAGE

# set work directory
WORKDIR /app

# install app dependencies
COPY . ./
RUN npm install -g npm@10.8.1
RUN npm install --legacy-peer-deps

# runtime image
FROM node:v22.3.0-alpine
RUN apk add bash

# add (non-sudo) user
ENV USER=user
ENV UID=8888
ENV GID=9999

RUN addgroup \
    --gid $GID \
    $USER

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --ingroup "$USER" \
    --no-create-home \
    --uid "$UID" \
    "$USER"

# set work directory
WORKDIR /app
RUN chown -R $USER:$USER /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# change user
USER $USER

# copy from build image
COPY --from=BUILD_IMAGE \
    --chown=$USER:$USER \
    /app/node_modules ./node_modules

# amend scss file affecting bootstrap compilation
# RUN sed -i 's/append($return, max($value, 0))/append($return, $value)/' /app/node_modules/bootstrap/scss/mixins/_border-radius.scss

# add app
COPY --chown=$USER:$USER \
    . /app

RUN ls -lrt

# expose port
EXPOSE 3000

# Ensure the script is executable
RUN ["chmod", "+x", "start.sh"]
# start app
CMD ["bash", "start.sh"]
