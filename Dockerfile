# Build the manager binary
FROM registry.access.redhat.com/ubi9/go-toolset:1.20.10-6 as builder
WORKDIR /go/src/github.com/openshift/cluster-nfd-operator

# Build
COPY . .
RUN make build

# Create production image for running the operator
FROM registry.access.redhat.com/ubi9/ubi-minimal:9.4

ARG CSV=4.14
COPY --from=builder /go/src/github.com/openshift/cluster-nfd-operator/node-feature-discovery-operator /

RUN mkdir -p /opt/nfd
COPY build/assets /opt/nfd
COPY manifests /manifests

# Run as unprivileged user
USER 65534:65534

ENTRYPOINT ["/node-feature-discovery-operator"]
LABEL io.k8s.display-name="node-feature-discovery-operator" \
      io.k8s.description="This is the image for the Node Feature Discovery Operator."
