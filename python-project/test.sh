#!/bin/bash

# Set some default values:
ALPHA=unset
BETA=unset
CHARLIE=unset
DELTA=unset

usage()
{
  echo "Usage: alphabet [ -a | --alpha ] [ -b | --beta ]
                        [ -c | --charlie CHARLIE ] 
                        [ -d | --delta   DELTA   ] filename(s)"
  exit 2
}

PARSED_ARGUMENTS=$(getopt -a -n alphabet -o abc:d: --long alpha,bravo,charlie:,delta: -- "$@")
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

echo "PARSED_ARGUMENTS is $PARSED_ARGUMENTS"
eval set -- "$PARSED_ARGUMENTS"
while :
do
  case "$1" in
    -a | --alpha)   ALPHA=1      ; shift   ;;
    -b | --beta)    BETA=1       ; shift   ;;
    -c | --charlie) CHARLIE="$2" ; shift 2 ;;
    -d | --delta)   DELTA="$2"   ; shift 2 ;;
    # -- means the end of the arguments; drop this, and break out of the while loop
    --) shift; break ;;
    # If invalid options were passed, then getopt should have reported an error,
    # which we checked as VALID_ARGUMENTS when getopt was called...
    *) echo "Unexpected option: $1 - this should not happen."
       usage ;;
  esac
done

echo "ALPHA   : $ALPHA"
echo "BETA    : $BETA "
echo "CHARLIE : $CHARLIE"
echo "DELTA   : $DELTA"
echo "Parameters remaining are: $@"

usage(){
echo "
    Usage:
        -m, --mode              Select mode <build|deploy|template> 
        -n, --image-name        Docker image name
        -t, --image-tag         Docker image tag
        -M, --memory            Container memory limit
        -c, --cpu               Container cpu limit
        -N, --container-name    Container name
        -r, --registery         DocherHub or GitLab Image registery
        -a, --application-name  Run mysql or mongo server"

exit 1
}



parameters_list=":m:n:t:M:c:N:r:a:q"

while getopts ${parameters_list} OPTS; do
	case "${OPTS}" in
        q)
            parameters=$@;
            # echo "$parameters" | awk '{print $2}'
            let deger=$#/2;
           while [ $deger -gt 0 ]; do
                #echo Sayac durumu: $deger
                #echo "$parameters" | awk '{print $(1)}'
                DEGER1= echo "$parameters" | awk '{print $1}'
                DEGER2= echo "$parameters" | awk '{print $(3)}'
                DEGER3= echo "$parameters" | awk '{print $(5)}'
                DEGER4= echo "$parameters" | awk '{print $(7)}'
                DEGER5= echo "$parameters" | awk '{print $(9)}'
                DEGER6= echo "$parameters" | awk '{print $(11)}'
                if [[ $DEGER1]];then
                fi
                echo $test
                let deger=$deger-1
            done
            
            ;;
	    m)  # MODE=$2 ; echo "test a $MODE" 
            #MODE=$2 ; mode
		   ;;
	    n) # echo "test12 $@";
            #IMAGE_NAME=$2; image_name
		   ;;
	    t) echo "test c"
		   ;;
	    M) echo "test d"
		   ;;
	    c) echo "test e"
		   ;;
	    N) echo "test e"
		   ;;
        r) echo "test e"
		   ;;
        a) echo "test e"
		   ;;
        ?)
	      echo "invalid option"
	      echo ""
	      branch
	      ;;
	esac
done
