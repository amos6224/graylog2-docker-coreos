Graylog2 CoreOS Cluster
=======================

Container-based deployment of Graylog2 on CoreOS. Includes:

  * Graylog2-server container
  * Graylog2-web container
  * systemd service files for CoreOS's fleet

## Origin
- originally cloned from [falloutdurham/graylog2-docker-cluster](https://github.com/falloutdurham/graylog2-docker-cluster)
- removed elasticsearch and mongo components
- switched to using DNS ([skydns](https://github.com/skynetservices/skydns) and [registrator](https://github.com/gliderlabs/registrator)) for service discovery instead of raw etcd

## Instructions (for CoreOS)

- Install [flanneld](https://coreos.com/flannel/docs/latest/flannel-config.html) for a flat IP network across containers

- Install [skydns](https://github.com/skynetservices/skydns)

- Install [registrator](https://github.com/gliderlabs/registrator)

- Start a Mongo service.
Make sure it registers its hosts under *.mongo.skydns.local

- Start an elasticsearch cluster.
Make sure it registers its hosts under *.elasticsearch.skydns.local

### Graylog2-server

```
fleetctl submit graylog2-server@{1,2,3}.service
fleetctl start graylog2-server@{1,2,3}.service
```

### Graylog2-web

```
fleetctl submit graylog2-web@1.service
fleetctl start graylog2-web@1.service
```

## Notes

Graylog2-server and Elasticsearch containers must currently run on different CoreOS machines (enforced in the service files).

Admin password is currently `yourpasswd`, but this can be changed if a `PASSWORD` environment variable is set and passed into the docker run command in the graylog2-server service file.

Currently, service files point to containers located at DockerHub. These should be changed to point at your own images.


### Dependencies

* ElasticSearch
  * Run separately
  * Services should be advertised in DNS as *.elasticsearch.skydns.local

* Mongo
  * Run separately
  * Services should be advertised in DNS as *.mongo.skydns.local


### Docker Environment Variables

* Graylog2-Server
  * `ELASTICSEARCH_HOSTS` - comma-separated list of ES hosts
  * `MONGODB_HOST` - as above but for MongoDB
  * `HOST_IP` - external IP for graylog2 to announce (binds to external ports, so again, one server per CoreOS host
  * `PASSWORD` - to override default password, pass in a sha256 hash, e.g. `echo -n yourpassword | shasum -a 256`

* Graylog2-Web
  * `GRAYLOG2_HOSTS` - list of Graylog2-server hosts  





