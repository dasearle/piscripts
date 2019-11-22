#!/bin/bash
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))

gpuTemp0=$(/opt/vc/bin/vcgencmd measure_temp)
gpuTemp0=${gpuTemp0//\'/º}
gpuTemp0=${gpuTemp0//temp=/}

CPUID=$(awk '/Serial/ {print $3}' /proc/cpuinfo | sed 's/^0*//')

timestamp() {
  date +"%y-%m-%d %T"
}

# echo $(timestamp)
# echo CPU Temp: $cpuTemp1"."$cpuTempM"ºC"
# echo GPU Temp: $gpuTemp0

echo { >> temp_log
echo '"'NxtFlip ID'"' : '"'$CPUID'"' >> temp_log
echo '"'timestamp'"' : '"'$(timestamp)'"' >> temp_log 
echo '"'CPU Temp'"' : '"'$cpuTemp1"."$cpuTempM"ºC"'"' >> temp_log
echo '"'GPU Temp'"' : '"'$gpuTemp0'"' >> temp_log

if [ $cpuTemp1 -gt 50 ]
then
  python fanON.py
  echo '"'Fan Status'"' : '"'ON'"' >> temp_log
  sqlite3 templog.db "insert into TempLog (NxtFlip_ID, timestamp,CPU_Temp, GPU_Temp, Fan_Status) values (\"$CPUID\",\"$(timestamp)\",\"$cpuTemp1.$cpuTempMºC\",\"$gpuTemp0\",\"ON\");"
else
  python fanOFF.py
  echo '"'Fan Status'"' : '"'OFF'"' >> temp_log
  sqlite3 templog.db "insert into TempLog (NxtFlip_ID, timestamp,CPU_Temp, GPU_Temp, Fan_Status) values (\"$CPUID\",\"$(timestamp)\",\"$cpuTemp1.$cpuTempMºC\",\"$gpuTemp0\",\"OFF\");"

fi


echo } >> temp_log

