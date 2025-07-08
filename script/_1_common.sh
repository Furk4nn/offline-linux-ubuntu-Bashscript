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

#Access Permission
accessPermission(){
    sleep 1
    echo -e "\n###### ${Chmod} ####### "
    read -p "Dosya İzinleri Vermek İstiyor musunuz ? e\h " permissionResult
    if [[ $permissionResult == "e" || $permissionResult == "E" ]]
    then
        echo -e "Dosya İzinleri Başladı..."
        ./countdown.sh
        sudo chmod +x countdown.sh
        sudo chmod +x reboot.sh
    else
        echo -e "Dosya İzinleri Yapılmadı"
    fi
}
################################################################################################
##Function Calling
accessPermission
################################################################################################
#Updated
Updated(){
    sleep 2
    echo -e "\n###### ${UPDATED} ####### "
    read -p "Sistemin Listesini Güncellemek İstiyor musunuz ? e\h " listUpdatedResult
    if [[ $listUpdatedResult == "e" || $listUpdatedResult == "E" ]]
    then
        echo -e "List Güncelleme Başladı..."
        ./countdown.sh
        sudo apt-get update
    else
        echo -e "Güncelleme Yapılmadı"
    fi

     read -p "Sistemin Paketini Yükseltmek İstiyor musunuz ? e\h " systemListUpdatedResult
    if [[ $systemListUpdatedResult == "e" || $systemListUpdatedResult == "E" ]]
    then
        echo -e "Kernel Güncelleme Başladı..."
        ./countdown.sh
        sudo apt-get update && sudo apt-get upgrade -y
    else
        echo -e "Güncelleme Yapılmadı"
    fi

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
#Install
Install(){
    sleep 2
    echo -e "\n###### ${INSTALL} ####### "
    read -p "Sistemin İçin Genel Yükleme İstiyor musunuz ? e\h " commonInstallResult
    if [[ $commonInstallResult == "e" || $commonInstallResult == "E" ]]
    then
        echo -e "Genel Yükleme Başladı..."
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1
        sudo apt-get install vim -y
        sleep 1
        sudo apt-get install rar -y
        sleep 1
        sudo apt-get install unrar -y
        sleep 1
        sudo apt-get install curl -y
        sleep 1
        sudo apt-get install openssh-server -y
        sleep 1
        sudo apt install build-essential wget unzip -y
        #build-essential : Temel geliştirme araçları içeren meta-pakettir.
    else
        echo -e "Güncelleme Yapılmadı"
    fi

}
Install
################################################################################################
#Package Install
#Install
PackageInstall(){
    sleep 2
    echo -e "\n###### ${INSTALL} ####### "
    read -p "Sistemin İçin Genel Paket Yükleme İstiyor musunuz ? e\h " packageInstallResult
    if [[ $packageInstallResult == "e" || $packageInstallResult == "E" ]]
    then
        echo -e "Genel Paket Yükleme Başladı..."
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1
        echo -e "####### nginx #######"
        #Nginx check package dependency fonksiyonunu çağır
        check_package
        sudo apt-get install nginx -y
        sudo systemctl star nginx
        sudo systemctl enable nginx
        ./countdown.sh
        echo -e "####### nodejs #######"
        sudo apt-get install nodejs -y
        ./countdown.sh
        echo -e "####### Brute Force #######"
        sudo apt-get install fail2ban -y
        sudo systemctl star fail2ban
        sudo systemctl enable fail2ban
        ./countdown.sh
        echo -e "####### Monitoring #######"
        sudo apt-get install htop iftop net-tools -y
        echo -e "####### Python #######"
        sudo apt-get install python3 python3-pip -y
    else
        echo -e "Güncelleme Yapılmadı"
    fi
}
PackageInstall
################################################################################################
#Paket Bağımlılıklarını Görme
check_package(){
sleep 2
    echo -e "\n###### ${CHECK}} ####### "
    read -p "Sistemin İçin Genel Paket Yükleme İstiyor musunuz ? e\h " checkResult
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
        echo -e "Güncelleme Yapılmadı"
    fi
}
dependecy(){
    #parametre - arguman
    local packagename=$1

    sudo apt-get check
    sudo apt-cache depends $packagename
    sudo apt-get install $packagename
}
theFirewallInstall
################################################################################################
#Güvenlik duvar INSTALL(UFW => Uncomplicated Firewall)
theFirewallInstall(){

}
theFirewallInstall
################################################################################################
#Güvenlik duvar DELETE(UFW => Uncomplicated Firewall)
theFirewallDelete(){

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
    #node -v
    #java --version
    #git --version
    #docker-compose -v
    #zip -v
    #unzip -v+
    #build-essential:
    #gcc --version # gcc: GNU C compiler derlemek 
    #g++ --version # g++: GNU C++ compiler derleme
    #maker -version # make: Makefile kullanarak derlemek
    
}
