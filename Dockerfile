FROM grafana/tanka:0.13.0 AS dependencies
ENV DEPLOY_HOME /app/jsonnet/deploy
RUN mkdir -p $DEPLOY_HOME
WORKDIR $DEPLOY_HOME

FROM dependencies AS builder
ENV OUTPUT_HOME /app/jsonnet-deploy-dist
COPY ./ /app/jsonnet/

RUN tk export environments/default $OUTPUT_HOME
# find output in builder image, at: /app/jsonnet-deploy-dist
# or attach your own builder process and run with GitHub Actions

FROM dependencies AS no-target
# outer "dependencies" and "no-target" stages ensure Docker Hub builds
# dependencies image without any outside direction (use with eg. Okteto)
