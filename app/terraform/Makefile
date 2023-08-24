.PHONY: container-shell validate plan quickplan apply init workspace new

ifndef ENV
  $(error ENV must be set)
endif

CONTAINER?=173385929429.dkr.ecr.eu-west-1.amazonaws.com/pi-terraform
TAG?=15

REGION ?= eu-west-1
MODULE ?= aws

TF_PLAN=../plans/${MODULE}-${REGION}-${ENV}.plan
TF_CONFIG_FILES=${ENV}/common.tfvars ${ENV}/${MODULE}.tfvars ${ENV}/release.tfvars
TF_ARGS+= $(foreach cfg,$(TF_CONFIG_FILES), -var-file ../config/$(cfg) )


WORKSPACE=${MODULE}-${REGION}-${ENV}


container-shell:
	docker run -e MODULE=$(MODULE) -e AWS_PROFILE -e ENV --rm -it -v "$$HOME/.aws:/root/.aws" -v "$$HOME/.ssh:/root/.ssh" -v "$$PWD:/app" -v "$$PWD/../deploy:/deploy" $(CONTAINER):$(TAG)

validate:
	TF_WORKSPACE=$(WORKSPACE) terraform -chdir=${MODULE} validate

workspace:
	terraform workspace -chdir=${MODULE} select ${WORKSPACE}

quickplan: workspace
	TF_WORKSPACE=$(WORKSPACE) terraform -chdir=${MODULE} plan ${TF_ARGS} -out ${TF_PLAN}

plan: init quickplan

apply: workspace
	TF_WORKSPACE=$(WORKSPACE) terraform -chdir=${MODULE} apply "${TF_PLAN}"

init:
	TF_WORKSPACE=$(WORKSPACE) terraform -chdir=${MODULE} init --upgrade

refresh: workspace
	TF_WORKSPACE=$(WORKSPACE) terraform -chdir=${MODULE} refresh ${TF_ARGS}

new:
	cd config && touch dev/${MODULE}.tfvars
	terraform -chdir=${MODULE} workspace new "${MODULE}-${REGION}-dev"

destroy: workspace
	TF_WORKSPACE=$(WORKSPACE) terraform -chdir=${MODULE} plan ${TF_ARGS} --destroy -out ${TF_PLAN}