# Docker Datalift data elevation platform
#

FROM tomcat:8.5
#FROM yyz1989/rdf4j
MAINTAINER daXid

# Install
RUN apt-get -qq update && apt-get install --fix-missing -y --force-yes \
	openjdk-8-jdk \
	ant \
	git


# RDF4J
ENV RDF4J_VERSION="2.1.4" 
ENV RDF4J_DATA="/rdf4j-data" 
ENV JVM_PARAMS="-Xmx4g" 
RUN curl -sS -o /tmp/rdf4j.zip -L http://download.eclipse.org/rdf4j/eclipse-rdf4j-${RDF4J_VERSION}-sdk.zip && \
	cd /opt && \ 
	unzip /tmp/rdf4j.zip && \ 
	rm /tmp/rdf4j.zip 
RUN mv /opt/eclipse-rdf4j-${RDF4J_VERSION}/war/*.war /usr/local/tomcat/webapps

RUN echo "CATALINA_OPTS=\"\$CATALINA_OPTS \$JVM_PARAMS -Dorg.eclipse.rdf4j.appdata.basedir=\$RDF4J_DATA\"" >> /usr/local/tomcat/bin/setenv.sh

# Set environment
ENV DATALIFT_HOME /datalift-home
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
#RUN env

WORKDIR /

COPY datalift-home /datalift-home
RUN git clone https://scm.gforge.inria.fr/anonscm/git/datalift/datalift.git

WORKDIR /datalift

#Build Datalift
RUN ant dist

# Move datalift core app to Tomcat war directory
RUN mv core/target/datalift.war /usr/local/tomcat/webapps

# Datalift modules
#RUN mv data2ontology/dist/data2ontology.jar /datalift-home/modules/
#RUN mv database-directmapper/dist/database-directmapper.jar /datalift-home/modules/
#RUN mv flint-endpoint/dist/flint-endpoint.jar /datalift-home/modules/
#RUN mv framework/dist/datalift-framework-0.9.0.jar /datalift-home/modules/
#RUN mv geomrdf/dist/geomrdf.jar /datalift-home/modules/
#RUN mv limes-interlinker/dist/limes-interlinker.jar /datalift-home/modules/
#RUN mv lov/catalogue/dist/lov-catalogue.jar /datalift-home/modules/
#RUN mv mvn-repo/dist/mvn-repo.jar /datalift-home/modules/
#RUN mv projectmanager/dist/project-manager.jar /datalift-home/modules/
#RUN mv s4ac/dist/s4ac.jar /datalift-home/modules/
#RUN mv silk-interlinker/dist/silk-interlinker.jar /datalift-home/modules/
#RUN mv simple-convert/dist/simple-converters.jar /datalift-home/modules/
#RUN mv skos-viewer/dist/skos-viewer.jar /datalift-home/modules/
#RUN mv sparql-endpoint/dist/sparql-endpoint.jar /datalift-home/modules/
#RUN mv sparql2viz-endpoint/dist/sparql2viz-endpoint.jar /datalift-home/modules/
#RUN mv stringtouri/dist/stringtouri.jar /datalift-home/modules/
#RUN mv ui-sample/dist/ui-sample.jar /datalift-home/modules/
#RUN mv virtuoso-connector/dist/virtuoso-connector.jar /datalift-home/modules/
#RUN mv visualization/dist/visualization.jar /datalift-home/modules/
#RUN mv wfs2rdf/dist/wfs2rdf.jar /datalift-home/modules/


#RUN echo "CATALINA_OPTS=\"-Ddatalift.home=\$DATALIFT_HOME\"" >> /usr/local/tomcat/bin/setenv.sh

VOLUME ${DATALIFT_HOME}
VOLUME ${RDF4J_DATA}

EXPOSE 8080

