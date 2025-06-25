#!/bin/bash
echo "Checking services health..."

curl -s http://localhost:8080/service1/ping | grep -q '"status":"ok"' && echo "Service1 OK" || echo "Service1 FAIL"

curl -s http://localhost:8080/service2/ping | grep -q '"status":"ok"' && echo "Service2 OK" || echo "Service2 FAIL"

