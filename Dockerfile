FROM homebrew/ubuntu20.04 AS dependencies
RUN brew install tanka jsonnet-bundler
ENV DEPLOY_HOME /home/linuxbrew/jsonnet/deploy
RUN mkdir -p $DEPLOY_HOME
WORKDIR $DEPLOY_HOME

FROM dependencies AS builder
ENV OUTPUT_HOME /home/linuxbrew/jsonnet-deploy-dist
COPY ./ /home/linuxbrew/jsonnet/

RUN tk export environments/default $OUTPUT_HOME
# find output in builder image, at: /home/linuxbrew/jsonnet-deploy-dist
# or attach your own builder process and run with GitHub Actions

FROM dependencies AS no-target
# outer "dependencies" and "no-target" stages ensure Docker Hub builds
# dependencies image without any outside direction (use with eg. Okteto)
