FROM registry.access.redhat.com/ubi9/ubi-minimal:9.3 AS builder

ARG NODE_FEATURE_DISCOVERY_IMAGE=quay.io/openshift/origin-node-feature-discovery:4.15
ARG CLUSTER_NFD_OPERATOR

COPY . .
RUN microdnf update -y \
    && microdnf install -y python3-jinja2 \
    && microdnf clean all

RUN ls -l
RUN rhtap/render_templates.py -t rhtap/nfd.clusterserviceversion.yaml.j2 \
        -r manifests/stable/nfd.clusterserviceversion.yaml \
        node_feature_discovery_image=${NODE_FEATURE_DISCOVERY_IMAGE} \
        cluster_nfd_operator=${CLUSTER_NFD_OPERATOR}

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
