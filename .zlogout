if pgrep -x "ssh-agent" > /dev/null
then
`ssh-add -D` > /dev/null 2>&1
`ssh-agent -k` > /dev/null 2>&1
fi
