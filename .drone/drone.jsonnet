local buildAndPublish() = {
    name: "build-and-publish",
    kind: "pipeline",
    type: "docker",
    steps: [
        {
            name: "build-package",
            image: "proget.hunterwittenborn.com/docker/makedeb/makedeb-alpha:ubuntu-focal",
            environment: {
                "github_api_key": {from_secret: "github_api_key"}
            },
            commands: [
                "sudo chown makedeb:makedeb ./ -R",
                "sudo apt-get update",
                "sudo apt-get install git -y",
                "PACMAN=true makedeb -s --no-confirm",
                "PACMAN=true makedeb --print-srcinfo > .SRCINFO"
            ]
        },

        {
            name: "publish-package",
            image: "python",
            environment: {
                github_api_key: {from_secret: "github_api_key"}
            },
            commands: [
                "pip install -r .drone/scripts/requirements.txt",
                ".drone/scripts/publish.py"
            ]
        }
    ]
};

[
    buildAndPublish(),
]
