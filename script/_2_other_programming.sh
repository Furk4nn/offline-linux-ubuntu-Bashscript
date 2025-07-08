#!/bin/bash
#!/bin/bash
echo "Genel Kurumlar"
#User Variable
UPDATED="Güncelleme"
CLEANER="Temizleme"
INSTALL="Yükleme"
DELETED="Silme"
CHMOD="Erişim İzni"
INFORMATION="Genel Bilgiler Ports"
UFW="Uncomplicated Firewall Güvenlik Duvarı Yönetim Aracı"
LOGOUT="Sistemi Tekrar Başlatmak"
CHECK="Yüklenecek Paket Bağımlılıkları"
PACKAGE="Paket Sisteme Yüklü Mü"

################################################################################################
#Updated
Updated(){
    sleep 2
    echo -e "\n###### ${UPDATED} ####### "
    

    #Güncelleme tercihi
    echo -e "Güncelleme İçin seçim Yapınız\n1-)update\n2-)upgrade\n3-)dist-upgrade"
    read chooise
    #Girilen sayıya göre tercih 
    case $chooise in
        1)
            read -p "Sistemin Listesini Güncellemek İstiyor musunuz ? e\h " listUpdatedResult
            if [[ $listUpdatedResult == "e" || $listUpdatedResult == "E" ]]
                 then
                 echo -e "List Güncelleme Başladı..."
                 ./countdown.sh
                  sudo apt-get update
             else
                echo -e "Güncelleme Yapılmadı"
            fi
            ;;
        2)
             read -p "Sistemin Paketini Yükseltmek İstiyor musunuz ? e\h " systemListUpdatedResult
                if [[ $systemListUpdatedResult == "e" || $systemListUpdatedResult == "E" ]]
                 then
                    echo -e "Kernel Güncelleme Başladı..."
                    ./countdown.sh
                    sudo apt-get update && sudo apt-get upgrade -y
                else
                    echo -e "Güncelleme Yapılmadı"
                fi
            ;;
        3)
             read -p "Sistemin Çekirdeğini Güncellemek İstiyor musunuz ? e\h " kernelUpdatedResult
             if [[ $kernelUpdatedResult == "e" || $kernelUpdatedResult == "E" ]]
                then
                echo -e "Kernel Güncelleme Başladı..."
                ./countdown.sh
                sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
                #Çekirdek (Kernel) güncellemelerinde yeniden başlamak gerekebilir.
                sudo apt list --upgradable | grep linux-image
       
            else
            echo -e "Güncelleme Yapılmadı"
             fi
            ;;
        *)
            echo -e "Lütfen sadece size belirtilen seçeneklerden seçiniz"
            exit 1
            ;;
    esac
}
Updated
################################################################################################
#LogOut
logout(){
    sleep 2
    echo -e "\n###### ${LOGOUT} ####### "
    read -p "Sistemi Tekrar Kapatıp Açmak İstiyor musunuz ? e\h " logoutResult
    if [[ $logoutResult == "e" || $logoutResult == "E" ]]
    then
        echo -e "Sistem Kapatılıyor..."
        ./countdown.sh
        sudo apt update
        clean
        ./reboot.sh
    else
        echo -e "Sistem Kapatılmadı"
    fi
}
#logout
################################################################################################
#Git Package Install
#Install
gitInstall(){
    sleep 2
    echo -e "\n###### ${INSTALL} ####### "
    read -p "Git Paketini Yüklemek İstiyor musunuz ? e\h " gitInstallResult
    if [[ $gitInstallResult == "e" || $gitInstallResult == "E" ]]
    then
        echo -e "Git Paket Yükleme Başladı..."
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1
        echo -e "####### Git #######"
        #Git check package dependency fonksiyonunu çağır
        check_package
        #Yükleme
        sudo apt-get install git -y
        git version
        git config --global user.name "Furkan"
        git config --global user.email "furkan_ince06@hotmail.com"
        git config --global -l
        clean     

        #yüklenen paket hakkında bilgi
        is_loading_package

        #Paket bağımlılığını görme
        check_package
    else
        echo -e "Yükleme Yapılmadı"
    fi
}
gitInstall
#Paket Yüklendi mi
is_loading_package(){
    sleep 2
    echo -e "\n###### ${PACKAGE}} ####### "
    read -p "Paketin Yüklendiğini Öğrenmek İster Misiniz ? e\h " packageResult
    if [[ $packageResult == "e" || $packageResult == "E" ]]
    then
        echo -e "Yüklenmiş Paket Bilgisini Öğrenme"
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1

        echo -e "####### Paket Bağımlılığı #######"
        read -p "Lütfen yüklenmiş paket adını yazınız examples: git" user_input

        #dependecy
        package_information "$user_input"
    else
        echo -e "Paket Yüklenme Bilgisi İstenmedi..."
    fi
}
package_information(){
    #parametre - arguman
    local packagename=$1

    #Belirli bir komutun yolu (Sistemde nerede olduğunu gösterir)
    which $packagename
    #İlgi Paketi bulma
    whereis $packagename

    #paket bilgilerini görüntüle
    apt-cache show $packagename

    #Paketin yüklü olup olmadığını kontrol et
    dpkg-query -W -f='${Status} ${Package}\n' $packagename
    ./countdown.sh
    #Yüklü Tüm paketleri listele
    dpkg -l
    ./countdown.sh
    #Yüklü Tüm paketleri listele
    apt list --installed
    #Eğer paket isimleri uzunsa grep ile arama yap
    dpkg -l | grep $packagename
    #Belirli bir paketin yüklü olup olmadığını kontrol et
    app list --installed | grep $packagename
    #Dosyalarını listele
    dpkg -L $packagename

}
################################################################################################
#Paket Bağımlılıklarını Görme
check_package(){
    sleep 2
    echo -e "\n###### ${CHECK}} ####### "
    read -p "Sistemin İçin Genel Bağımlılık Paketini Yükleme İstiyor musunuz ? e\h " checkResult
    if [[ $checkResult == "e" || $checkResult == "E" ]]
    then
        echo -e "Yüklenecek Paket Bağımlılığı"
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1

        echo -e "####### Paket Bağımlılığı #######"
        read -p "Lütfen yüklemek istediğiniz paket adını yazınız examples: nginx" user_input

        #dependecy
        dependecy "$user_input"
    else
        echo -e "Bağımlılıklar kontrol edilmedi..."
    fi
}
dependecy(){
    #parametre - arguman
    local packagename=$1

    sudo apt-get check
    sudo apt-cache depends $packagename
    sudo apt-get install $packagename
}
################################################################################################
#Information
information(){
    sleep 1
    echo -e "\n###### ${INFORMATION} ####### "
    read -p "Genel Bilgileri Görmek İstiyor musunuz ? e\h " informationResult
    if [[ $informationResult == "e" || $informationResult == "E" ]]
    then
        echo -e "Genel Bilgiler Verilmeye Başlandı..."
        ./countdown.sh
        #sudo su
        echo -e "Ben Kimim => $(whoami)\n"
        sleep 1
        echo -e "Ağ Bilgileri => $(ifconfig)\n"
        sleep 1
        echo -e "Port Bilgileri => $(netstat -nlptu)\n"
        sleep 1
        echo -e "Linux Bilgileri => $(uname -a)\n"
        sleep 1
        echo -e "Dağıtım Bilgileri => $(lsb_release -a)\n"
        sleep 1
        echo -e "HDD Disk Bilgileri => $(df -m)\n"
        sleep 1
        echo -e "CPU Bilgileri => $(cat \proc\cpuingo)\n"
        sleep 1
        echo -e "RAM Bilgileri => $(free -m)\n"

    else
        echo -e "Dosya İzinleri Yapılmadı"
    fi

}
information
################################################################################################
#Clean
#Install
clean(){
    sleep 2
    echo -e "\n###### ${CLEANER} ####### "
    read -p "Sistemin Gereksiz Paketleri Temizlemek İstiyor musunuz ? e\h " cleanResult
    if [[ $cleanResult == "e" || $cleanResult == "E" ]]
    then
        echo -e "Gereksiz Paket Temizliği Başladı..."
        ./countdown.sh

        echo -e "####### nginx #######"
        sudo apt-get autoremove -y
        sudo apt autoclean
            echo -e "Kırık Bağımlılıkları Yükle..."
            sudo apt install -f
    else
        echo -e "Güncelleme Yapılmadı"
    fi
}
clean
##############################################################################################
#Port and Version
portVersion(){
    node -v
    zip -v
    unzip -v+
    #build-essential:
    gcc --version # gcc: GNU C compiler derlemek 
    g++ --version # g++: GNU C++ compiler derleme
    maker -version # make: Makefile kullanarak derlemek
    #java --version
    #git --version
    #docker-compose -v
}
portVersion
