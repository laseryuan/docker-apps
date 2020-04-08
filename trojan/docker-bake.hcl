group "default" {
    targets = ["amd64"]
    // targets = ["arm32v7"]
    // targets = ["amd64", "arm32v7"]
}

target "amd64" {
    dockerfile = "./amd64/Dockerfile"
    platforms = [
        "linux/amd64",
    ]
    tags = ["trojan", "trojan:amd64"]
    output = ["type=docker"]
}

target "arm32" {
    dockerfile = "./arm32/Dockerfile"
    platforms = [
        "linux/arm/v6",
    ]
    tags = ["trojan:arm32"]
    output = ["type=docker"]
}

target "arm32v7" {
    dockerfile = "./arm32v7/Dockerfile"
    platforms = [
        "linux/arm/v7",
    ]
    tags = ["trojan:arm32v7"]
    output = ["type=docker"]
}
