#!/bin/bash

d=`/bin/date -d '30 minutes ago' '+%s'`

export nr=`tail -20000 bit.txt |grep ,2 |grep -v ']]]'|cut -d ',' -f 4,5,6|/usr/bin/awk -v var=$d -F'[ =]' '$1 > var' | cut -d ',' -f 3|sort|tail -1`
export nr=0`echo $nr*100|/usr/bin/bc`

#/usr/local/bin/jq '.[0].strategy.MarginBot.MinDailyLendRate = env.nr' default.conf | /usr/local/bin/sponge default.conf
echo $nr
low_bound=0.01979
if [[ $nr < $low_bound ]] 
then  
    nr=$low_bound
fi
echo $nr
/bin/sed -i "s/\(\"MinDailyLendRate\":\).*/\1 $nr,/" default.conf
