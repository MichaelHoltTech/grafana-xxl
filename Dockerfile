FROM phusion/baseimage:0.9.15
MAINTAINER Michael Holt michael@mholt.tech

#ENV Variables
ENV GRAFANA_VERSION 3.0.0-pre1

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN mkdir /etc/service/grafana
ADD grafana.sh /etc/service/grafana/run

RUN chmod +x /etc/service/grafana/run && apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

### Install Grafana ###
RUN  apt-get -y --no-install-recommends install libfontconfig curl ca-certificates git && \
  curl https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb > /tmp/grafana.deb && \
  dpkg -i /tmp/grafana.deb && \
  rm /tmp/grafana.deb

### Install Zabbix Plugin ### && \
RUN \
  git clone -b develop https://github.com/alexanderzobnin/grafana-zabbix /tmp/grafana-zabbix && \
  mv /tmp/grafana-zabbix/plugins/* /usr/share/grafana/public/app/plugins/ && \
  rm -rf /tmp/grafana-zabbix/ && \
  sleep 10

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000
