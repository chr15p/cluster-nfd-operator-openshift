FROM registry.access.redhat.com/ubi9/ubi:9.3 AS builder

ARG NODE_FEATURE_DISCOVERY_IMAGE=quay.io/redhat-user-workloads/rhn-gps-cprocter-tenant/openshift-node-feature-discovery/openshift-node-feature-discovery@sha256:4e8ffa744dadae44e85e380f015bbe4f4a5ed908f09c26c090b5ae11eb6de2c8
ARG CLUSTER_NFD_OPERATOR

COPY . .

RUN ls -l
RUN rhtap/render_templates.py -t manifests/stable/manifests/nfd.clusterserviceversion.yaml \
        -r manifests/stable/manifests/nfd.clusterserviceversion.yaml \
        quay.io/openshift/origin-node-feature-discovery=${NODE_FEATURE_DISCOVERY_IMAGE} \ 
        quay.io/openshift/origin-cluster-nfd-operator=${CLUSTER_NFD_OPERATOR}

FROM scratch

# Core bundle labels.
LABEL operators.operatorframework.io.bundle.mediatype.v1=registry+v1
LABEL operators.operatorframework.io.bundle.manifests.v1=manifests/
LABEL operators.operatorframework.io.bundle.metadata.v1=metadata/
LABEL operators.operatorframework.io.bundle.package.v1=nfd
LABEL operators.operatorframework.io.bundle.channels.v1=stable
LABEL operators.operatorframework.io.bundle.channel.default.v1=stable
LABEL operators.operatorframework.io.metrics.project_layout=go.kubebuilder.io/v3
LABEL operators.operatorframework.io.metrics.mediatype.v1=metrics+v1
LABEL operators.operatorframework.io.metrics.builder=operator-sdk-v1.4.0+git

# Labels for testing.
LABEL operators.operatorframework.io.test.mediatype.v1=scorecard+v1
LABEL operators.operatorframework.io.test.config.v1=tests/scorecard/

# Copy files to locations specified by labels.
COPY --from=builder /manifests/stable/manifests /manifests/
COPY --from=builder /manifests/stable/metadata /metadata/
