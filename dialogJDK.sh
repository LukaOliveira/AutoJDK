#!/bin/bash

#Extract JDK to /opt and add to PATH
function installJDK (){
    dialog --title "AutoJDK" --infobox "Root access is required to extract files to / opt..." 3 60; sleep 3;
    clear
    (pv -n jdkpack.tar.gz | tar xvzf - -C /opt ) \
    2>&1 | dialog --gauge "Extracting OpenJDK to /opt..." 6 50
    clear
    echo "Adding JDK to PATH..."
    case $jdkversion in
    "1") echo "JDK 14"
        clear
        if ! echo -e 'export JAVA_HOME="/opt/jdk-14.0.2"\nexport PATH="$PATH:${JAVA_HOME}/bin"\n' | sudo tee /etc/profile.d/openjdk14.sh
        then
            echo "Failed to add to PATH"
            exit 1
        fi
            echo "OpenJDK-14 Installed successfully! Restart your computer to finish!"
            exit 1 ;;
    "2") echo "JDK 15"
        clear
        if ! echo -e 'export JAVA_HOME="/opt/jdk-15"\nexport PATH="$PATH:${JAVA_HOME}/bin"\n' | sudo tee /etc/profile.d/openjdk15.sh
        then
            echo "Failed to add to PATH"
            exit 1
        fi
            echo "OpenJDK-15 Installed successfully! Restart your computer to finish!"
            exit 1 ;;
    "3") echo "JDK 16"
        clear
        if ! echo -e 'export JAVA_HOME="/opt/jdk-16"\nexport PATH="$PATH:${JAVA_HOME}/bin"\n' | sudo tee /etc/profile.d/openjdk16.sh
        then
            echo "Failed to add to PATH"
            exit 1
        fi
            echo "OpenJDK-16 Installed successfully! Restart your computer to finish!"
            exit 1 ;;
    *) echo "Invalid
    "
    esac
}

#Chosse and download a version
function chosseVerion(){
    if [ $start == 0 ]
    then
        dialog --title "Wellcome to AutoJDK" --infobox "               AutoJDK by Luka Oliveira \n\n       Visit GitLab.com/Draiderz for more info \n     The the installation will start in 5 seconds" 6 60; sleep 5;
        start=1
    fi
    clear

    jdkversion=$(dialog --menu "Chosse a version" 10 35 5 1 "OpenJDK 14" 2 "OpenJDK 15" 3 "OpenJDK 16" --stdout)
    case $jdkversion in
    "1") echo "JDK 14"
            clear
            URL="https://bit.ly/3hVAAzE"
            wget "$URL" 2>&1 | \
            stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
            dialog --gauge "Downloading OpenJDK 14..." 10 100
            mv 3hVAAzE jdkpack.tar.gz
            installJDK ;;
    "2") echo "JDK 15"
            clear
            URL="https://bit.ly/3kEsq0b"
            wget "$URL" 2>&1 | \
            stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
            dialog --gauge "Downloading OpenJDK 15..." 10 100
            mv 3kEsq0b jdkpack.tar.gz
            installJDK ;;
    "3") echo "JDK 16"
            dialog --title "Attention!" --yesno "Version 16 is in beta, do you want to continue?" 5 60 --stdout
            case $? in
            "0")
                clear
                URL="https://bit.ly/3kJvPuz"
                wget "$URL" 2>&1 | \
                stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
                dialog --gauge "Downloading OpenJDK 16..." 10 100
                mv 3kJvPuz jdkpack.tar.gz
                installJDK ;;
            "1")
                chosseVerion;;
            *) exit 1
            esac
            ;;
    *) clear
        exit 1;;
    esac
}
start=0
chosseVerion