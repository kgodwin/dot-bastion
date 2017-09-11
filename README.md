### dot-bastion - opinionated dotfiles

* I wanted something short and simple that covered my usage. 
* I will only resolve issues with the most recent Ubuntu LTS release as its my personal setup. [16.04]

**System Config**

* This theme is unreadable on a white background. Use black.
* xterm-256color :: color mode required to display properly :: export TERM=xterm-256color 
* PT Mono from Google Fonts :: font used by me; possibly may want to make a patched one if you want more symbols [e.g. FontAwesome]

**Quick Install**

* git clone ??????? ~/.bastion
* ~/.bastion/install.sh

**Deployment Setup**

* ~/.bastion/deploy.sh [-p 42 kg@bastion]

**ZSH Setup**

* .zshrc :: .zshrc with a default theme, autocomplete, and git support (need to commit, need to push) :: ln -s /path/to/dot-bastion/.zshrc ~/.zshrc
* .zcustom :: .zcustom is where you'd store color changes, aliases, etc. :: touch ~/.zcustom

**VIM Setup**

* .vimrc :: .vimrc with [janah](https://github.com/mhinz/vim-janah) :: ln -s /path/to/dot-bastion/.vimrc ~/.vimrc
* .vim :: .vim to hold the [janah](https://github.com/mhinz/vim-janah) theme :: ln -s /path/to/dot-bastion/.vim ~/.vim

**Files not included that should be modified (probably):**

~/.gnupg/gpg.conf

```
personal-cipher-preferences AES256 TWOFISH AES192 AES
personal-digest-preferences SHA512 SHA384 SHA256
personal-compress-preferences ZLIB BZIP2 ZIP
```

The reason this isn't included is it isn't theme/preference related and really should be evaluated manually every time you setup a new gpg.conf.
