#!/bin/bash
#
# This script does four things : 
# - initialize RDF4J repositories to work with Datalift (if not already present from a previous install in an update scenario)
# - initialise Datalift runtime environment (it preserves files existing from a previous install in an update scenario)
# - copy Datalift modules in the right directory (replacing existing ones, after all, we want to install or update...)
# - invoque Tomcat launch script

set -e

if [ ! -d /rdf4j-data/server ]; then
  # First time
  echo "###################################"
  echo "Initializing RDF4J"
  echo ""
  unzip -u /rdf4j-data.zip
  echo ""
  echo "###################################"
fi

echo "###################################"
echo "Initializing Datalift"
echo ""
unzip -u -n /datalift-home.zip
cp /datalift-modules/*.jar /datalift-home/modules/
echo ""
echo "###################################"

exec catalina.sh run
