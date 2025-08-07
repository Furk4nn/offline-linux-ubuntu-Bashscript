#!/bin/bash
echo "Docker Tomcat"

TOMCAT="Apache Tomcat"


#dockertomcat
dockerTomcat(){
    sleep 2
    echo -e "\n###### ${TOMCAT} ####### "
    read -p "Docker Üzerinden Apache Tomcat Kurmak İstiyor musunuz ? e\h " dockerTomcatResult
    if [[ $dockerTomcatResult == "e" || $dockerTomcatResult == "E" ]]
    then
        echo -e "Docker Tomcat Kurulumu..."
        ./countdown.sh
        #docker
        docker search tomcat
        docker pull tomcat:9.0.8-jre8-alpine
        docker images
        docker run -d --name my_tomcat1 -p 1111:8000 tomcat:9.0.8-jre8-alpine
        docker container ps
        
        curl localhost:1111

        #Windows üzerinde devam ediyorsam
       
        read -p "OS işletim sistemini seçiniz Windows ? e\h " osResult
        if [[ $osResult == "e" || $osResult == "E" ]]
        
        echo -e "Windows..."
        ./countdown.sh
         winpty docker container exec -it my_tomcat1 bash
        ls -al
        cd bin
        else
        echo -e "Ubuntu..."
        docker container exec -it my_tomcat1 bash
        fi
    else
    echo -e "Docker Üzerinden Apache Tomcat Çalıştırılmadı."
    fi

}
dockerTomcat