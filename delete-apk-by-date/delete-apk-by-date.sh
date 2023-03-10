#!/bin/bash

ACCESS_TOKEN="4Njhsz3myp-r6Yhab3oJ"
### apk reposu
APK_REPO=https://abudak:$ACCESS_TOKEN@gitlab.overtech.com.tr/abudak/overtech-apk-repos.git
REPO_NAME=overtech-apk-repos
RED='\033[0;31m'
Purple='\033[0;35m'
Green='\033[0;32m'
NC='\033[0m' # No Color

### repository locale çekildiği fonk.
clone_repo()
{
    rm -rf $(pwd)/$REPO_NAME; ls -ltra
    git clone -b $BRANCH --single-branch $APK_REPO
}
### silinme işleminin yapıldığı fonksiyon
clear_repository() 
{

    ### tarihlerin alınacağı dizine geçilir
    cd ./$REPO_NAME
    #  cd $HOME/overtech-apk-repos

    printf "${RED}Branch : $BRANCH Dizin: $(pwd)${NC}\n"
    printf "Dosya sayısı:${Purple} $(ls | wc -l) ${NC}\n"
    # exit 1
    for file in $( ls )
    do
        ### son modified tarihi alıyor unix timestamp formatında
        LAST_UPDATE=$(git log -1 --pretty="format:%ct" ./$file | awk '{print $1}')
        ### bugün tarihi unix timestamp formatında
        TODAY=$(date "+%s")
        ### kaç gündür repoda olduğunu gösteriyor
        let DIFF=($TODAY-$LAST_UPDATE)/86400
        ### 30 günden fazla olanlar burada silinecek
        if [[ $DIFF -ge '20' && $file != "README.md" ]];then rm -rf ./$file & fi
    done
    printf "Dosya sayısı:${Purple} $(ls | wc -l) ${NC}\n"
}
### gite yollama işlemi yapıldığı fonksiyon
git_push()
{
    # cd $HOME/overtech-apk-repos
    printf "${RED}Branch : $BRANCH Dizin: $(pwd)${NC}\n"
    git add . ; git commit -m "updated at $(date "+%s")" ; git status
    git push origin $BRANCH

}
remove_git_folder()
{
    cd ../; rm -rf $(pwd)/$REPO_NAME
    ls -altr; printf "${Green}Done !! ${NC}\n"
}

echo -n "$(tput setaf 6)Hangi branchı silmek istediğinizi seçiniz? [main veya test]:$(tput setaf 3) \n"
read option

case $option in 
    [Mm] | [Mm][Aa][Ii][Nn])       
        BRANCH="main"
        clone_repo  # cloning the repository
        clear_repository  # deleting unnecessary files
        git_push  # sending gitlab to files
        remove_git_folder  # remove repo. folder
        ;;
    [Tt] | [Tt][Ee][Ss][Tt])
        BRANCH="test"
        clone_repo
        clear_repository
        git_push
        remove_git_folder  
        ;;
    [d])
        BRANCH="date-test-01"
        clone_repo
        clear_repository
        git_push   
        remove_git_folder     
        ;;
    *)
        echo "Seçeneğiniz anlaşılmadı.
            m ya da main       main branch için,
            t ya da test       test branch için
            "
        exit 1
        ;;
esac

