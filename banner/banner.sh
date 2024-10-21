clear

GREEN='\033[1;32m'
RESET='\033[0m'

username="${GREEN}$(whoami)${RESET}@${GREEN}$(uname -n)${RESET}"
break_line="${GREEN}-----------------${RESET}"

os="${GREEN}OS:${RESET} Android $(getprop ro.build.version.release) $(uname -m)"
host="${GREEN}Host:${RESET} $(getprop ro.product.system_dlkm.marketname)"
kernel="${GREEN}Kernel:${RESET} $(uname -r | awk -F'-' '{print $1"-"$2}')"
uptime="${GREEN}Uptime:${RESET} $(uptime -p | sed 's/up //; s/ days*/d/; s/ hours*/h/; s/ minutes*/m/; s/,//g')"

private_ip="${GREEN}Local IP:${RESET} $(ifconfig 2>/dev/null | awk '/wlan0/{getline; print $2}')"

public_ip="${GREEN}Public IP:${RESET} $(dig +short myip.opendns.com @resolver1.opendns.com)"

memory="${GREEN}Memory:${RESET} $(df -h /data | awk 'NR==2 {print $3" / "$2}' | sed 's/G/GB/')"

total_ram_kb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
available_ram_kb=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
used_ram_kb=$((total_ram_kb - available_ram_kb))

total_ram_gb=$(echo "scale=2; $total_ram_kb / 1024 / 1024" | bc)
used_ram_gb=$(echo "scale=2; $used_ram_kb / 1024 / 1024" | bc)

ram="${GREEN}Ram:${RESET} ${used_ram_gb}GB / ${total_ram_gb}GB"

cpu_model=$(getprop ro.soc.model)
cpu_core=$(nproc)
cpu_speed=$(lscpu | grep 'max MHz' | awk '{if ($NF > max) max=$NF} END {print max/1000}')

cpu="${GREEN}CPU:${RESET} ${cpu_model} (${cpu_core}) @ ${cpu_speed}GHz"

awk -v username="$username" -v break_line="$break_line" -v os="$os" -v host="$host" -v kernel="$kernel" -v uptime="$uptime" -v private_ip="$private_ip" -v public_ip="$public_ip" -v cpu="$cpu" -v memory="$memory" -v ram="$ram" -v green="$GREEN" -v reset="$RESET" '
    NR==1 { print green $0 ; next }
    NR==2 { print green $0 ; next }
    NR==3 { print green $0 reset, username; next }
    NR==4 { print green $0 reset, break_line; next }
    NR==5 { print green $0 reset, os; next }
    NR==6 { print green $0 reset, host; next }
    NR==7 { print green $0 reset, kernel; next }
    NR==8 { print green $0 reset, uptime; next }
    NR==9 { print green $0 reset, private_ip; next }
    NR==10 { print green $0 reset, public_ip; next }
    NR==11 { print green $0 reset, cpu; next }
    NR==12 { print green $0 reset, memory; next }
    NR==13 { print green $0 reset, ram; next }
    NR==14 { print green $0 ; next }
    NR==25 { print green $0 ; next }
    1
' $HOME/.local/bin/home/banner.txt
