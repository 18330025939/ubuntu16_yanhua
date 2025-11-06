MODEL_NAME="fkz9"
SOC_NAME="yanhua"
DOCKER_IMAGE_NAME="yanhua_build_env"
DOCKER_BASE_TAG="$SOC_NAME"
DOCKER_TAR_NAME="yanhua_""$DOCKER_BASE_TAG"".tar"

export MODEL_NAME="$MODEL_NAME"
export DOCKER_IMAGE_NAME="$DOCKER_IMAGE_NAME"
export DOCKER_BASE_TAG="$DOCKER_BASE_TAG"
export COMPOSE_PROJECT_NAME="$USER"_"$DOCKER_BASE_TAG"
export GROUP_ID=$(id -g)
export USER_ID=$(id -u)

IN_DOCKER=$(grep -c docker < /proc/1/cgroup)

update_ignore() {
	cp -f ./docker/.dockerignore .
}

[ "$IN_DOCKER" != "0" ] && echo "In Docker container already ..." && exit 0

update_ignore
if [ "$(docker images -q $DOCKER_IMAGE_NAME:$DOCKER_BASE_TAG 2>/dev/null)" = "" ]; then
	# No docker image, build one or load one.
	if [ -f ./docker/"$DOCKER_TAR_NAME" ]; then
		echo -e "\033[32m\n****\tLoad local docker image ...\t****\033[0m"
		docker load --input ./docker/"$DOCKER_TAR_NAME"
	else
		echo -e "\033[32m\n****\tCreate docker image from Dockerfile  ...\t****\033[0m"
		docker build -t $DOCKER_IMAGE_NAME:$DOCKER_BASE_TAG -f ./docker/Dockerfile .
	fi
fi

docker-compose -f ./docker/docker-compose.yml -p $(basename $(pwd)) up -d
docker exec -it -u "$USER" "$USER"_"$MODEL_NAME" /bin/bash

