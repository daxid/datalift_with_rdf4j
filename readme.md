# Prepare Host file system for data persistence

On your host, copy datalift-home and rdf4j-data folders in a folder of your choice.

# Launching datalift + rdf4j

Go to the folder containing the persistent data (the one where you previously copied rdf4j-data and datalift-home) and launch :

	docker run --name='datalift1' -p 8080:8080 -v rdf4j-data:/rdf4j-data -v datalift-home:/datalift-home daxid/datalift_with_rdf4j
