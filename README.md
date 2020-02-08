# springcloud-eurekaserver

## Introduction

A spring cloud eureka server docker image which supports to change configuration via argument

Leveraging following K8s spec, we could deploy springcloud eureka server in a Kubernetes cluster

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: eureka
  labels:
    app: eureka
spec:
  selector:
    app: eureka
  clusterIP: None
  ports:
  - port: 8761
    name: eureka
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: eureka
  labels:
    app: eureka
spec:
  replicas: 1
  selector:
    matchLabels:
      app: eureka
  template:
    metadata:
      labels:
        app: eureka
    spec:
      containers:
      - name: eureka
        command:
        - sh
        - -c
        - "exec /bootstrap.sh --javaopt=\"-Xms512m -Xmx512m\" \
           --overrides=-Dserver.port=8761 \
           --overrides=-Deureka.client.serviceUrl.defaultZone=http://eureka.default:8761"
        image: zhaokundev/springcloud-eurekaserver:1.0
        resources:
          requests:
            memory: "1Gi"
            cpu: "0.5"
        ports:
        - containerPort: 8761
        livenessProbe:
          httpGet:
            path: /
            port: 8761
          initialDelaySeconds: 30
          periodSeconds: 10
          timeoutSeconds: 5
        readinessProbe:
          httpGet:
            path: /
            port: 8761
          initialDelaySeconds: 30
          periodSeconds: 10
          timeoutSeconds: 5
```

## Build

```
docker build -t zhaokundev/springcloud-eurekaserver:1.0 -f resources/rootfs/Dockerfile .
```
