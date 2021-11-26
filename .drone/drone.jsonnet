local buildPackage() = {
    name: "build-package",
    kind: "pipeline",
    type: "docker",
    steps: [{
        name: "build-package",
        image: "proget.hunterwittenborn.com/docker/makedeb/makedeb-alpha:ubuntu-focal",
        environment: {
            "github_api_key": {from_secret: "github_api_key"}
        },
        commands: [
            "PACMAN=true makedeb -s --no-confirm",
            "PACMAN=true makedeb --print-srcinfo > .SRCINFO"
        ]
    }]
};

local publishPackage() = {
    name: "publish-package",
    kind: "pipeline",
    type: "docker",
    depends_on: ["build-package"],
    steps: [{
        name: "publish-package",
        image: "python",
        environment: {
            github_api_key: {from_secret: "github_api_key"}
        },
        commands: [
            "pip install -r .requirements.txt",
            "./publish.py"
        ]
    }]
};

[
    buildPackage(),
    publishPackage()
]
