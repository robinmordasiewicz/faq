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

    with Cluster("BIG-IP NEXT"):
        spk - diameter
        spk - sip
        spk - http2

    with Cluster("Diameter"):
        diameter = Pod("")
        diameter \
            - Edge(color="brown", style="dotted") \
            - Pod("") \
            - Edge(label="") \
            - servicemesh
        spk - Edge(color="brown") - diameter

    with Cluster("SIP"):
        sip = Pod("")
        sip \
            - Edge(color="brown", style="dotted") \
            - Pod("") \
            - Edge(label="") \
            - servicemesh
        spk - Edge(color="brown") - sip

    with Cluster("HTTP/2"):
        http2 = Pod("")
        http2 \
            - Edge(color="brown", style="dotted") \
            - Pod("") \
            - Edge(label="") \
            - servicemesh
        spk - Edge(color="black") - http2

    servicemesh = Istio("Service Mesh")
