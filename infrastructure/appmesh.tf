# Mesh

resource "aws_appmesh_mesh" "mesh" {
  name = "${var.mesh_name}"
}

# VirtualNode

resource "aws_appmesh_virtual_node" "colorgateway" {
  mesh_name = "${aws_appmesh_mesh.mesh.name}"
  name = "colorgateway-vn"
  spec {
    backends = ["colorteller.${var.services_domain}", "tcpecho.${var.services_domain}"]
    listener {
      port_mapping {
        port = 9080
        protocol = "http"
      }
    }
    service_discovery {
      dns {
        service_name = "colorgateway.${var.services_domain}"
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "colorteller_black" {
  mesh_name = "${aws_appmesh_mesh.mesh.name}"
  name = "colorteller-black-vn"
  spec {
    listener {
      port_mapping {
        port = 9080
        protocol = "http"
      }
      # health_check {
      #   protocol = "http"
      #   path = "/ping"
      #   healthy_threshold = 2
      #   unhealthy_threshold = 2
      #   timeout_millis = 2000
      #   interval_millis = 5000
      # }
    }
    service_discovery {
      dns {
        service_name = "colorteller-black.${var.services_domain}"
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "colorteller_blue" {
  mesh_name = "${aws_appmesh_mesh.mesh.name}"
  name = "colorteller-blue-vn"
  spec {
    listener {
      port_mapping {
        port = 9080
        protocol = "http"
      }
      # health_check {
      #   protocol = "http"
      #   path = "/ping"
      #   healthy_threshold = 2
      #   unhealthy_threshold = 2
      #   timeout_millis = 2000
      #   interval_millis = 5000
      # }
    }
    service_discovery {
      dns {
        service_name = "colorteller-blue.${var.services_domain}"
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "colorteller_red" {
  mesh_name = "${aws_appmesh_mesh.mesh.name}"
  name = "colorteller-red-vn"
  spec {
    listener {
      port_mapping {
        port = 9080
        protocol = "http"
      }
      # health_check {
      #   protocol = "http"
      #   path = "/ping"
      #   healthy_threshold = 2
      #   unhealthy_threshold = 2
      #   timeout_millis = 2000
      #   interval_millis = 5000
      # }
    }
    service_discovery {
      dns {
        service_name = "colorteller-red.${var.services_domain}"
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "colorteller" {
  mesh_name = "${aws_appmesh_mesh.mesh.name}"
  name = "colorteller-vn"
  spec {
    listener {
      port_mapping {
        port = 9080
        protocol = "http"
      }
      # health_check {
      #   protocol = "http"
      #   path = "/ping"
      #   healthy_threshold = 2
      #   unhealthy_threshold = 2
      #   timeout_millis = 2000
      #   interval_millis = 5000
      # }
    }
    service_discovery {
      dns {
        service_name = "colorteller.${var.services_domain}"
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "tcpecho" {
  mesh_name = "${aws_appmesh_mesh.mesh.name}"
  name = "tcpecho-vn"
  spec {
    listener {
      port_mapping {
        port = 2701
        protocol = "tcp"
      }
      # health_check {
      #   protocol = "tcp"
      #   healthy_threshold = 2
      #   unhealthy_threshold = 2
      #   timeout_millis = 2000
      #   interval_millis = 5000
      # }
    }
    service_discovery {
      dns {
        service_name = "tcpecho.${var.services_domain}"
      }
    }
  }
}

# VirtualRouter

resource "aws_appmesh_virtual_router" "colorgateway" {
  mesh_name = "${aws_appmesh_mesh.mesh.name}"
  name = "colorgateway-vr"
  spec {
    service_names = ["colorgateway.${var.services_domain}"]
  }
}

resource "aws_appmesh_virtual_router" "colorteller" {
  mesh_name = "${aws_appmesh_mesh.mesh.name}"
  name = "colorteller-vr"
  spec {
    service_names = ["colorteller.${var.services_domain}"]
  }
}

# Route

resource "aws_appmesh_route" "colorgateway" {
  mesh_name = "${aws_appmesh_mesh.mesh.name}"
  virtual_router_name = "${aws_appmesh_virtual_router.colorgateway.name}"
  name = "colorgateway-route"
  spec {
    http_route {
      action {
        weighted_target {
          virtual_node = "${aws_appmesh_virtual_node.colorgateway.name}"
          weight = 100
        }
      }
      match {
        prefix = "/"
      }
    }
  }
}

resource "aws_appmesh_route" "colorteller" {
  mesh_name = "${aws_appmesh_mesh.mesh.name}"
  virtual_router_name = "${aws_appmesh_virtual_router.colorteller.name}"
  name = "colorteller-route"
  spec {
    http_route {
      action {
        weighted_target {
          virtual_node = "${aws_appmesh_virtual_node.colorteller_blue.name}"
          weight = 8
        }
        weighted_target {
          virtual_node = "${aws_appmesh_virtual_node.colorteller_red.name}"
          weight = 2
        }
      }
      match {
        prefix = "/"
      }
    }
  }
}
