#!/bin/bash
RED='\033[0;31m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

usage(){
    echo "
        USAGE: ./create-apk 
        
        CAUTION: 
            Mükellef değeri girerken i,ö,ç,ş,ğ gibi karakterleri büyük harfle girilmemeli.
            Girilen değerlerin doğruluğuna dikkat edilmeli.
            Oluşturulan apk dosyaları her çalıştırılmada silinir.

        FUNCTIONS:
            get_single_values & get_multiple_values kullanıcıdan değer alır.
            - get_single_values fonksiyonu > one_environment, prod_environment, demo_environment fonksiyonu tarafından kullanılır.
            - get_multiple_values foksiyonu > all_environment fonksiyonu tarafından kullanılır.
            change_pavopay_prod, change_pavopay_demo vs. fonksiyonları templates/ klasöründeki değerleri istenilen ile değiştirip created-pf/ klasörüne atar.
        
        PARAMETERS:
            Pavopay Prod apk için : PP|pp,
            Pavopay Demo apk için : PD|pd,
            BKM Techpos Prod apk için : TP|tp,
            BKM Techpos Demo apk için : TD|td,
            custom_poss Prod apk için : CP|cp,
            custom_poss Demo apk için : CD|cd giriniz.
            "

    exit 1
}

##################### Mükellef Tanımı (Başlangıç) #####################
### PF ID ve PF APIKEY demo ve prod değerleri farklı olabileceği için veriler iki farklı şekilde alınır.

### Yanlızca demo ve prod ortamı ya da tekli ortam oluşturulacaksa
get_single_values(){
    ### Mükellef değeri alınır
    printf "${PURPLE}----- Mükellef Değerleri -----${NC}\n"
    echo -n "$(tput setaf 6)Mükellef giriniz <sipay, nkolay vs.> : $(tput setaf 3)"
    read -r name
    name=`echo $name|tr -d '[:punct:]'`  # Noktalama işaretleri kaldırılır

    ### Mükellefin ID değeri alınır
    echo -n "$(tput setaf 6)Mükellef PF ID giriniz : $(tput setaf 3)"
    read -r pf_id
    ### Girilen id değeri sayı olarak alındığı kontrol edilir
    reg='^[0-9]+$'
    if ! [[ $pf_id =~ $reg ]]; then
        echo "error: Not a number" >&2;
        exit 1
    fi
    ### PF APIKEY değeri alınır
    echo -n "$(tput setaf 6)Mükellef PF APIKEY giriniz : $(tput setaf 3)"
    read -r pf_apikey

    ### Değişkenler ayarlanır
    PF_NAME=`echo "$name" | tr '[:upper:]' '[:lower:]'`
    # APK_NAME="techpos_${PF_NAME}_demo"
    PF_ID=$pf_id
    PF_APIKEY=$pf_apikey
}
### Demo ve Prod ortam oluşturulacaksa
get_multiple_values(){
    ### Mükellef değeri alınır
    printf "${PURPLE}----- Mükellef Değerleri -----${NC}\n"
    echo -n "$(tput setaf 6)Mükellef giriniz <sipay, nkolay vs.> : $(tput setaf 3)"
    read -r name
    name=`echo $name|tr -d '[:punct:]'`  # Noktalama işaretleri kaldırılır

    ### Mükellefin ID değeri alınır
    echo -n "$(tput setaf 6)Mükellef Prod PF ID giriniz : $(tput setaf 3)"
    read -r prod_pf_id

    echo -n "$(tput setaf 6)Mükellef Demo PF ID giriniz : $(tput setaf 3)"
    read -r demo_pf_id
    ### Girilen id değeri sayı olarak alındığı kontrol edilir
    reg='^[0-9]+$'
    if ! [[ $prod_pf_id =~ $reg && $demo_pf_id =~ $reg ]]; then
        echo "error: Not a number" >&2;
        exit 1
    fi
    ### PF APIKEY değeri alınır
    echo -n "$(tput setaf 6)Mükellef Prod PF APIKEY giriniz : $(tput setaf 3)"
    read -r prod_pf_apikey

    echo -n "$(tput setaf 6)Mükellef Demo PF APIKEY giriniz : $(tput setaf 3)"
    read -r demo_pf_apikey
    ### Değişkenler ayarlanır
    PF_NAME=`echo "$name" | tr '[:upper:]' '[:lower:]'`
    # APK_NAME="techpos_${PF_NAME}_demo"

}
##################### Mükellef Tanımı (Bitiş) #####################

