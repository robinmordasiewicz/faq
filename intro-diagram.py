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
from diagrams.custom import Custom

global_attr = {
    "fontsize": "24",
    "bgcolor": "transparant",
    "fontcolor": "#000000",
    "fontname": "Arial"
}
k8s_attr = {
    "fontsize": "24",
    "bgcolor": "#E0E0E0",
    "fontcolor": "#326ce5",
    "fontname": "Arial"
}
spk_attr = {
    "fontsize": "22",
    "bgcolor": "#0E487A",
    "fontcolor": "#FFFFFF",
    "fontname": "Arial"
}
node_attr = {
    "fontsize": "16",
    "fontcolor": "#000000",
    "fontname": "Arial"
}
edge_attr = {
    "fontsize": "18",
    "bgcolor": "blue",
    "fontcolor": "#FFFFFF"
}

with Diagram(name="F5 Cloud Native Solutions", show=False, direction="LR", filename="SPK-diagram", outformat="png", graph_attr=global_attr,node_attr=node_attr,edge_attr=edge_attr):

    subscribers = Mobile("Subscribers")
    with Cluster("BIG-IP NEXT",graph_attr=spk_attr):
        spk = Custom("Service Proxy<br>SIP<br>HTTP2</br>Diameter", "f5-logo-white.png")
        subscribers - spk
    with Cluster("Kubernetes",graph_attr=k8s_attr):
        diameter = RS("Diameter")
        spk - diameter
        sip = RS("SIP")
        spk - sip
        http2 = RS("HTTP/2")
        spk - http2
        servicemesh = Istio("Service Mesh")
        diameter - servicemesh
        sip - servicemesh
        http2 - servicemesh
