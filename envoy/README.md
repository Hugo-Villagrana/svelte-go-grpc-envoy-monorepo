# Envoy Proxy

## 1. Build and Run Envoy
```bash
docker build -t envoy-proxy .
docker run -d -p 8080:8080 -p 9901:9901 --name envoy-proxy envoy-proxy
```
