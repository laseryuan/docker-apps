group "default" {
    targets = ["amd64"]
}

target "amd64" {
    dockerfile = "./amd64/Dockerfile"
    platforms = [
        "linux/amd64",
    ]
    tags = ["remmina:amd64"]
    output = ["type=docker"]
}
