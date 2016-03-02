# Grafana-Zabbix 3.0

Thanks to [Jan Garaj](https://github.com/monitoringartist) for the original work on this.  This is based on his [Grafana-xxl](https://github.com/monitoringartist/grafana-xxl) image but updated for running Grafana 3.0 and using Phusion's Ubuntu Baseimage.


# Running your Grafana XXL Docker image

Start your image binding the external port 3000:

    docker run -d --name=grafana -p 3000:3000 michaelholttech/grafana-zabbix-3.0

Try it out, default admin user is admin/admin.

## Grafana XXL with persistent storage (recommended)

    # create /var/lib/grafana as persistent volume storage
    docker run -d -v /var/lib/grafana --name grafana-storage busybox:latest

    # start grafana
    docker run \
      -d \
      -p 3000:3000 \
      --name grafana \
      --volumes-from grafana-storage \
      michaelholttech/grafana-zabbix-3.0

## Running specific version of Grafana XXL

    # specify right tag, e.g. 2.6.0 - see Docker Hub for available tags
    docker run \
      -d \
      -p 3000:3000 \
      --name grafana \
      michaelholttech/grafana-zabbix-3.0:2.6.0

## Configuring your Grafana container

All options defined in conf/grafana.ini can be overriden using environment
variables, for example:

    docker run \
      -d \
      -p 3000:3000 \
      --name=grafana \
      -e "GF_SERVER_ROOT_URL=http://grafana.server.name" \
      -e "GF_SECURITY_ADMIN_PASSWORD=secret" \
      michaelholttech/grafana-zabbix-3.0

# Included plugins

See plugin projects also for documentation:

- [Zabbix](https://github.com/alexanderzobnin/grafana-zabbix)
