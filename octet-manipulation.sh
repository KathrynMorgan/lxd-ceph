#!/bin/bash

ip_ADDR="172.11.0.100"
oct1=${ip_ADDR%%.*} && echo $$oct1
echo "IP is $ip_ADDR"
oct1=${ip_ADDR%%.*} && echo $$oct1
ip_ADDR=${ip_ADDR#*.*} && echo "1st run: $ip_ADDR"
oct2=${ip_ADDR%%.*} && echo $$oct2
ip_ADDR=${ip_ADDR#*.*} && echo "2nd run: $ip_ADDR"
oct3=${ip_ADDR%%.*} && echo $$oct3
ip_ADDR=${ip_ADDR#*.*} && echo "3rd run: $ip_ADDR"
oct4=${ip_ADDR%%.*} && echo $$oct4
