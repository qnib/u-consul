### QNIBTerminal ubuntu image
FROM qnib/u-supervisor

RUN apt-get update && \
    apt-get install -y bsdtar curl
ENV TERM=xterm \
    CONSUL_VER=0.6.4 \
    BOOTSTRAP_CONSUL=false \
    RUN_SERVER=false \
    CT_VER=0.14.0
RUN apt-get update && \
    apt-get install -y bsdtar curl
RUN curl -fsL https://releases.hashicorp.com/consul/${CONSUL_VER}/consul_${CONSUL_VER}_linux_amd64.zip | bsdtar xf - -C /usr/local/bin/ \
 && chmod +x /usr/local/bin/consul
RUN mkdir -p /opt/consul-web-ui/ \
 && curl -fsL https://releases.hashicorp.com/consul/${CONSUL_VER}/consul_${CONSUL_VER}_web_ui.zip |bsdtar xf - -C /opt/consul-web-ui/ \
 && unset CONSUL_VER
RUN curl -Lsf https://releases.hashicorp.com/consul-template/${CT_VER}/consul-template_${CT_VER}_linux_amd64.zip |bsdtar xf - -C /usr/local/bin/ \
 && chmod +x /usr/local/bin/consul-template \
 && unset CT_VER

ADD etc/consul.json /etc/consul.json
ADD etc/supervisord.d/consul.ini /etc/supervisord.d/
ADD opt/qnib/consul/bin/start.sh /opt/qnib/consul/bin/
ADD opt/qnib/consul/etc/bash_functions.sh /opt/qnib/consul/etc/
