#!/bin/bash

RED='\033[0;31m'
Purple='\033[0;35m'
Green='\033[0;32m'
NC='\033[0m' # No Color

usage(){
    echo "
        USAGE:
            
        
        PARAMETERS:

            Pavopay Prod apk için : PP|pp,
            Pavopay Demo apk için : PD|pd,
            BKM Techpos Prod apk için : TP|tp,
            BKM Techpos Demo apk için : TD|td giriniz.
            "

    exit 1
}

echo -n "$(tput setaf 6)Format seçiniz <Pavopay Prod : PP|pp, Pavopay Demo : PD|pd, \
BKM Techpos Prod : TP|tp, BKM Techpos Demo : TD|td > : $(tput setaf 3)"
read -r option

### Pavopay Prod'da oluşturulacak mükellefin(adı, pf id'si, apikey'i) bilgilerinin alınması
pavopay_prod(){
        ### Mükellef değeri alınır
        echo -n "$(tput setaf 6)Pavopay Prod uygulamasının mükellefini giriniz <sipay, nkolay vs.> : $(tput setaf 3)"
        read -r name

        ### Mükellefin ID değeri alınır
        echo -n "$(tput setaf 6)Pavopay Prod uygulamasının mükellefinin PF idsini giriniz : $(tput setaf 3)"
        read -r pf_id
        ### Girilen id değeri sayı olarak alındığı kontrol edilir
        reg='^[0-9]+$'
        if ! [[ $pf_id =~ $reg ]]; then
            echo "error: Not a number" >&2;
            exit 1
        fi
        ### PF APIKEY değeri alınır
        echo -n "$(tput setaf 6)Pavopay Prod uygulamasının mükellefinin PF APIKEY giriniz : $(tput setaf 3)"
        read -r pf_apikey

        ### Değişkenler ayarlanır
        PF_NAME=`echo "$name" | tr '[:upper:]' '[:lower:]'`
        APK_NAME="overpay_$PF_NAME"
        PF_ID=$pf_id
        PF_APIKEY=$pf_apikey

        ### Pavopay Prod mükellefinin oluşturulması
        change_pavopay_prod

}
### Pavopay Demo'da oluşturulacak mükellefin(adı, pf id'si, apikey'i) bilgilerinin alınması
pavopay_demo(){
        ### Mükellef değeri alınır
        echo -n "$(tput setaf 6)Pavopay Demo uygulamasının mükellefini giriniz <sipay, nkolay vs.> : $(tput setaf 3)"
        read -r name

        ### Mükellefin ID değeri alınır
        echo -n "$(tput setaf 6)Pavopay Prod uygulamasının mükellefinin PF idsini giriniz : $(tput setaf 3)"
        read -r pf_id
        ### Girilen id değeri sayı olarak alındığı kontrol edilir
        reg='^[0-9]+$'
        if ! [[ $pf_id =~ $reg ]]; then
            echo "error: Not a number" >&2;
            exit 1
        fi
        ### PF APIKEY değeri alınır
        echo -n "$(tput setaf 6)Pavopay Demo uygulamasının mükellefinin PF APIKEY giriniz : $(tput setaf 3)"
        read -r pf_apikey

        ### Değişkenler ayarlanır
        PF_NAME=`echo "$name" | tr '[:upper:]' '[:lower:]'`
        APK_NAME="overpay_${PF_NAME}_demo"
        PF_ID=$pf_id
        PF_APIKEY=$pf_apikey

        ### Pavopay Prod mükellefinin oluşturulması
        change_pavopay_demo

}
### BKM Techpos Prod'da oluşturulacak mükellefin(adı, pf id'si, apikey'i) bilgilerinin alınması
techpos_prod(){
        ### Mükellef değeri alınır
        echo -n "$(tput setaf 6)BKM Techpos Prod uygulamasının mükellefini giriniz <sipay, nkolay vs.> : $(tput setaf 3)"
        read -r name

        ### Mükellefin ID değeri alınır
        echo -n "$(tput setaf 6)BKM Techpos Prod uygulamasının mükellefinin PF idsini giriniz : $(tput setaf 3)"
        read -r pf_id
        ### Girilen id değeri sayı olarak alındığı kontrol edilir
        reg='^[0-9]+$'
        if ! [[ $pf_id =~ $reg ]]; then
            echo "error: Not a number" >&2;
            exit 1
        fi
        ### PF APIKEY değeri alınır
        echo -n "$(tput setaf 6)BKM Techpos Prod uygulamasının mükellefinin PF APIKEY giriniz : $(tput setaf 3)"
        read -r pf_apikey

        ### Değişkenler ayarlanır
        PF_NAME=`echo "$name" | tr '[:upper:]' '[:lower:]'`
        APK_NAME="techpos_${PF_NAME}"
        PF_ID=$pf_id
        PF_APIKEY=$pf_apikey

        ### Pavopay Prod mükellefinin oluşturulması
        change_techpos_prod

}
### BKM Techpos Demo'da oluşturulacak mükellefin(adı, pf id'si, apikey'i) bilgilerinin alınması
techpos_demo(){
        ### Mükellef değeri alınır
        echo -n "$(tput setaf 6)BKM Techpos Demo uygulamasının mükellefini giriniz <sipay, nkolay vs.> : $(tput setaf 3)"
        read -r name

        ### Mükellefin ID değeri alınır
        echo -n "$(tput setaf 6)BKM Techpos Demo uygulamasının mükellefinin PF idsini giriniz : $(tput setaf 3)"
        read -r pf_id
        ### Girilen id değeri sayı olarak alındığı kontrol edilir
        reg='^[0-9]+$'
        if ! [[ $pf_id =~ $reg ]]; then
            echo "error: Not a number" >&2;
            exit 1
        fi
        ### PF APIKEY değeri alınır
        echo -n "$(tput setaf 6)BKM Techpos Demo uygulamasının mükellefinin PF APIKEY giriniz : $(tput setaf 3)"
        read -r pf_apikey

        ### Değişkenler ayarlanır
        PF_NAME=`echo "$name" | tr '[:upper:]' '[:lower:]'`
        APK_NAME="techpos_${PF_NAME}_demo"
        PF_ID=$pf_id
        PF_APIKEY=$pf_apikey

        ### Pavopay Prod mükellefinin oluşturulması
        change_techpos_demo

}

