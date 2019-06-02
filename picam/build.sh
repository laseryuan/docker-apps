#!/bin/bash
arm32v6=true mo ./Dockerfile.templ > ./Dockerfile.arm32v6
arm32v6=true cross=true mo ./Dockerfile.templ > ./Dockerfile.arm32v6.cross
