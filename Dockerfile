FROM alpine

LABEL maintainer="Bogdan Dodoiu <bdodoiu@gmail.com>" \
      description="Kubectl with Kustomize. Useful for Gitlab CI jobs for deployment"

ENV KUBECTL_VERSION="v1.13.2"
ENV KUSTOMIZE_VERSION 1.0.11

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/bdodoiu/kubectl-kustomize" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.docker.dockerfile="/Dockerfile"


RUN apk add --update ca-certificates \
  && apk add --update -t deps curl \
  && curl -L  https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64 -o /usr/local/bin/kustomize \
  && chmod +x /usr/local/bin/kustomize \
  && apk del --purge deps \
  && rm /var/cache/apk/*

ENTRYPOINT ["kubectl"]
CMD ["help"]