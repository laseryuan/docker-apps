#!/bin/bash
amd64=true mo ./Dockerfile.templ > ./amd64/Dockerfile
arm32v6=true mo ./Dockerfile.templ > ./arm32v6/Dockerfile
