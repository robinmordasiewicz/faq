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
from diagrams.onprem.network import Istio
from diagrams.generic.device import Mobile

graph_attr = {
    "fontsize": "28",
    "bgcolor": "transparent"
}

with Diagram(name="F5 BIG-IP NEXT - Cloud Native Solutions", show=False, direction="LR", filename="SPK-diagram", outformat="png", graph_attr=graph_attr):

    userequipment = Mobile("Subscribers")
    spk = Nginx("Service Proxy")
    
    userequipment - spk
    servicemesh = Istio("Service Mesh")

    with Cluster("BIG-IP NEXT"):
        diameter = Pod("")
        spk - diameter
        sip = Pod("")
        spk - sip
        http2 = Pod("")
        spk - http2
    with Cluster("Kubernetes"):
        with Cluster("Diameter"):
            workers = [Pod(""),
                       Pod(""),
                       Pod("")]
        with Cluster("SIP"):
            spk - Edge(color="brown") - sip
        with Cluster("HTTP/2"):
            spk - Edge(color="black") - http2

