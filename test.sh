#!/usr/bin/expect -f
set timeout 120
spawn ssh root@ops
expect "»"
send -- "exit\r"
sleep 5
expect eof

spawn ssh root@nyc
expect "»"
send -- "exit\r"
sleep 5
expect eof

spawn ssh root@bhs
expect "»"
send -- "exit\r"
sleep 5
expect eof

spawn ssh kga@backups
expect "»"
send -- "exit\r"
sleep 5
expect eof
