#! /bin/bash

ssh_archive_pass=""
ssh_archive_user=""
ssh_archive_ip=""

#usage message
msg="
Usage: $(basename $0)

INFO:

Safezone'dan alıp sh dosyasına ekleyiniz: ssh_archive_pass,ssh_archive_user, ssh_archive_ip

EXAMPLE:

    ssh_archive_pass="password"
    ssh_archive_user="user"
    ssh_archive_ip="ip-adress/hostname"

USAGE:

Taşınmak istenen tar yolu: /keystone/keystone_excel_prod_412.tar

Girilmesi beklenen değerler:

    > GitLab repository'e yollamak istediginiz tar dosyasinin adini sonunda .tar olmadan giriniz:
    keystone_excel_prod_412
    
    > Tar dosyasinin dosya yolunu giriniz:
    keystone

"
help() {
    echo "${msg}"
    exit 1
}

while getopts h flag
do
    case "${flag}" in
        h) help;;
    esac
done

echo "Daha fazla bilgi için: ./push-artifact-image.sh  -h"
echo "."
echo "."
echo "GitLab repository'e yollamak istediginiz tar dosyasinin adini sonunda .tar olmadan giriniz:"
read tar_name
echo "Tar dosyasinin dosya yolunu giriniz: (axeed, hangfire seklinde)"
read tar_path

if ! [[ -n $tar_path ]]; then
    echo "Tar dosya yolu boş geçilemez !" 
    exit 1
fi

# pull image to local
sshpass -p "$ssh_archive_pass" scp -o StrictHostKeyChecking=no -r ${ssh_archive_user}@${ssh_archive_ip}:/${tar_path}/${tar_name}.tar /tmp/${tar_name}.tar

## docker load and push
docker load -i /tmp/${tar_name}.tar | cut --delimiter=' ' -f 3 > /tmp/${tar_name}.txt
cat /tmp/${tar_name}.txt
# docker push $(cat /tmp/${tar_name}.txt)

## Clean-up 
docker rmi $(cat /tmp/${tar_name}.txt)
rm /tmp/${tar_name}.txt
rm /tmp/${tar_name}.tar
