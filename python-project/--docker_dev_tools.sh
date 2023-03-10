#! /bin/bash

usage(){
echo "
    Usage:
        --mode              Select mode <build|deploy|template> 
        --image-name        Docker image name
        --image-tag         Docker image tag
        --memory            Container memory limit
        --cpu               Container cpu limit
        --container-name    Container name
        --registery         DocherHub or GitLab Image registery
        --application-name  Run mysql or mongo server"

exit 1
}

version=" Version 0.1.1.alpha1"

if test $# -eq 0; then
  echo >&2 "$0: invalid number of operands; try \`$0 --help' for help"
  exit 1
fi

# parameters_list=(:"--mode" "--image-name" "--image-tag" "--memory" "--cpu" "--container-name" "--registery" "--application-name")
# parameters_list=":mode:image-name:image-tag:memory:cpu:container-name:registery:application-name:"
TEMP=`getopt -n docker_dev_tools --long mode:,image-name:,image-tag:,memory:cpu:,container-name:,registery:,application-name: -- "$@"`
eval set -- "$TEMP"


while : 
do
	case "$1" in
      --droped) echo ""; shift 2
       ;;
	    --mode) MODE=$1 ; echo "mode  $1 $2 "; shift 2
		   ;;
	    --image-name) IMAGE_NAME=$2; echo "image name $IMAGE_NAME - $MODE "; shift 2
		   ;;
	    --image-tag) IMAGE_TAG=$2 ; echo "image tag $IMAGE_TAG "; shift 2
		   ;;
	    --memory) ceho "mem $2 "; shift 2
		   ;;
	    --cpu) echo "cpu $2 "; shift 2
		   ;;
      --container-name) echo "container name $2 "; shift 2
       ;;
      --registery) REGISTERY=$2; echo "reg $REGISTERY - $IMAGE_TAG"; shift 2
	     ;;
      --application-name) echo "app name $2 "; shift 2
       ;;
      ?)
	      echo "invalid option"
	      echo ""
	      usage
	      ;;
	esac
done