### Pavopay Prod mükellefinin oluşturulması
change_pavopay_prod(){
    # overpay-prod-template.yml üzerinde karşılık gelen değişkenler:
    #   PP_APK_NAME for APK_NAME
    #   PP_PF_NAME for PF_NAME
    #   PP_PF_ID for PF_ID
    #   PP_PF_APIKEY for PF_APIKEY
    
    cp templates/overpay-prod-template.yml created-pf/$APK_NAME-template.yml
    sed -i "s:PP_APK_NAME:$APK_NAME:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:PP_PF_NAME:${PF_NAME^}:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:PP_PF_ID:$PF_ID:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:PP_PF_APIKEY:$PF_APIKEY:g" "created-pf/$APK_NAME-template.yml"

    echo "Dosya yolu : created-pf/$APK_NAME-template.yml"
}
### Pavopay Demo mükellefinin oluşturulması
change_pavopay_demo(){
    # overpay-demo-template.yml üzerinde karşılık gelen değişkenler:
    #   - PD_APK_NAME için APK_NAME
    #   - PD_PF_NAME için PF_NAME
    #   - PD_PF_ID için PF_ID
    #   - PD_PF_APIKEY için PF_APIKEY

    cp templates/overpay-demo-template.yml created-pf/$APK_NAME-template.yml
    sed -i "s:PD_APK_NAME:$APK_NAME:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:PD_PF_NAME:${PF_NAME^}:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:PD_PF_ID:$PF_ID:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:PD_PF_APIKEY:$PF_APIKEY:g" "created-pf/$APK_NAME-template.yml"

    echo "Dosya yolu : created-pf/$APK_NAME-template.yml"
}
### BKM Techpos Prod mükellefinin oluşturulması
change_techpos_prod(){
    # techpos-prod-template.yml üzerinde karşılık gelen değişkenler:
    #   - TP_APK_NAME için APK_NAME
    #   - TP_PF_NAME için PF_NAME
    #   - TP_PF_ID için PF_ID
    #   - TP_PF_APIKEY için PF_APIKEY

    cp templates/techpos-prod-template.yml created-pf/$APK_NAME-template.yml
    sed -i "s:TP_APK_NAME:$APK_NAME:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:TP_PF_NAME:${PF_NAME^}:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:TP_PF_ID:$PF_ID:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:TP_PF_APIKEY:$PF_APIKEY:g" "created-pf/$APK_NAME-template.yml"

    echo "Dosya yolu : created-pf/$APK_NAME-template.yml"
}
### BKM Techpos Demo mükellefinin oluşturulması
change_techpos_demo(){
    # techpos-demo-template.yml üzerinde karşılık gelen değişkenler:
    #   - TD_APK_NAME için APK_NAME
    #   - TD_PF_NAME için PF_NAME
    #   - TD_PF_ID için PF_ID
    #   - TD_PF_APIKEY için PF_APIKEY

    cp templates/techpos-demo-template.yml created-pf/$APK_NAME-template.yml
    sed -i "s:TD_APK_NAME:$APK_NAME:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:TD_PF_NAME:${PF_NAME^}:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:TD_PF_ID:$PF_ID:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:TD_PF_APIKEY:$PF_APIKEY:g" "created-pf/$APK_NAME-template.yml"

    echo "Dosya yolu : created-pf/$APK_NAME-template.yml"
}

case $option in 
    [P][P] | [p][p])
        ### Pavopay canlı ortamda oluşturulacak mükellefler   
        echo "Pavopay Prod Ortamı"
        pavopay_prod
        ;;
    [P][D] | [p][d])
        ### Pavopay demo ortamda oluşturulacak mükellefler
        echo "Pavopay Demo Ortamı"
        pavopay_demo
        ;;
    [T][P] | [t][p])
        ### BKM Techpos canlı ortamda oluşturulacak mükellefler   
        echo "BKM Techpos Prod Ortamı"
        techpos_prod
        ;;
    [T][D] | [t][d])
        ### BKM Techpos demo ortamda oluşturulacak mükellefler
        echo "BKM Techpos Demo Ortamı"
        techpos_demo
        ;;
    *)
        usage
        ;;
esac

