## Docker Compose for Activating Services that Needs Data Persistence

The application containers are dependent on the various services. This docker-compose is used for those services and it will be available for all containers on the same network. The services runs on default network.

#### How to activate all services containers?
If we need to activate all the service containers, run `$ docker-compose up`

#### How to activate selective service containers?
Run docker-compose up **service**. eg. `$ docker-compose up mysql`

### Access PHPMyAdmin
Activate the phpmyadmin service and access it from [phpmyadmin.local](http://phpmyadmin.local). Enter host `mysql` and username, password as configured.