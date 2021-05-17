# GitHub Actions Runner

Docker image for Github Actions Self-Hosted Runner.

## Preparation

- Personal Access Token : repo / workflow / admin:org

## How to use

```sh
$ docker build --tag runner-image .

$ docker run \
  --detach \
  --env ORGANIZATION=<YOUR-GITHUB-ORGANIZATION> \
  --env ACCESS_TOKEN=<YOUR-GITHUB-ACCESS-TOKEN> \
  --name runner \
  runner-image
```
