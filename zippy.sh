#!/bin/bash
# Tools by Andika Bintang
# grEtz : Tersakiti Crew - CianjurHacktivist.

lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'

if [ -z "${1}" ]; then
clear
printf "${lightgreen}
██████╗ ███████╗██╗   ██╗██╗██████╗ ███████╗
██╔══██╗╚══███╔╝╚██╗ ██╔╝██║██╔══██╗██╔════╝  ${yellow} bZyirs is a Bash Script to Bypass ZippyShare Download.${lightgreen}
██████╔╝  ███╔╝  ╚████╔╝ ██║██████╔╝███████╗   ${yellow}Made With <3 by Andika Bintang.${lightgreen}
██╔══██╗ ███╔╝    ╚██╔╝  ██║██╔══██╗╚════██║
██████╔╝███████╗   ██║   ██║██║  ██║███████║   ${yellow}Github : itsmebinyourbae${lightgreen}
╚═════╝ ╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝
                                            \n
${white}usage: ./${0} https://www1337.zippyshare.com/xxx
"
    exit
fi
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

function bZyirs() {
  clear
  printf "${lightgreen}
██████╗ ███████╗██╗   ██╗██╗██████╗ ███████╗
██╔══██╗╚══███╔╝╚██╗ ██╔╝██║██╔══██╗██╔════╝  ${yellow} bZyirs is a Bash Script to Bypass ZippyShare Download.${lightgreen}
██████╔╝  ███╔╝  ╚████╔╝ ██║██████╔╝███████╗   ${yellow}Made With <3 by Andika Bintang.${lightgreen}
██╔══██╗ ███╔╝    ╚██╔╝  ██║██╔══██╗╚════██║
██████╔╝███████╗   ██║   ██║██║  ██║███████║   ${yellow}Github : itsmebinyourbae${lightgreen}
╚═════╝ ╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝
                                            
"
  sleep 1
  printf "${yellow}URL : ${white}${url}\n\n"
    prefix="$(echo -n "${url}" | cut -c "11,12,31-38" | sed -e 's/[^a-zA-Z0-9]//g')"
    cookiefile="${prefix}-cookie.tmp"
    infofile="${prefix}-info.tmp"
    filename=""
    retry=0
    while [ -z "${filename}" -a ${retry} -lt 10 ]; do
        let retry+=1
        rm -f "${cookiefile}" 2>/dev/null
        rm -f "${infofile}" 2>/dev/null
        curl -s -c "${cookiefile}" -o "${infofile}" -L "${url}"
        filename="$(cat "${infofile}" | grep "/d/" | cut -d'/' -f5 | cut -d'"' -f1 | grep -o "[^ ]\+\(\+[^ ]\+\)*")"
    done
    if [ -f "${cookiefile}" ]; then
        jsessionid="$(cat "${cookiefile}" | grep "JSESSIONID" | cut -f7)"
    else
        echo "${red} Tidak dapat menemukan Cookies pada ${prefix}"
        exit 1
    fi
    if [ -f "${infofile}" ]; then
        # Get url algorithm
        dlbutton="$(grep -oE 'var a = [0-9]+' ${infofile} | grep -oE '[0-9]+')"
        if [ -n "${dlbutton}" ]; then
            algorithm="${dlbutton}/3+${dlbutton}"
            a="$(echo $((${algorithm})))"
        else
            dlbutton="$(grep 'getElementById..dlbutton...href' "${infofile}" | grep -oE '\([0-9].*\)')"
            if [ -n "${dlbutton}" ]; then
                algorithm="${dlbutton}"
                a="$(echo $((${algorithm})))"
            else
                echo "${red} Algoritma tidak ditemukan!"
                exit 1
            fi
        fi
        ref="$(cat "${infofile}" | grep 'property="og:url"' | cut -d'"' -f4 | grep -o "[^ ]\+\(\+[^ ]\+\)*")"
        server="$(echo "${ref}" | cut -d'/' -f3)"
        id="$(echo "${ref}" | cut -d'/' -f5)"
    else
        echo "${red}Tidak dapat menemukan Info File pada ${prefix}"
        exit 1
    fi
    dl="https://${server}/d/${id}/${a}/${filename}"
    if [ -n "${outputName}" ]; then
        filename="${outputName}"
    fi

    x=${dl}
    y=$(urldecode $x)
    printf "${lightgreen}BYPASSED : ${white}\n$y\n\nBjirr kwoakwoakws"
    rm -f "${cookiefile}" 2>/dev/null
    rm -f "${infofile}" 2>/dev/null
}

if [ -f "${1}" ]; then
    for url in $(cat "${1}" | grep -i 'zippyshare.com'); do
        bZyirs "${url}"
    done
else
    url="${1}"
    outputName="${2}"
    bZyirs "${url}" "${outputName}"
fi