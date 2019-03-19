FROM kong:1.0.3-centos

# TODO: Remove the requirement for netcat
RUN yum update -y && yum install gcc gcc-c++ openssl openssl-devel make unzip nc git ruby -y

RUN luarocks install lbase64 && \
        luarocks install lua-cjson && \
        luarocks install luacrypto && \
        luarocks install inspect

RUN mkdir -p /opt/kong-custom-plugin/
ADD plugins/ /opt/kong-custom-plugin/

RUN cd /opt/kong-custom-plugin/kong-okta-auth-plugin && \
    luarocks make && \
    cd /opt/kong-custom-plugin/kong-plugin-stdout-log && \
    luarocks make

COPY finish/ /usr/local/bin/

CMD ["/usr/local/bin/start-kong.sh"]
