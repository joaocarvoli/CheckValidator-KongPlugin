#!/bin/bash

# Cadastrando o plugin
curl -X POST --url http://localhost:8001/services/example-service/plugins/ --data 'name=checkvalidator'