##################### Pavopay/Techpos Prod/Demo Template Oluşturma (Başlangıç) #####################
### Pavopay Prod mükellefinin oluşturulması
change_pavopay_prod(){
    # overpay-prod-template.yml üzerinde karşılık gelen değişkenler:
    #   PP_APK_NAME for APK_NAME
    #   PP_PF_NAME for PF_NAME
    #   PP_PF_ID for PF_ID
    #   PP_PF_APIKEY for PF_APIKEY
    APK_NAME="overpay_${PF_NAME}"

    cp templates/overpay-prod-template.yml created-pf/$APK_NAME-template.yml
    sed -i "s:PP_APK_NAME:$APK_NAME:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:PP_PF_NAME:${PF_NAME^}:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:PP_PF_ID:$PF_ID:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:PP_PF_APIKEY:$PF_APIKEY:g" "created-pf/$APK_NAME-template.yml"
}
### Pavopay Demo mükellefinin oluşturulması
change_pavopay_demo(){
    # overpay-demo-template.yml üzerinde karşılık gelen değişkenler:
    #   - PD_APK_NAME için APK_NAME
    #   - PD_PF_NAME için PF_NAME
    #   - PD_PF_ID için PF_ID
    #   - PD_PF_APIKEY için PF_APIKEY
    APK_NAME="overpay_${PF_NAME}_demo"

    cp templates/overpay-demo-template.yml created-pf/$APK_NAME-template.yml
    sed -i "s:PD_APK_NAME:$APK_NAME:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:PD_PF_NAME:${PF_NAME^}:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:PD_PF_ID:$PF_ID:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:PD_PF_APIKEY:$PF_APIKEY:g" "created-pf/$APK_NAME-template.yml"

}
### BKM Techpos Prod mükellefinin oluşturulması
change_techpos_prod(){
    # techpos-prod-template.yml üzerinde karşılık gelen değişkenler:
    #   - TP_APK_NAME için APK_NAME
    #   - TP_PF_NAME için PF_NAME
    #   - TP_PF_ID için PF_ID
    #   - TP_PF_APIKEY için PF_APIKEY
    APK_NAME="techpos_${PF_NAME}"

    cp templates/techpos-prod-template.yml created-pf/$APK_NAME-template.yml
    sed -i "s:TP_APK_NAME:$APK_NAME:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:TP_PF_NAME:${PF_NAME^}:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:TP_PF_ID:$PF_ID:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:TP_PF_APIKEY:$PF_APIKEY:g" "created-pf/$APK_NAME-template.yml"
}
### BKM Techpos Demo mükellefinin oluşturulması
change_techpos_demo(){
    # techpos-demo-template.yml üzerinde karşılık gelen değişkenler:
    #   - TD_APK_NAME için APK_NAME
    #   - TD_PF_NAME için PF_NAME
    #   - TD_PF_ID için PF_ID
    #   - TD_PF_APIKEY için PF_APIKEY
    APK_NAME="techpos_${PF_NAME}_demo"

    cp templates/techpos-demo-template.yml created-pf/$APK_NAME-template.yml
    sed -i "s:TD_APK_NAME:$APK_NAME:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:TD_PF_NAME:${PF_NAME^}:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:TD_PF_ID:$PF_ID:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:TD_PF_APIKEY:$PF_APIKEY:g" "created-pf/$APK_NAME-template.yml"
}
### custom_pos Prod mükellefinin oluşturulması
change_custom_pos_prod(){
    # techpos-prod-template.yml üzerinde karşılık gelen değişkenler:
    #   - CP_APK_NAME için APK_NAME
    #   - CP_PF_NAME için PF_NAME
    #   - CP_PF_ID için PF_ID
    #   - CP_PF_APIKEY için PF_APIKEY
    #   - CP_CUSTOM_APP_NAME kullanıcıdan al
    APK_NAME="custom_pos_${PF_NAME}"

    cp templates/custom_pos-prod-template.yml created-pf/$APK_NAME-template.yml
    sed -i "s:CP_APK_NAME:$APK_NAME:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:CP_PF_NAME:${PF_NAME^}:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:CP_PF_ID:$PF_ID:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:CP_PF_APIKEY:$PF_APIKEY:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:CP_CUSTOM_APP_NAME:$custom_app_name:g" "created-pf/$APK_NAME-template.yml"
}
### custom_pos Demo mükellefinin oluşturulması
change_custom_pos_demo(){
    # techpos-demo-template.yml üzerinde karşılık gelen değişkenler:
    #   - CD_APK_NAME için APK_NAME
    #   - CD_PF_NAME için PF_NAME
    #   - CD_PF_ID için PF_ID
    #   - CD_PF_APIKEY için PF_APIKEY
    #   - CD_CUSTOM_APP_NAME kullanıcıdan al
    APK_NAME="custom_pos_${PF_NAME}_demo"

    cp templates/custom_pos-demo-template.yml created-pf/$APK_NAME-template.yml
    sed -i "s:CD_APK_NAME:$APK_NAME:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:CD_PF_NAME:${PF_NAME^}:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:CD_PF_ID:$PF_ID:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:CD_PF_APIKEY:$PF_APIKEY:g" "created-pf/$APK_NAME-template.yml"
    sed -i "s:CD_CUSTOM_APP_NAME:$custom_app_name:g" "created-pf/$APK_NAME-template.yml"
}
##################### Pavopay/Techpos Prod/Demo Template Oluşturma (Bitiş) #####################

