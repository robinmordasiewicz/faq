from diagrams import Cluster, Diagram, Edge
from diagrams.onprem.analytics import Spark
from diagrams.onprem.compute import Server
from diagrams.onprem.database import PostgreSQL
from diagrams.onprem.inmemory import Redis
from diagrams.onprem.aggregator import Fluentd
from diagrams.onprem.monitoring import Grafana, Prometheus
from diagrams.onprem.network import Nginx
from diagrams.onprem.queue import Kafka
from diagrams.k8s.compute import Pod
from diagrams.k8s.network import Ing
from diagrams.k8s.network import SVC
from diagrams.k8s.compute import RS
from diagrams.onprem.network import Istio
from diagrams.generic.device import Mobile

graph_attr = {
    "fontsize": "36",
    "bgcolor": "transparent"
}
node_attr = {
    "fontsize": "29",
    "bgcolor": "white"
}

with Diagram(name="F5 Cloud Native Solutions", show=False, direction="LR", filename="SPK-diagram", outformat="png", graph_attr=graph_attr,node_attr=node_attr):

    subscribers = Mobile("Subscribers")
    with Cluster("BIG-IP NEXT"):
        spk = Nginx("Service Proxy")
        subscribers - spk
    with Cluster("Kubernetes"):
        with Cluster("Diameter"):
            diameter = RS("")
            spk - diameter
        with Cluster("SIP"):
            sip = RS("")
            spk - sip
        with Cluster("HTTP/2"):
            http2 = RS("")
            spk - http2
        servicemesh = Istio("Service Mesh")
        diameter - servicemesh
        sip - servicemesh
        http2 - servicemesh
