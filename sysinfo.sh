#!/bin/bash

# Usage info about the system
show_help()
{
echo "
        Usage: System information [-p] [-H] [-h] ] [command]

        -p Outputs plain ASCII text
        -H Shows help menu
	-h Shows help to commands

        For Example: ./sysinfo.sh -p -h pwd

"
}

options_found=0 # Variable to be used for initial HTML text

while getopts 'pHh:' OPTION; do # This will check the input for a given match (case)

  case $OPTION in 

	p)

		echo "System information"
		echo "Show time:"
		date #Shows date 
		uptime # Shows time, time user have been online and more

		echo 'Amount of memory avaliable:'
		free -m # Shows amount of free memory
		echo "a:"
		cat /proc/meminfo # Shows memory information

		echo "b:"
		vmstat -s # Also memory information of the system
		echo "Current user logged in:"

		whoami
		options_found=1

		;; # A way to tell getopts that the option requires an argument

	 H)
	 
		show_help
		options_found=1
		;;
	 h)
		echo "Information about the command: "
	        $OPTARG -- help # The argument will be used ass input to the help command 
		options_found=1
		;;

	 ?)
		echo "Invalid input"
		options_found=1
		;;
	esac

done

if ((!options_found)); then

show_time()
{
date
uptime
}

system_memory_info()
{
free -m
cat /proc/meminfo
vmstat -s
}

title="System information for"

    echo "<!DOCTYPE html>  <html>
            <head>
              <title>$title $HOSTNAME</title>
            </head>

            <body>
	     <h1> $title $HOSTNAME </h1>

             <h2>Show time</h2>
	     $(show_time)

             <h2>Memory information</h2>
             $(system_memory_info)

	   </body>
	 </html>"

fi

