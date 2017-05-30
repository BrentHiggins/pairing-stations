# pairing-stations
Pairing stations for mn dojo

## Intro
These scripts are used to setup a baseline environment for some generic pair-programing workstations.
There are a few larger workflows:
* adding the basic ssh keys for a user.
* installing various packages and configuring them.
* a TODO is to make an easy way to add more keys.

## Preparing the ansible driver machine
* Check out this source!
* Cd to the root directory.
* run ```'./mkenv.sh'```

Once this completes, you can activate the required environment from any shell by executing the following:
```source myenv_pairing```

## Base target machine and OS
This set of scripts expects to be run against the following basic box:
* Ubuntu 16.04 desktop install (TL2)
* The user from the install needs to be "pair"
* 'apt-get install openssh-server'

## First step for a new machine
* Edit the 'staging' file and put the machine name in the '[mn-key-these]' section. It should be
the only machine listed there.
* Execute: ```./doit-setup-ssh-access```   (use the password you chose for the 'pair' user when you did
the base OS install)

## 2nd step for a new machine
* Edit the 'staging' file and put the machine name in the '[mn-pairs]'section.
* Execute: ```./doit-setup-pairing```

Note: this step will also update all the other hosts listed in that mn-pairs area.

## Changing things
Once a machine has been bootstrapped like this, new or altered configuration and/or package-sets and so
on can be introduced into the playbook/roles. ```./doit-setup-pairing``` can then be executed to bring all the machines into sync. Note that some parts of the install overwrite configuration files. Generally speaking, there should _not_ be local changes, since people will be moving from pairing machine to pairing machine. I.E., if there is a setting that everyone wants to use, add it here and push to all of them!

## What the setup has in it:
* A single user named "pair". This is intentional to nudge us towards having simple and/or easily replicatable environments.
* A 2nd user named 'ansible' to do, well, ansible things!
* Some basic editors and tools such as vim, emacs, git, and ansible
* The chrome web browser
* The "Terminator" tool. This was pulled in from another dojo and appears to allow tabs in terminal windows.
* A basic 'go' environment
* Docker, vagrant, and virtualbox.
* The following editors: 'atom', and 'microsoft code studio' (along with vim & emacs)
* git-duet with mn specific configuration file
* The "bash-it" tool. Also pulled from the other dojo and give bash some extra spiffy abilities.
* A few mods to the desktop environment (turning off/down screen blankers and such)

## Todo items
* I tried pinning apps to the dock in the desktop-settings, but it didn't work. Currently commented out.
* Same with turning on a VNC server, though that may not be needed.
* The biggest thing: how to get to physical stacks

# Note-keeping place for windows/pairs
 * todo: make this into real readme above!

## Preping base OS
 * windows-64
 * update to "creator" (most recent feature)
 * renamed machine (kiwi-tree)
 * https://msdn.microsoft.com/en-us/commandline/wsl/install_guide
 * Follow windows prep directions here... http://docs.ansible.com/ansible/intro_windows.html#windows-system-prep
 * TURN OFF Hyper-V!!!!! Control Panel/Programs/Turn Windows features on-off/ uncheck Hyper-V


### todos
 * why is initial ssh not going up correcrtly
 *