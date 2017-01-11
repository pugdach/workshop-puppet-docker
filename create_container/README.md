# Create Docker containers from Puppet code

## Directly building containers

    cd examples/nginx

run

    puppet docker build

The above command uses the metadata.yaml file
You can overwrite data on command line

    puppet docker build --image-name puppet/sample --cmd nginx --expose 80

## Build Dockerfile

    puppet docker dockerfile

## Run container

    docker run -d -p 8080:80 puppet/nginx

## Building images from Puppet environment code and node classification

Install required Modules (e.g. Puppetfile or puppet module install)
Remember to also include the dummy_service Module!
Create roles and profiles.

Put a node classification into your puppet code manifests/site.pp

    node 'pugberlin' {
      contain role::demoserver
    }

Generate the container

    puppet docker build --image-name puppet/pugberlin

## Multiple containers

Put metadata.yaml into metadata directory. Put node specific metadata yaml files next to it

  - /metadata/
      |- metadata.yaml
      |- pugberlin.yaml
      |- ...

## Build containers from non masters

You can use node classification from master to build containers.
metadata.yaml file must be local or provide parameters on command line

    puppet docker dockerfile --master puppet.example.com --image-name puppet/node1 --expose 80 --cmd nginx

Attention: Node classification must be regular expression.
The hostname passed to the Puppet Master will take the form node1.{datetime}.dockerbuilder.

## Build containers without any visiblility of Puppet

Use rocker

    puppet docker build --rocker

