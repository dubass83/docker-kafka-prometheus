FROM wurstmeister/kafka:2.12-2.0.1

# prometheus
ADD https://raw.githubusercontent.com/prometheus/jmx_exporter/master/example_configs/kafka-0-8-2.yml /usr/app/prometheus-config.yml
ADD https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.6/jmx_prometheus_javaagent-0.6.jar /usr/app/jmx_prometheus_javaagent.jar
RUN chmod +r /usr/app/jmx_prometheus_javaagent.jar

# unset KAFKA_OPTS and KAFKA_JMX_OPTS in create-topics.sh scripts to eliminate "address already in use" error because of the javaagent
RUN sed -i 's#while netstat#export KAFKA_OPTS=\nexport KAFKA_JMX_OPTS=\nwhile netstat#g' /usr/bin/create-topics.sh
