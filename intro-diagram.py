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

with Diagram(name="BIG-IP NEXT - Service Proxy for Kubernetes", show=False):
    ingress = Ing("")

    servicemesh = Istio("Service Mesh")
    servicemesh << Edge(color="firebrick", style="dashed") << Grafana("monitoring")

    with Cluster("BIG-IP NEXT"):
        grpcsvc = [
            Server("Service Proxy")]

    with Cluster("Diameter"):
        primary = Pod("")
        primary \
            - Edge(color="brown", style="dotted") \
            - Pod("") \
            << Edge(label="") \
            << servicemesh
        grpcsvc >> Edge(color="brown") >> primary

    with Cluster("SIP"):
        primary = Pod("")
        primary \
            - Edge(color="brown", style="dotted") \
            - Pod("") \
            << Edge(label="") \
            << servicemesh
        grpcsvc >> Edge(color="brown") >> primary

    with Cluster("HTTP/2"):
        primary = Pod("")
        primary \
            - Edge(color="brown", style="dotted") \
            - Pod("") \
            << Edge(label="") \
            << servicemesh
        grpcsvc >> Edge(color="black") >> primary

