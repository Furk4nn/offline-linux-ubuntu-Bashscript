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
TECH="Diğer Teknolojiler"
#Access Permission
accessPermission(){
    sleep 1
    echo -e "\n###### ${Chmod} ####### "
    read -p "Dosya İzinleri Vermek İstiyor musunuz ? e\h " permissionResult
    if [[ $permissionResult == "e" || $permissionResult == "E" ]]
    then
        echo -e "Dosya İzinleri Başladı..."
        ./countdown.sh
        #chmpod : Dosya ve izinlerin erişimi için izinler
        #r: okuma 2^2=4
        #w: yazma 2^1=2
        #x: çalıştırma 2^0=1
        #Kullanıcı kategorileri
        #u: Dosya sahibi 
        #g: Grup üyeleri
        #o: Diğer kullanıcılar
        #a: Tüm kullanıcılar

        ls -al
        ls -l countdown.sh
        ls -l reboot.sh
        #izinleri sembolik olarak değiştirmek
        chmod u+rwx,g+rx,o+r ./script
        #izinleri sayısal olarak değiştirmek
        chmod 755 ./script
        #bash scriptlere izin vermek
        sudo chmod +x countdown.sh
        sudo chmod +x reboot.sh
        sudo chmod +x _2_other_programming.sh
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
                echo -e "Sistem Liste Güncellenmesi Yapılmadı..."
            fi
            ;;
        2)
             read -p "Sistemin Paketini Yükseltmek İstiyor musunuz ? e\h " systemListUpdatedResult
                if [[ $systemListUpdatedResult == "e" || $systemListUpdatedResult == "E" ]]
                 then
                    echo -e "Sistem Paket Güncellenmesi Başladı..."
                    ./countdown.sh
                    sudo apt-get update && sudo apt-get upgrade -y
                else
                    echo -e "Sistem Paket Güncellenmesi Yapılmadı..."
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
            echo -e "Kernel Güncellemesi Yapılmadı..."
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
        echo -e "Sistem Kapatılmadı..."
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
        #build-essential : Temel geliştirme araçları içeren meta-pakettir.
        sudo apt install build-essential wget unzip -y
        #Firewall Fonksiyonu
        theFirewallInstall
        theFirewallDelete
    else
        echo -e "Sistem İçin Genel Yükleme Yapılmadı..."
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
        #Yükleme
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
        echo -e "Sistemin İçin Genel Paket Yüklemesi Yapılmadı..."
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
        echo -e "Yüklenecek Paket Bağımlılığı..."
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1

        echo -e "####### Paket Bağımlılığı #######"
        read -p "Lütfen yüklemek istediğiniz paket adını yazınız examples: nginx" user_input

        #dependecy
        dependecy "$user_input"
    else
        echo -e "Paket Bağımlılıkları Yapılmadı..."
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
    sleep 2
    echo -e "\n###### ${UFW} ####### "
    read -p "Güvenlik Duvarı Kurulumlarını İstiyor musunuz ? e\h " ufwResult
    if [[ $ufwResult == "e" || $ufwResult == "E" ]]
    then
        echo -e "Güvenlik Duvarı Kurulumları Başladı..."
        ./countdown.sh
        netstat -nlptu
        sleep 3
        echo -e "####### UFW (Uncomplicated Firewall) #######" 
        #UFW kurulumu
        sudo apt install ufw -y

        #UFW Status
        sudo ufw status
       
       
        #Varsayılan giden trafik kurallarını belirleme (dış dünyaya yapılan bağlantıların varsayılan olarak izin verilemsi)
        #Tüm Giden Trafiğe İzin Verme
        sudo ufw default allow outgoing
        #SSH bağlantılarına izin verme (SSH bağlantıları için 22 numaralı portu açma)
        sudo ufw allow ssh

        sudo ufw allow 22
        sudo ufw allow 80
        sudo ufw allow 443
        sudo ufw allow 1111
        sudo ufw allow 2222
        sudo ufw allow 3333
        sudo ufw allow 3306
        sudo ufw allow 5432
        sudo ufw allow 8080
        sudo ufw allow 9000
        sudo ufw allow 9090
        #IP:127.0.0.1 DNS:localhost
        sudo ufw allow from 127.0.0.1 to ant port 8080
        #ufw etkinleştirme
        sudo ufw enable
        
        sudo ufw status
    else
        echo -e "Güvenlik Duvarı Açılmadı..."
    fi
}    
#theFirewallInstall
################################################################################################
#Güvenlik duvar DELETE(UFW => Uncomplicated Firewall)
theFirewallDelete(){
    sleep 2
    echo -e "\n###### ${UFW} ####### "
    read -p "Güvenlik Duvarını Kapatmak İstiyor musunuz ? e\h " ufwCloseResult
    if [[ $ufwCloseResult == "e" || $ufwCloseResult == "E" ]]
    then
        echo -e "Güvenlik Duvarı port,ip,gelen giden ağlar kapatılmaya başladı..."
        ./countdown.sh
        netstat -nlptu
        sleep 3
        echo -e "####### UFW (Uncomplicated Firewall) #######" 
        #UFW kurulumu
        sudo apt install ufw -y

        #UFW Status
        sudo ufw status
        #Varsayılan gelen trafik kurallarını belirleme (güvenliği arttırmak için gelen bağlantıları varsayılan olarak reddeder yalnızca belirlenenlere izin verir)
        #Tüm Gelen Trafiğe Engelle
        sudo ufw default deny incoming
        #SSH bağlantılarına izin verme (SSH bağlantıları için 22 numaralı portu açma)
        sudo ufw delete allow ssh

        sudo ufw delete allow 22
        sudo ufw delete allow 80
        sudo ufw delete allow 443
        sudo ufw delete allow 1111
        sudo ufw delete allow 8080
        sudo ufw delete allow 2222
        #IP:127.0.0.1 DNS:localhost
        sudo ufw delete allow from 127.0.0.1 to ant port 8080
        #ufw devre dışı bırakma
        sudo ufw disable
        
        sudo ufw status
    else
        echo -e "Güvenlik Duvarı Ayarları Kapatılmadı..."
    fi
}
#theFirewallDelete
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
        echo -e "Dosya İzinleri Yapılmadı..."
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
        echo -e "Temizleme Yapılmadı..."
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

##############################################################################################
##############################################################################################
#Clean
#Install
other_technology(){
    sleep 2
    echo -e "\n###### ${TECH} ####### "
    read -p "Sistem İçin Yüklemek İsteyeceğiniz Paketleri Yüklemek İstiyor musunuz ? e\h " otherResult
    if [[ $otherResult == "e" || $otherResult == "E" ]]
    then
        echo -e "Teknolojiler Yüklenmeye Başladı..."
        ./countdown.sh

        echo -e "####### Teknolojiler #######\n"
        ./_2_other_programming.sh
        
    else
        echo -e "Teknolojiler Yüklemeye Başlanmadı..."
    fi
}
other_technology