##################### Mükellef Oluşturma (Başlangıç) #####################
### get_single_values fonksiyonu kullanılır
one_environment(){
    get_single_values
    printf "${PURPLE}----- Uygulama Seçimi -----${NC}\n"
    printf "$(tput setaf 6)Format seçiniz : \n Pavopay Prod : PP|pp, Pavopay Demo : PD|pd,\
 BKM Techpos Prod : TP|tp, BKM Techpos Demo : TD|td, custom_pos Prod : CP|cp, custom_pos Demo : CD|cd\n\
 ${GREEN}Option :${NC} $(tput setaf 3)"
    read -r option


    case $option in 
        [P][P] | [p][p])
            ### Pavopay canlı ortamda oluşturulacak mükellefler   
            echo "Pavopay Prod Ortamı"
            change_pavopay_prod
            ;;
        [P][D] | [p][d])
            ### Pavopay demo ortamda oluşturulacak mükellefler
            echo "Pavopay Demo Ortamı"
            change_pavopay_demo
            ;;
        [T][P] | [t][p])
            ### BKM Techpos canlı ortamda oluşturulacak mükellefler   
            echo "BKM Techpos Prod Ortamı"
            change_techpos_prod
            ;;
        [T][D] | [t][d])
            ### BKM Techpos demo ortamda oluşturulacak mükellefler
            echo "BKM Techpos Demo Ortamı"
            change_techpos_demo
            ;;
        [C][P] | [c][p])
            ### custom_pos demo ortamda oluşturulacak mükellefler
            echo "custom_pos Prod Ortamı"
            ### Mükellefin CUSTOM_APP_NAME değeri alınır
            echo -n "$(tput setaf 6)CUSTOM APP NAME giriniz : $(tput setaf 3)"
            read -r custom_app_name
            custom_app_name=`echo $custom_app_name|tr -d '[:punct:]'`  # Noktalama işaretleri kaldırılır
            change_custom_pos_prod
            ;;
        [C][D] | [c][d])
            ### custom_pos demo ortamda oluşturulacak mükellefler
            echo "custom_pos Demo Ortamı"
            ### Mükellefin CUSTOM_APP_NAME değeri alınır
            echo -n "$(tput setaf 6)CUSTOM APP NAME giriniz : $(tput setaf 3)"
            read -r custom_app_name
            custom_app_name=`echo $custom_app_name|tr -d '[:punct:]'`  # Noktalama işaretleri kaldırılır
            change_custom_pos_demo
            ;;           
        *)
            usage
            ;;
    esac
}
### get_single_values fonksiyonu kullanılır
prod_environment(){
    ### Pavopay&Techpos Prod template ./created-pf klasöründe oluşturulur
    get_single_values
    change_pavopay_prod
    change_techpos_prod
    cat created-pf/*.yml > created-pf/${PF_NAME}-prod.yaml
    rm -r created-pf/*.yml
}
### get_single_values fonksiyonu kullanılır
demo_environment(){
    ### Pavopay&Techpos Demo template ./created-pf klasöründe oluşturulur
    get_single_values
    change_pavopay_demo
    change_techpos_demo
    cat created-pf/*.yml > created-pf/${PF_NAME}-demo.yaml
    rm -r created-pf/*.yml
}
### get_multiple_values fonksiyonu kullanılır
all_environment(){
    ### Pavopay&Techpos Prod&Demo template ./created-pf klasöründe oluşturulur
    get_multiple_values

    # overwrite PF_ID ve PF_APIKEY
    PF_ID=$prod_pf_id
    PF_APIKEY=$prod_pf_apikey
    change_pavopay_prod
    change_techpos_prod

    # overwrite PF_ID ve PF_APIKEY
    PF_ID=$demo_pf_id
    PF_APIKEY=$demo_pf_apikey
    change_pavopay_demo
    change_techpos_demo

    cat created-pf/*.yml > created-pf/${PF_NAME}-all.yaml
    rm -r created-pf/*.yml
}
### created-pf klasör içeriği her çalıştırılmada silinir.
file_num=`ls created-pf | wc -l`
if [[ $file_num != '0' ]];then 
    printf "${RED}Eski dosyalar siliniyor...${NC}\n"
    rm -r created-pf/* 
    printf "${GREEN}Eski dosyalar silindi.${NC}\n"
else
    printf "$(tput setaf 8)Eski dosya bulunamadı.${NC}\n"
fi
printf "${PURPLE}----- Mükellef Oluşturulacak Ortamın Seçilmesi -----${NC}\n"
printf "$(tput setaf 6)Mükellef tek bir ortamda oluşturulacak(örn. yanlızca techpos demo ya da pavopay prod vs.) : $(tput setaf 3)1${NC},\n\
$(tput setaf 6)Mükellef prod ortamda oluşturulacak(örn. techpos prod ve pavopay prod isteniyor) : $(tput setaf 3)2${NC},\n\
$(tput setaf 6)Mükellef demo ortamda oluşturulacak(örn. yanlızca techpos demo ve pavopay demo) : $(tput setaf 3)3${NC},\n\
$(tput setaf 6)Mükellef demo ve prod ortamda oluşturulacak(örn. techpos ve pavopay prod ve demosu ) : $(tput setaf 3)4${NC},\n\
$(tput setaf 6)Çıkmak için : $(tput setaf 3)0${NC},\n\
 ${GREEN}Option :${NC}  $(tput setaf 3)"
read -r option

case $option in 
    '1')
        ### Mükellef tek bir ortamda oluşturulacak
        printf "${PURPLE}----- Bir ortamda Mükellef Oluşturma -----${NC}\n"  
        one_environment
        echo "Dosya yolu : created-pf/"
        ;;
    '2')
        ### Mükellef prod ortamda oluşturulacak
        printf "${PURPLE}----- Prod ortamda Mükellef Oluşturma -----${NC}\n"  
        prod_environment
        echo "Dosya yolu : created-pf/"
        ;;
    '3')
        ### Mükellef demo ortamda oluşturulacak 
        printf "${PURPLE}----- Demo ortamda Mükellef Oluşturma -----${NC}\n"  
        demo_environment
        echo "Dosya yolu : created-pf/"
        ;;
    '4')
        ### Mükellef demo ve prod ortamda oluşturulacak
        printf "${PURPLE}----- Tüm ortamlarda Mükellef Oluşturma -----${NC}\n"  
        all_environment
        echo "Dosya yolu : created-pf/"
        ;;
    '0')
        exit 1
        ;;
    *)
        usage
        ;;
esac
##################### Mükellef Oluşturma (Bitiş) #####################