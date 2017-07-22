#!/bin/sh
# This, sadly, will overwrite things.
rsync -av --exclude=.bastion/.git --copy-links ~/.bastion $@:~/ && ssh $@ "~/.bastion/install.sh"
