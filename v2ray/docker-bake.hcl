group "default" {
    // targets = ["amd64"]
    // targets = ["arm32v7"]
    targets = ["amd64", "arm32v7"]
}

target "amd64" {
    dockerfile = "./amd64/Dockerfile"
    platforms = [
        "linux/amd64",
    ]
    tags = ["v2ray", "v2ray:amd64"]
    output = ["type=docker"]
}

target "arm32" {
    dockerfile = "./arm32/Dockerfile"
    platforms = [
        "linux/arm/v6",
    ]
    tags = ["v2ray:arm32"]
    output = ["type=docker"]
}

target "arm32v7" {
    dockerfile = "./arm32v7/Dockerfile"
    platforms = [
        "linux/arm/v7",
    ]
    tags = ["v2ray:arm32v7"]
    output = ["type=docker"]
}
