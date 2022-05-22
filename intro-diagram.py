# diagram.py
from diagrams import Cluster, Diagram, Node, Edge
from diagrams.k8s.compute import Pod
from diagrams.k8s.network import Ing
from diagrams.gcp.network import LoadBalancing
from diagrams.onprem.network import Nginx

with Diagram("Cluster nesting", show=False):

    sipprotocol = LoadBalancing("SIP")

    with Cluster("Kubernetes"):

        with Cluster("Nginx"):
            nginx= Nginx("")

        with Cluster("MyApp"):
            myapp_ing = Ing("")
            with Cluster("Pods"):
                myapp_pods = Pod("myapp")

        with Cluster("MySQL"):
            myapp_db = Pod("myapp-db")

    sipprotocol >> Edge(headport="c", tailport="c", minlen="1", lhead='cluster_Kubernetes') >> nginx
    nginx >> Edge(headport="c", tailport="c", minlen="1", lhead='cluster_MyApp') >> myapp_ing >> Edge(headport="c", tailport="c", minlen="1", lhead='cluster_MyApp pods') >> myapp_pods >> myapp_db
