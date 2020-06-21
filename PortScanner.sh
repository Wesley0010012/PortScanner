#!/bin/bash

if [ -z $1 ]
then
	echo "Create by Wesley001012"
	echo "Usage: ./PortScanner -i [IP] -p [Min][Max]"
	echo "Type -h for More Options"
else
	if [ $1 = "-h" ]
	then
		echo "Created by Wesley0010012"
		echo "Usage: ./PortScanner -i [IP] -p [Min][Max]"
		echo "-i: Use IP mode;"
		echo "-p: Port-Range Scan;"
		echo "-s: All Ports Scan;"
		echo "-t: One Port Scan;"
	else
		if [ $1 = "-i" ]
		then
			if [ -z $2 ]
			then
				echo "Ip not defined, sorry."
			else
				ip=$2
				sed -i "s|ip_target|$ip|g" bin/scanners/scan-p.c
				if [ -z $3 ]
				then
					echo "Attack Type not defined, sorry."
				else
					if [ $3 = "-p" ]
					then
						if [ -z $4 ]
						then
							echo "Min port Not Defined, sorry."
						else
							if [ -z $5 ]
							then
								echo "Max Port Not Defined, sorry."
							else
								port_start=$4
								port_end=$5
								sed -i "s|start = start_point;|start = $port_start;|g" bin/scanners/scan-p.c
								sed -i "s|end = end_point;|end = $port_end;|g" bin/scanners/scan-p.c
								cd bin/scanners
								gcc scan-p.c -o scan-p 2>/dev/null
								./scan-p
								rm scan-p
								cd ../../
								sed -i "s|$ip|ip_target|g" bin/scanners/scan-p.c
								sed -i "s|$port_start|start_point|g" bin/scanners/scan-p.c
								sed -i "s|$port_end|end_point|g" bin/scanners/scan-p.c
							fi
						fi
					else
						if [ $3 = "-s" ]
						then
							ip=$2
							sed -i "s|ip_target|$ip|g" bin/scanners/scan-s.c
							cd bin/scanners/
							gcc scan-s.c -o scan-s 2>/dev/null
							./scan-s
							rm scan-s
							cd ../../
							sed -i "s|$ip|ip_target|g" bin/scanners/scan-s.c
						else
							if [ $3 = "-t" ]
							then
								if [ -z $4 ]
								then
									echo "Port not Defined, sorry."
								else
									ip=$2
									port=$4
									sed -i "s|ip_target|$ip|g" bin/scanners/scan-t.c
									sed -i "s|target_port|$port|g" bin/scanners/scan-t.c
									cd bin/scanners/
									gcc scan-t.c -o scan-t 2>/dev/null 
									./scan-t
									rm scan-t
									cd ../../
									sed -i "s|$ip|ip_target|g" bin/scanners/scan-t.c
									sed -i "s|$port|target_port|g" bin/scanners/scan-t.c
								fi
							fi
						fi
					fi
				fi
			fi
		fi
	fi
fi
