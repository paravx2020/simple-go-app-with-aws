#!/bin/bash
sudo apt-get update
sudo apt-get install -y golang-go  
sudo apt-get install -y gccgo-go   
nohup go run steeleye-app.go &

