# GitHub repo. content

Scripts and stuff for building a Docker image of :
* the [Datalift](http://datalift.org/) data elevation platform,
* backed by the [RDF4J](http://rdf4j.org/) triple store,
* both hosted by a Tomcat 8.5 servlet container.

# Launching Datalift + RDF4J

On the host machine, launch :

	docker run -d --name='datalift1' -p 8080:8080 -v **rdf4j-data**:/rdf4j-data -v **datalift-home**:/datalift-home daxid/datalift_with_rdf4j

after replacing ```**rdf4j-data**``` and ```**datalift-home**``` by absolute paths where you whant them to be on the host.

# Runtime informations

No login/pwd are recquiered to access RDF4J workbench

The following services should be accessible :
* http://localhost:8080/rdf4j-workbench
* http://localhost:8080/rdf4j-server
* http://localhost:8080/datalift/project (with username ```datalft``` an password ```test```)
* http://localhost:8080/datalift/sparql

Users and passwords for datalift project page can be managed in ```datalift-home/conf/datalift-users.properties```
