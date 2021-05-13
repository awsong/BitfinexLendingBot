#!/bin/bash

d=`gdate -d '1/2 hour ago' '+%s'`

export nr=`grep ,2 bit.txt |grep -v ']]]'|cut -d ',' -f 4,5,6|awk -v var=$d -F'[ =]' '$1 > var' | cut -d ',' -f 3|sort|tail -1`

jq '.[0].strategy.MarginBot.MinDailyLendRate = env.nr' default.conf | sponge default.conf
