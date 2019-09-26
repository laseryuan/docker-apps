#!/bin/bash
amd64=true mo ./Dockerfile.templ > ./Dockerfile.amd64
arm32v6=true mo ./Dockerfile.templ > ./Dockerfile.arm32v6
