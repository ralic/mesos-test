#!/bin/bash

curl -X POST -H "Content-Type: application/json" http://192.168.50.100:8080/v2/apps -d@docker_web.json
