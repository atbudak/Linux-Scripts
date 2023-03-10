#! /bin/bash
# ACCESS_TOKEN=""
CURL_PATH="https://gitlab.overtech.com.tr/api/v4/projects/79/repository/tree?ref=main"
CURL_NAME="techpos_a101_demo_2.0.0+228"


#curl -sI ${CURL_PATH} | grep "x-total" > /tmp/read-message.txt
#curl -sI ${CURL_PATH} | grep "x-per" >> /tmp/read-message.txt

# getting x-total, x-total-pages, x-per-page from header
TOTAL_FILES=`curl -sI ${CURL_PATH} | grep "x-total:" | awk '{print $2}'`
TOTAL_PAGES=`curl -sI ${CURL_PATH} | grep "x-total-pages:" | awk '{print $2}'`
PER_PAGES=`curl -sI ${CURL_PATH} | grep "x-per-page:" | awk '{print $2}'`

# removes \r from variables
TF="${TOTAL_FILES/$'\r'/}"
TP="${TOTAL_PAGES/$'\r'/}"
PP="${PER_PAGES/$'\r'/}"

#echo $TF
#echo $TP
#echo $PP
#curl --header "PRIVATE-TOKEN: $ACCESS_TOKEN"


for (( c=1; c<=$TP; c++ ));do curl -s "${CURL_PATH}&page=${c}" | json_pp >> ./file.json ; done


if grep -q ${CURL_NAME} ./file.json > /dev/null; then
    echo "FILE EXISTS : $CURL_NAME"; grep ${CURL_NAME} ./file.json | head -1 
else
    echo "FILE NOT EXISTS : $CURL_NAME ";    
fi

# if false ;then # grep -q ${CURL_NAME} ./file.json; then
#     echo "FILE EXISTS : $CURL_NAME"; grep ${CURL_NAME} ./file.json | head -1 
# elif grep -q ${CURL_NAME} ./file.json && true; then  # grep -q ${CURL_NAME} ./file.json && true; then        # ! getent $CURL_NAME | grep -q ./file.json; then
#     # echo "FILE NOT EXISTS : $CURL_NAME ";    
#     echo "FILE NOT EXISTS : $CURL_NAME"; grep ${CURL_NAME} ./file.json | head -1 
# else
#     echo "Unexpected Error!!" 
# fi



# if grep -q ${CURL_NAME} ./read-message.txt; then
# echo "FILE EXISTS :"; grep ${CURL_NAME} ./read-message.txt | head -1 | awk '{print $2}'; rm -f ./read-message.txt;
# elif grep -q "You are being" ./read-message.txt; then
# echo "FILE NOT EXISTS ON REMOTE!! UPLOADING ... "
# git clone -b main --single-branch $APK_REPO && ls -ltra && cd ./$APK_REPO_NAME && git branch
# cp ../OverPay/*.apk . && zip -m $APK_NAME.zip ./*.apk; git add . && git status && git commit -m "${CI_COMMIT_SHORT_SHA} committed artifact has sent."; git push origin main && rm -rf ../$APK_REPO_NAME; rm -rf ../${APK_NAME}.apk; rm -rf ../read-message.txt;
# else
# echo "Unexpected Error!!"; rm -f ./read-message.txt; exit 1;
# fi