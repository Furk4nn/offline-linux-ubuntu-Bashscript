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
                echo -e "Sistem Listesi Güncellenmesi Yapılmadı"
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
                    echo -e "Sistem Paket Güncellenmesi Yapılmadı"
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
            echo -e "Kernel Güncelleme Yapılmadı"
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
    Updated # Güncelleme fonksiyonunu
    ./countdown.sh #Geri sayım fonksiyonu
    sleep 2
    echo -e "\n###### ${INSTALL} ####### "
    read -p "Git Paketini Yüklemek İstiyor musunuz ? e\h " gitInstallResult
    if [[ $gitInstallResult == "e" || $gitInstallResult == "E" ]]
    then
        echo -e "Git Paket Yükleme Başladı..."
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1
        echo -e "####### Git #######\n"

        #Yükleme
        sudo apt-get install git -y
        git version
        git config --global user.name "Furkan"
        git config --global user.email "furkan_ince06@hotmail.com"
        git config --global -l

        ./countdown.sh
        echo -e "####### Git Version #######\n"
        git --version

        clean     

        #yüklenen paket hakkında bilgi
        is_loading_package

        #Git check package dependency fonksiyonunu çağır
        check_package
    else
        echo -e "Git Yükleme Yapılmadı"
    fi
}
gitInstall
################################################################################################
#VS Code Install
#Install
vsCodeInstall(){
      Updated # Güncelleme fonksiyonunu
    ./countdown.sh #Geri sayım fonksiyonu
    sleep 2
    echo -e "\n###### ${INSTALL} ####### "
    read -p "VS Code Paketini Yüklemek İstiyor musunuz ? e\h " vscodeInstallResult
    if [[ $vscodeInstallResult == "e" || $vscodeInstallResult == "E" ]]
    then
        echo -e "VS Code Paket Yükleme Başladı..."
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1
        echo -e "####### VS CODE #######"
        
        #Yükleme
        sudo  snap install code --classic
        sleep 1

        sudo mkdir frontend
        cd frontend
        code .

        clean     

        #yüklenen paket hakkında bilgi
        is_loading_package

        #VS CODE check package dependency fonksiyonunu çağır
        check_package
    else
        echo -e "VS Code Yükleme Yapılmadı"
    fi
}
vsCodeInstall
################################################################################################
#JDK Install
#Install
jdkInstall(){
    Updated # Güncelleme fonksiyonunu
    ./countdown.sh #Geri sayım fonksiyonu
    sleep 2
    echo -e "\n###### ${INSTALL} ####### "
    read -p "JDK Paketini Yüklemek İstiyor musunuz ? e\h " jdkInstallResult
    if [[ $jdkInstallResult == "e" || $jdkInstallResult == "E" ]]
    then
        echo -e "JDK Paket Yükleme Başladı..."
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1
        echo -e "####### JDK #######"
        
        #Yükleme
       sudo apt-get install openjdk-11-jdk -y
       sudo add-apt-repository ppa:openjdk-r/ppa -y
       echo -e "#Java Home\nJAVA_HOME=\"/usr/lib/jvm/java-11-openjdk-amd64/bin/\" " >> ~/.bashrc

       #sudo update-alternatives --config java

        ./countdown.sh
        echo -e "####### JDK #######\n"
        which git
        which java
        java --version
        javac --version

        clean     

        #yüklenen paket hakkında bilgi
        is_loading_package

        #VS CODE check package dependency fonksiyonunu çağır
        check_package
    else
        echo -e "JDK Yükleme Yapılmadı"
    fi
}
jdkInstall

################################################################################################
#Maven Install
#Install
mavenInstall(){
    Updated # Güncelleme fonksiyonunu
    ./countdown.sh #Geri sayım fonksiyonu
    sleep 2
    echo -e "\n###### ${INSTALL} ####### "
    read -p "MAVEN Paketini Yüklemek İstiyor musunuz ? e\h " mavenInstallResult
    if [[ $mavenInstallResult == "e" || $mavenInstallResult == "E" ]]
    then
        echo -e "MAVEN Paket Yükleme Başladı..."
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1
        echo -e "####### MAVEN #######"
        
        #Yükleme
        java --version
        javac --version
        ./countdown.sh
        #Maven Yükle
        sudo apt install maven 
        ./countdown.sh
        echo -e "####### Version #######\n"
        which git
        which java
        which maven
        git --version
        java --version
        javac --version
        mvn --version

        clean     

        #yüklenen paket hakkında bilgi
        is_loading_package

        #VS CODE check package dependency fonksiyonunu çağır
        check_package
    else
        echo -e "Git Yükleme Yapılmadı"
    fi
}
mavenInstall
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
    git --version
    java --version
    javac --version
    mvn --version
    #docker-compose -v
}
portVersion
