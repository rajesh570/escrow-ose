FROM java:7

# Install Logstash 1.4.1.
RUN curl -SL https://download.elasticsearch.org/logstash/logstash/logstash-1.4.1.tar.gz | tar xfz - -C /opt/
RUN mkdir -p /etc/logstash/
RUN mkdir -p /var/log/escrow
RUN touch /var/log/escrow/escrow-logback.log
RUN mkdir -p /etc/logstash/patterns

COPY logstash.conf /etc/logstash/logstash.conf
COPY logstash-template.json /etc/logstash/logstash-template.json
COPY logstash.pattern /etc/logstash/patterns/logstash.pattern

COPY start.sh /usr/local/bin/start.sh
RUN chmod 555 /usr/local/bin/start.sh

EXPOSE 80

RUN curl -O http://jenkins-registrar.dev-prsn.com:8080/view/PaaS%20POC/job/openshift-deploy-escrow/lastSuccessfulBuild/artifact/service/target/escrow-jar-with-dependencies.jar

RUN curl -O http://jenkins-registrar.dev-prsn.com:8080/view/PaaS%20POC/job/openshift-deploy-escrow/lastSuccessfulBuild/artifact/service/config/environment.properties

RUN curl -O http://jenkins-registrar.dev-prsn.com:8080/view/PaaS%20POC/job/openshift-deploy-escrow/lastSuccessfulBuild/artifact/service/config/version.properties
RUN mkdir -p config/dev
RUN mv version.properties config/dev

RUN curl -O http://jenkins-registrar.dev-prsn.com:8080/view/PaaS%20POC/job/openshift-deploy-escrow/lastSuccessfulBuild/artifact/service/config/logback.xml

ENTRYPOINT ["/usr/local/bin/start.sh"]