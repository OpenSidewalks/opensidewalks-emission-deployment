# OpenSidewalks e-mission deployment

This repo contains the deployment scripts and configs for the OpenSidewalks studies
that use e-mission. It is based on the use of `docker` containers using the
`docker-compose` version 3 orchestration framework.

## Structure of this repo and deployments

### Orchestration YAMLs

The `docker-compose` YAML files are in the top directory. By default, running
`docker-compose` in the top directory will cascade two configs: `docker-compose.yml`
and `docker-compose.override.yml`. The `override` config corresponds to a local dev
config with forwarded ports for all services.

### Service configs

Each software element is defined as a named service within the `docker-compose` YAMLs.

Configs for each service are are separated into development or production deployments,
so the configuration for the `caddy` (reverse proxy) service in development (default)
mode is in `dev/configs/caddy`.

### Persisted data

Data is persisted using a local directory structure that is similar to configs. For
example, in production mode the `mongodb` service stores its data in
`prod/data/mongodb`.

## Deploying in development mode

The default deployment mode is for development and testing purposes and can be
instantiated by running `docker-compose up` in the top level directory. The reverse
proxy will proxy the main e-mission service to `http://localhost:2015`, functionally
equivalent to whatever domain the production deployment is pushed to such as
`emission.mydomain.com`.

This mode will use the configs in `dev/configs` and persist data in `dev/data`.

## Deploying in production mode

To deploy in production mode, you must explicitly cascade the base and production
YML files. Starting the services would therefore be:
`docker-compose -f docker-compose.yml -f docker-compose.prod.yml up`. Manipulating any
of the services in production mode will require cascading these files, so keep this
in mind if you use a subcommand like `docker-compose logs`, as it will need to be
written as `docker-compose -f docker-compose.yml -f docker-compose.prod.yml logs`.

In addition, the host variable must be set as an environment variable. This is easiest
done using a `.env` file in the top level directory. `.env.example` is provided as an
example. Run `cp .env.example .env` and edit with plain text editor to configure.
