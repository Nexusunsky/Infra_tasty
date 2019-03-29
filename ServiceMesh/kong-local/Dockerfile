FROM ubuntu:bionic

WORKDIR /service-mesh

# Install Tool for ubuntu
RUN apt update && \
    apt install -y apt-transport-https wget ca-certificates curl software-properties-common netcat nmap openssl libpcre3 procps perl && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# Install Docker
RUN apt update && \
    apt-cache policy docker-ce && \
    apt install -y docker-ce

COPY kong.conf /service-mesh/kong.conf

RUN mkdir /service-mesh/debs/ && \
    wget https://bintray.com/kong/kong-community-edition-deb/download_file?file_path=dists/kong-community-edition-1.1.0.bionic.all.deb -O /service-mesh/debs/kong.deb && \
    dpkg -i /service-mesh/debs/kong.deb

CMD [ "sh" ]
