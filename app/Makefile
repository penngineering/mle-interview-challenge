TAG?=dev
IMAGE?=173385929429.dkr.ecr.eu-west-1.amazonaws.com/data-hello-world
ECS_SERVICE=data-dev-sharp-classifier
GITSHA=$(shell git rev-parse HEAD)

cicd: build run test clean

setup:
	poetry install
	pre-commit install
	pre-commit autoupdate

dev:
	cd app && poetry run uvicorn app:app --log-level debug --host 0.0.0.0 --port 8000 --reload

build:
	docker build -t $(IMAGE):$(TAG) --build-arg GITSHA=$(GITSHA) .

push:
ifndef AWS_PROFILE
	$(error AWS_PROFILE is undefined. This is the account you wish to launch the ecs task to, not the shared account)
endif
ifndef ECS_SERVICE
	$(error ECS_SERVICE is undefined.)
endif
	AWS_PROFILE=shared docker push $(IMAGE):$(TAG)

run:
	docker run -p 8000:8000 $(IMAGE):$(TAG)

test:
	cd tests/features && poetry run behave

check:
	mypy **/*.py

clean:
	docker stop $$(docker ps --filter ancestor=$(IMAGE) -aq) \
	&&  docker rm $$(docker ps --filter ancestor=$(IMAGE) -aq)
	rm -rf .pytest_cache .mypy_cache

lint:
	poetry run black **/*.py