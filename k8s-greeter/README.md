# K8S Greeter

## Issue

We want to take a simple program and host it in our k8s cluster.

## Requirements

- Write a simple program that exposes a simple HTTP API, with a method that accepts a "name" and sends back a templates greeting.
- Containerize the application.
- Write the necessary k8s deployment module for the application.
- Write a simple build and deploy pipeline that will automate the entire process.

## Assumptions and guidelines

- A standard kubernetes cluster is given (e.g eks, minikube, k3s, etc.)
- A standard container registry is given (e.g. public docker hub).
- You can use any programming language for your app (e.g. Java, Javascript, Go, Python, Bash, etc.)
- The API could custom but ideally a standard HTTP such as gRPC, REST, GraphQL, etc.
- The deployment module could be standard K8s manifests, but ideally a Helm chart.
- The pipeline could be scripted or declarative so long that it is executable (e.g. Bash, Groovy, Circle, etc.)

## Considerations

- Configuration (the application will need to get dynamic configuration using Configmap, env vars, etc.)
- Exposure: we need to reach this application (API endpoint) from the outside of the cluster.
- Testability
- Error handling
