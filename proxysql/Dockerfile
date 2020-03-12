FROM registry.hub.docker.com/severalnines/proxysql:2.0.8

COPY proxysql.cnf /etc/proxysql.cnf

CMD ["proxysql", "-f", "-c", "/etc/proxysql.cnf"]

