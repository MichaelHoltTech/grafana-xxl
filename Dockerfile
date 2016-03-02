FROM debian:jessie
MAINTAINER Jan Garaj info@monitoringartist.com

# inbuilt datasources:
# cloudwatch elasticsearch grafana graphite influxdb mixed opentsdb prometheus
# sql kairosdb

ENV GRAFANA_VERSION 3.0.0-pre1

COPY ./run.sh /run.sh

RUN \
  apt-get update && \
  apt-get -y --no-install-recommends install libfontconfig curl ca-certificates git && \
  curl https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb > /tmp/grafana.deb && \
  dpkg -i /tmp/grafana.deb && \
  rm /tmp/grafana.deb && \
  curl -L https://github.com/tianon/gosu/releases/download/1.5/gosu-amd64 > /usr/sbin/gosu && \
  chmod +x /usr/sbin/gosu
  ### zabbix ### && \
RUN \
  git clone -b develop https://github.com/alexanderzobnin/grafana-zabbix /tmp/grafana-zabbix && \
  mv /tmp/grafana-zabbix/plugins/* /usr/share/grafana/public/app/plugins/ && \
  rm -rf /tmp/grafana-zabbix/ && \
  sleep 10
RUN \
  apt-get update && \
  chmod +x /run.sh && \
  apt-get remove -y curl git && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*  

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

ENTRYPOINT ["/run.sh"]
