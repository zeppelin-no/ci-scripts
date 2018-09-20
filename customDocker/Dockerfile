FROM docker:18.03-git
LABEL maintainer="Stein Strindhaug <stein.strindhaug@gmail.com>"

RUN apk add gettext python3
RUN pip3 install awscli

ADD https://storage.googleapis.com/kubernetes-release/release/v1.8.7/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
