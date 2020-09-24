#!/usr/bin/env bash


#timer
clear
hour=0
min=0
sec=10
echo -e "  \033[0;34m              Script Auto JDK by Luka Oliveira
           
  \033[0;31m  For more scripts visit: https://gitlab.com/Draiderz"
        while [ $hour -ge 0 ]; do
                 while [ $min -ge 0 ]; do
                         while [ $sec -ge 0 ]; do
                                 echo -ne " \033[0m            The installation will start in: $hour:$min:$sec\033[0K\r"
                                 let "sec=sec-1"
                                 sleep 1
                         done
                         sec=59
                         let "min=min-1"
                 done
                 min=59
                 let "hour=hour-1"
         done
echo ""
clear

#Extract JDK to /opt and add to PATH
function installJDK (){
    echo -e "\033[01;31;47mRoot access is required to extract files to / opt..."
    echo -e "\033[0mExtracting files to /opt..."
    if ! sudo tar xvzf jdkpack.tar.gz -C /opt
    then
        echo -e "\033[01;31;47mFailed to extract files to opt"
        exit 1
    fi
        echo "Files successfully extracted..."

    echo "Adding JDK to PATH..."
    if [ $jdkVersion == 14 ]
    then
        if ! echo -e 'export JAVA_HOME="/opt/jdk-14.0.2"\nexport PATH="$PATH:${JAVA_HOME}/bin"\n' | sudo tee /etc/profile.d/openjdk14.sh
        then
            echo "Failed to add to PATH"
            exit 1
        fi
            echo "OpenJDK-14 Installed successfully! Restart your computer to finish!"
            exit 1
    else
        if [ $jdkVersion == 15 ]
        then
            if ! echo -e 'export JAVA_HOME="/opt/jdk-15"\nexport PATH="$PATH:${JAVA_HOME}/bin"\n' | sudo tee /etc/profile.d/openjdk15.sh
            then
                echo "Failed to add to PATH"
                exit 1
            fi
                echo "OpenJDK-15 Installed successfully! Restart your computer to finish!"
                exit 1
        else
            if [ $jdkVersion == 16 ]
            then
                if ! echo -e 'export JAVA_HOME="/opt/jdk-16"\nexport PATH="$PATH:${JAVA_HOME}/bin"\n' | sudo tee /etc/profile.d/openjdk16.sh
                then
                    echo "Failed to add to PATH"
                    exit 1
                fi
                    echo "OpenJDK-16 Installed successfully! Restart your computer to finish!"
                    exit 1
            fi
        fi
    fi

}

#Version Selection
function chooseVersion () {
    echo -e "\033[01;31;47mChoose a version: 14, 15 or 16: \033[0m "
    read jdkVersion
    if [ $jdkVersion == 14 ]
    then
        clear
        echo "Version 14 was chosen!"
        echo "Downloading JDK 14..."
        wget https://bit.ly/3hVAAzE
        mv 3hVAAzE jdkpack.tar.gz
        installJDK
    else
        if [ $jdkVersion == 15 ]
        then
            clear
            echo "Version 15 was chosen!"
            echo "Downloading JDK 15..."
            wget https://bit.ly/3kEsq0b
            mv 3kEsq0b jdkpack.tar.gz
            installJDK
        else
            if [ $jdkVersion == 16 ]
            then
                clear
                echo "Version 16 was chosen!"
                echo "Version 16 is in beta, do you want to continue? Type yes or no"
                read resp
                if [ $resp == "yes" ]
                then
                    echo "Downloading JDK 16..."
                    wget https://bit.ly/3kJvPuz
                    mv 3kJvPuz jdkpack.tar.gz
                    installJDK
                else
                    chooseVersion
                fi
            else
                clear
                echo "Invalid version!"
                chooseVersion
            fi
        fi
    fi
}

#Go to version selection funcition
chooseVersion


