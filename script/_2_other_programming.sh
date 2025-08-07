#!/bin/bash
echo "Diğer Kurumlar"
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
DOCKER_PULL="Docker Pulling"
LOGIN="Docker Login"
LOGOUT="Docker Logout"
PORTAINER="Docker Portainer"
DOCKERCOMPOSE="Docker Compose"
POSTGRESQL="RDBMS PostgreSQL"
SONARQUBE="SonarQube"

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
        echo -e "Maven Yükleme Yapılmadı"
    fi
}
mavenInstall
################################################################################################
#Apache Tomcat Install
#Install
apacheTomcatInstall(){
    Updated # Güncelleme fonksiyonunu
    ./countdown.sh #Geri sayım fonksiyonu
    sleep 2
    echo -e "\n###### ${INSTALL} ####### "
    read -p "APACHE TOMCAT Paketini Yüklemek İstiyor musunuz ? e\h " apachetomcatInstallResult
    if [[ $apachetomcatInstallResult == "e" || $apachetomcatInstallResult == "E" ]]
    then
        echo -e "APACHE TOMCAT Paket Yükleme Başladı..."
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1
        echo -e "####### APACHE TOMCAT #######"
        
        #Yükleme
        java --version
        javac --version
        mvn --version
        ./countdown.sh
        
        #APACHE TOMCAT Yükle
        #Tomcat 10 için en az JDK 11 kurmalısınız.
        wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.8/bin/apache-tomcat-10.0.8.tar.gz
        sudo tar xzvf apache-tomcat-10.0.8.tar.gz
        sudo mkdir /opt/tomcat/
        sudo mv apache-tomcat-10.0.8/* /opt/tomcat/
        sudo chown -R www-data:www-data /opt/tomcat/
        sudo chmod -R 755 /opt/tomcat/
        

        ./countdown.sh

        #Tomcat servisini başlatmak ve etkinleştirmek

        sudo systemctl daemon-reload
        sudo systemctl start tomcat
        #Restart Tomcat
        sudo systemctl restart tomcat
        
        #Test
        curl http://localhost:8080


        #Tomcat servisini otomatik olarak başlatıyor.
        sudo systemctl enable tomcat

        /opt/tomcat/bin/catalina.sh version


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
        echo -e "Apache Tomcat Yükleme Yapılmadı..."
    fi
}
apacheTomcatInstall

################################################################################################
#Docker Install
#Install
dockerInstall(){
    Updated # Güncelleme fonksiyonunu
    ./countdown.sh #Geri sayım fonksiyonu
    sleep 2
    echo -e "\n###### ${INSTALL} ####### "
    read -p "DOCKER TOMCAT Paketini Yüklemek İstiyor musunuz ? e\h " dockerInstallResult
    if [[ $dockerInstallResult == "e" || $dockerInstallResult == "E" ]]
    then
        echo -e "DOCKER Paket Yükleme Başladı..."
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1
        echo -e "####### DOCKER #######"
        
        #Yükleme
        git --version
        java --version
        javac --version
        mvn --version
        ./countdown.sh
        
        #Docker Yükle
        #Eğer sistemde Docker varsa sil
        sudo apt-get pruge docker-ce docker-ce-cli containerd.io -y
        sudo rm -rf /var/lib/docker
        sudo rm -rf /var/lib/containerd
        sudo apt-get clean
        sudo apt-get autoremove -y
        sudo apt-get update
        sudo apt-get remove docker docker-engine docker.io containerd runc
        sudo apt-get update
        sudo apt-get upgrade 

        ## HTTPS üzerinden bir depo kullanmasına izin vermek için
        sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

        ## Docker'ın resmi GPG anahtarını ekleyin . curl aracı ile gpg anahatırın 
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo apt-key fingerprint 0EBFCD88

        ## curl aracı ile docker apt deposunu eklemek

        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

        ## docker kurulumu
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io -y

        #sudo systemctl status docker
        #sleep 2
        sudo systemctl enable --now docker
        sudo systemctl start docker

        ##kullanıcı adınızı docker grubuna ekleyin
        sudo usermod -aG docker ${USER}

        su - ${USER}
        sudo id -NG
        sudo apt-get install bash-completion
        docker version
        #docker image oluştursun
        
        docker run hello-world

        ./countdown.sh

        #docker pulling
        dockerPulling
        dockerHubLogin
        dockerHubLogout
        dockerPortainer #docker linux ubuntu portainer
        dockerCompose   #docker compose
        #version
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
        echo -e "Docker Yükleme Yapılmadı..."
    fi
}
dockerInstall
#dockerPulling
dockerPulling(){
    ./countdown.sh #Geri sayım fonksiyonu
    sleep 2
    echo -e "\n###### ${DOCKER_PULL} ####### "
    read -p "\nDockerHub'a Pull Yapmak İstiyor Musunuz ? e\h " updatedResult
    if [[ $updatedResult == "e" || $updatedResult == "E" ]]
    then
        echo -e "Docker Pulling..."
        sudo docker pull nginx
        sudo docker pull httpd #apache
        docker pull tomcat:9.0.8-jre8-alpine
        sudo docker pull mysql
        sudo docker pull postgres
        sudo docker pull ubuntu
        sudo docker pull alpine
        sudo docker pull centos
        sudo docker pull node #nodejs
        sudo docker pull mongo #nosql
        sudo docker pull redis
        sudo docker pull python:3.8
        docker images

        ./countdown.sh #Geri sayım fonksiyonu
        #Docker Üzerinden Apache Tomcat'i Ayağa Kaldırmak
        ./docker_tomcat.sh #Docker Tomcat fonksiyonunu çağır
    else
        echo -e "apt-get Update List Güncellemesi Yapılmadı!!!\n"
    fi
}

##Docker Login
dockerHubLogin(){
    ./countdown.sh #Geri sayım fonksiyonu
    sleep 2
    echo -e "\n###### ${LOGIN} ####### "
    read -p "\nDockerHub'a Giriş Yapmak İstiyor Musunuz ? e\h " updatedResult
    if [[ $updatedResult == "e" || $updatedResult == "E" ]]
    then
        echo -e "DockerHub Giriş Yapılıyor..."
        sudo docker login
    else
        echo -e "DockerHub Giriş Yapılmadı"
    fi
}

##Docker Logout
dockerHubLogout(){
    ./countdown.sh #Geri sayım fonksiyonu
    sleep 2
    echo -e "\n###### ${LOGOUT} ####### "
    read -p "\nDockerHub'a Çıkış Yapmak İstiyor Musunuz ? e\h " updatedResult
    if [[ $updatedResult == "e" || $updatedResult == "E" ]]
    then
        echo -e "DockerHub Giriş Yapılıyor..."
        sudo docker logout
    else
        echo -e "DockerHub Giriş Yapılmadı"
    fi
}

#Docker Portainer
dockerPortainer(){
   # Geri Sayım
    sudo ./countdown.sh

    echo -e "\n### ${PORTAINER} ###"
    read -p "\nDockerHub'a Çıkış yapmak istiyor musunuz ? E/H? " portainerResult
    if [[ $portainerResult == "E" || $portainerResult == "e"  ]]
    then
        echo -e "Docker Portainer ... "  
         # Geri Sayım
        sudo ./countdown.sh
        echo -e "Docker Portainer Kurulum Başladı " 
        ##### Aşağıdaki kodları yaz ##########################################
        sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

        # Geri Sayım
        sudo ./countdown.sh
        echo -e "Docker Portainer CHMOD " 
        ##### CHMOD ##########################################
        sudo chmod +x /usr/local/bin/docker-compose
        sudo docker volume create portainer_data

        ##### PORT##########################################
        # Geri Sayım
        sudo ./countdown.sh
        echo -e "Docker Portainer Port "
        sudo docker run -d -p 2222:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /srv/portainer:/data portainer/portainer
        # Geri Sayım
        sudo ./countdown.sh
        echo -e "Docker Portainer Start "
        sudo docker start portainer
        #sudo docker stop portainer

        ##### CHMOD ##########################################
        sudo ifconfig
        # Geri Sayım
        sudo ./countdown.sh
        echo -e "Docker Portainer http:localhost:2222"
        sudo curl localhost:2222 

        # username:root
        # password:rootroot

    else
        echo -e "Docker Portainer Ekleme Yapılmadı!!!\n "   
    fi
}

dockerCompose(){
    ./countdown.sh #Geri sayım fonksiyonu
    echo -e "\n### ${DOCKERCOMPOSE} ###"
    read -p "\nDocker Compose Eklemek İstiyor musunuz ? E/H? " dockerComposeResult
    if [[ $dockerComposeResult == "E" || $dockerComposeResult == "e"  ]]
    then
        echo -e "Docker Compose Ekleniyor ... " 
    else
        echo -e "Docker Compose Ekleme Yapılmadı!!!\n "   
    fi
}

postgresqlInstall(){
    Updated # Güncelleme fonksiyonunu
    ./countdown.sh #Geri sayım fonksiyonu
    sleep 2
    echo -e "\n###### ${POSTGRESQL} ####### "
    read -p "POSTGRESQL Paketini Yüklemek İstiyor musunuz ? e\h " postgresqlInstallResult
    if [[ $postgresqlInstallResult == "e" || $postgresqlInstallResult == "E" ]]
    then
        echo -e "POSTGRESQL Paket Yükleme Başladı..."
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1
        echo -e "####### POSTGRESQL #######"
        
        #Yükleme
        java --version
        javac --version
        mvn --version
        ./countdown.sh
        
        #POSTGRESQL Yükle
        sudo ufw allow 5432
         # sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
        echo -e "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main " | sudo tee --append /etc/apt/sources.list.d/pgdg.list
        sudo wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
        sudo apt-get -y install postgresql postgresql-contrib

        sleep 2
        echo -e "######Postgresql Enable"
        sudo systemctl enable postgresql

        sleep 2
        echo -e "Postgresql Start"
        sudo systemctl start postgresql

        echo -e "Postgresql yeni şifre: sonarqube yapalım"
        # yeni şifre sonarqube
        sudo passwd postgres
        su - postgres
        createuser sonar
        psql
        ALTER USER sonar WITH ENCRYPTED password 'sonar';
        CREATE DATABASE sonarqube OWNER sonar;
        grant all privileges on DATABASE sonarqube to sonar;
        \q
        exit

        sleep 2
        echo -e "Postgreql Bağımlılılar Yükleniyor"
        sudo apt install -f

        sleep 2
        echo -e "5432 PORT"
        sudo netstat -nlptu | grep 5432
        sudo netstat -nlptu



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
        echo -e "Apache Tomcat Yükleme Yapılmadı..."
    fi
}
postgresqlInstall

sonarQubeInstall()
{
    Updated # Güncelleme fonksiyonunu
    ./countdown.sh #Geri sayım fonksiyonu
    sleep 2
    echo -e "\n###### ${SONARQUBE} ####### "
    read -p "SonarQube Paketini Yüklemek İstiyor musunuz ? e\h " sonarQubeInstallResult
    if [[ $sonarQubeInstallResult == "e" || $sonarQubeInstallResult == "E" ]]
    then
        echo -e "SonarQube Paket Yükleme Başladı..."
        ./countdown.sh
        echo -e "Bulunduğum Dizin => $(pwd)\n"
        sleep 1
        echo -e "####### SonarQube #######"
        
        #Yükleme
        java --version
        javac --version
        mvn --version
        ./countdown.sh
        
        sudo ufw allow 9000

        sleep 2
        sudo sysctl -w vm.max_map_count=524288
        sudo sysctl -w fs.file-max=131072
        sudo ulimit -n 131072
        sudo ulimit -u 8192
        sudo ufw allow 9000

        sleep 2
        #echo -e "#SonarQube Home\nsonarqube   -   nofile   65536\nsonarqube   -   nproc    4096  " >> /etc/security/limits.conf
        echo -e "#SonarQube Home\nsonarqube   -   nofile   65536\nsonarqube   -   nproc    4096  " | sudo tee --append /etc/security/limits.conf

        cd /tmp
        sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.0.65466.zip
        sudo unzip sonarqube-9.9.0.65466.zip -d /opt
        sudo mv /opt/sonarqube-9.9.0.65466 /opt/sonarqube
        sudo groupadd sonar
        sudo useradd -c "user to run SonarQube" -d /opt/sonarqube -g sonar sonar 
        sudo chown sonar:sonar /opt/sonarqube -R
        echo -e "### Sonar Config Yükleme Başlandı... "
        echo -e "#SonarQube Config" | sudo tee --append /opt/sonarqube/conf/sonar.properties
        echo -e "sonar.jdbc.username=sonar" | sudo tee --append /opt/sonarqube/conf/sonar.properties
        echo -e "sonar.jdbc.password=sonarqube" | sudo tee --append /opt/sonarqube/conf/sonar.properties
        echo -e "sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonarqube" | sudo tee --append /opt/sonarqube/conf/sonar.properties
        echo -e "sonar.web.port=9000 " | sudo tee --append /opt/sonarqube/conf/sonar.properties
        echo -e "#sonar.web.host=127.0.0.1 " | sudo tee --append /opt/sonarqube/conf/sonar.properties
        echo -e "#sonar.web.context=/sonar" | sudo tee --append /opt/sonarqube/conf/sonar.properties
        echo -e "RUN_AS_USER=sonar" | sudo tee --append /opt/sonarqube/bin/linux-x86-64/sonar.sh

        echo -e "#my special Sonar" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "[Unit]" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "Description=SonarQube service" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "After=syslog.target network.target" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "[Service]" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "Type=forking" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "User=sonar" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "Group=sonar" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "Restart=always" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "LimitNOFILE=65536" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "LimitNPROC=4096" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "[Install]" | sudo tee --append /etc/systemd/system/sonar.service
        echo -e "WantedBy=multi-user.target" | sudo tee --append /etc/systemd/system/sonar.service


        echo -e "Bağımlılıklar Yükleniyor"
        sudo apt install –f 

        echo -e "### Sudo su sonar başladı... ################################ "
        # sudo su sonar
        # echo -e "./sonar.sh start" | sudo tee --append /opt/sonarqube/bin/linux-x86-64
        # echo -e "./sonar.sh status" | sudo tee --append /opt/sonarqube/bin/linux-x86-64
        # echo -e "tail" | sudo tee --append /opt/sonarqube/logs/sonar.log
        # echo -e "./sonar.sh stop" | sudo tee --append /opt/sonarqube/bin/linux-x86-64
        # exit
        sudo su sonar
        cd /opt/sonarqube/bin/linux-x86-64/
        ./sonar.sh start
        ./sonar.sh status
        tail /opt/sonarqube/logs/sonar.log
        cd /opt/sonarqube/bin/linux-x86-64/
        ./sonar.sh stop
        exit

        # bunu yazmazsan çalışmaz
        sudo sysctl -w vm.max_map_count=262144
        sysctl vm.max_map_count
        sudo netstat -ntlp | grep 9000
        #journalctl -u sonar
        ./countdown.sh
        
        echo -e "### systemctl daemon-reload ################################ "
        sudo systemctl daemon-reload
        sudo systemctl enable sonar
        sudo systemctl start sonar
        sudo systemctl restart sonar
}
sonarQubeInstall


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
    /opt/tomcat/bin/catalina.sh version
    docker-compose -v
}
portVersion
