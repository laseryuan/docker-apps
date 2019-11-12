group "default" {
    targets = ["amd64", "nvidia"]
}

target "amd64" {
    dockerfile = "./amd64/Dockerfile"
    platforms = [
        "linux/amd64",
    ]
    tags = ["minecraft:amd64"]
    output = ["type=docker"]
}

target "nvidia" {
    dockerfile = "./nvidia/Dockerfile"
    platforms = [
        "linux/amd64",
    ]
    tags = ["minecraft:nvidia"]
    output = ["type=docker"]
}

target "arm32" {
    dockerfile = "./arm32/Dockerfile"
    platforms = [
        "linux/arm/v6",
    ]
    tags = ["minecraft:arm32"]
    output = ["type=docker"]
}
