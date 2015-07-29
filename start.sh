#!/bin/bash
/opt/logstash-1.4.1/bin/logstash -f /etc/logstash/logstash.conf -l /var/log/logstash.log & java -classpath escrow-jar-with-dependencies.jar com.pearson.grid.escrow.Main
