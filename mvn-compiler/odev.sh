#! /bin/bash
#########################
# Author:
# Date: 5-6-2022
# Usage: Maven projesinin githubdan çekip derlenebilir hale getirilen program
#########################

#  conf file defined

source /mnt/odev.conf

branch(){
echo "Usage: odev.sh [-abztf]"
echo "Please choose opstions one by one"
echo "-a Choose or create branch you work for"
echo "-b chose debug mode as on or off"
echo "-z compressing file as zip"
echo "-t compressing file as tar.gz"
echo "-f choose compressing file path"
exit 1
}

a_ops(){
 git branch -a
 echo "these are branches, choose one or create one"
 read -r BRANCH_USR
 if [[ "${BRANCH}" == "${BRANCH_USR}" ]]; then
    git checkout ${BRANCH}
 else
    git checkout -b ${BRANCH_USR}
 fi
}

b_ops(){
 echo " Choose the debug mode: on/off "
 read -r $DEBUG
 if [[ ${DEBUG} == "off" || ${DEBUG} == "" ]]; then
     cd /home/${HOME_USR}/${GIT_DIR}
     if [[ ${CUR_BRANCH} == "main" || ${CURR_BRANCH} == "master"} ]]; then
	echo "You are building master/main in branch!!"
	sleep 2
     fi
     mvn package -X -Dmaven.test.skip
     branch
 else
    if [[ ${CUR_BRANCH} == "main" || ${CUR_BRANCH} == "master" ]]; then
	echo "You are building master/main in branch!!"
	sleep 2
    fi
    cd /home/${HOME_USR}/${GIT_DIR}
    mvn package -Dmaven.test.skip
    branch
 fi
}

z_ops(){
 cd /home/${HOME_USR}/${GIT_DIR}/target/
 if [[ ${FILE_PATH} -eq 0 ]]; then
    echo "Please choose file path first!!"
    branch
else
    zip -r ${CUR_BRANCH}.zip *.jar ${FILE_PATH}
    ls -ltr /${FILE_PATH}| grep *.zip
 fi
}

t_ops(){
 if [[${FILE_PATH} -eq 0 ]]; then
     echo "Please choose file path first!!"
     branch
 else
     cd /home/${HOME_USR}/${GIT_DIR}/target/
     tar -czf ${CUR_BRANCH}.tar.gz ${FILE_PATH} 
     ls -ltr ${FILE_PATH} |  grep *.tar.gz
 fi
}

f_ops(){ 
 echo "Please enter compressed file path."
 read -r USR_PATH
 #declare -x -g FILE_PATH=$USR_PATH
 #${FILE_PATH}==$USR_PATH
# sed -i s/^\(\$FILE_PATH\s*=\s*\).*\$/\$USR_PATH/" "/mnt/odev.conf"
# sed -i s/\/home/ubuntuvm/\/$USR_PATH/g" "/mnt/odev.conf"
 echo "Compressed file be in ${FILE_PATH}."
}

if [[ ${#} -eq 0 ]]; then
    branch
fi

if [[ ${#} -gt 1 ]]; then
    echo "Please Choose only one options"
    branch
fi


parameters_list=":abztf"

while getopts ${parameters_list} OPTS; do
	case "${OPTS}" in
	    a) a_ops
		   ;;
	    b) b_ops
		   ;;
	    z) z_ops
		   ;;
	    t) t_ops
		   ;;
	    f) f_ops
		   ;;
	    ?)
	      echo "invalid option"
	      echo ""
	      branch
	      ;;
	esac
done
