## What is this ?
As a long time duplicity user (knowing all the ok's and nok's) I felt a little funny and tried something else.
BORG BACKUP ( https://borgbackup.readthedocs.io/en/stable/ )
It's a great tool offering more than duplicity has and I think it is even more performant than duply in the end.

As always, I was not 100% comfortable with the usage so I created this little wrapper ontop of the BORG BACKUP PROJECT.
The wrapper just simplifies my day to day work a lot and i'd love to share this little helper with you.
As mentioned, I only added the "everyday" handling into the wrapper to make life just a little bit easier, if you need special stuff like passphrase change or delete, refer to the `--shell` command (you will like it!).

Basically this is just a tool who triggers borg-backup commands in the end.

Since this is the very first version - please contribute or report bugs you find !
After all, I hope you like it !

[Of course you can donate, if you like what you see](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=info%40makeityourway%2ede&lc=DE&item_name=makeITyourway&item_number=borg%2dbackup&no_note=0&cn=Mitteilung%20an%20den%20H%c3%a4ndler%3a&no_shipping=2&currency_code=EUR&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted)

### What is borg backup
IF you don't know it, you might dont want this wrapper - but give it a try !!
Maybe one of the coolest backup tools around.
But I won't tell you what it is - read here: [Borg Backup Website](https://borgbackup.readthedocs.io/en/stable/)

## Usage
1) Install borgbackup for your OS. [Read this for more instructions](https://borgbackup.readthedocs.io/en/stable/installation.html)
2) Copy file `projects/sample.bw.sh` to `projects/<YourProjectName>.bw.sh` and modify it to your needs (read the comments wisely!)  
3) init the repository `borg-wrapper.sh -p <YourProjectName> --init`  
4) create a backup `borg-wrapper.sh -p <YourProjectName> --backup`  
5) check creation of backup `borg-wrapper.sh -p <YourProjectName> --list`  

If this worked, you can add a cronjob to your crontab:
`00 01 * * * /path/to/borg_wrapper/borg_wrapper.sh --project <YourProjectName> --cron`
This line wil trigger a backup and a check / verify of "YourProjectName" at 01:00 am.


## Features

### Adaption
`-p, --project [project name|/path/to/project.bw.sh]`  
specify project name either by name or path .
Reference created projects in /projects/ directory (see sample.bw.sh)  

### Actions
`-b,--backup`  
Trigger a backup of the project specified by --project

`-C, --check `<name of specific backup artefact>`  
Check the projects repository content  

`--cron`  
Trigger a complete Backup including verification and prune - best used from cron cmdline  

`-i, --init`  
Initialize the projects repository  

`-I, --info <name of specific backup artefact>`  
List infos of the backup artefact content  

`-l, --list`  
List the projects repository content  

`-m, --mount <name of specific backup artefact> <directory to mount the backup>`  
Mount an artefact to filesystem  

`-P, --prune`  
Prune/Wipe the last projects repository content  

`-s, --shell`  
Start a shell and source all BORG vars to it  

### Options
`-h, --help`  
Show this help  

`-d, --debug`  
Enable debugging  

## Structure
`borg-wrapper.sh`  
The Borg Wrapper script - try `./borg-wrapper.sh --help` for more information.  

`functions`  
The functions directory - containing all functions and tools required for the wrapper.  

`projects`  
The projects diretory - Copy `sample.bw.sh` to `myownproject.bw.sh` and modify the values to your needs.
Read the comments carefully !

`scripts`  
A set of scripts created to support, help and give you some hints what you can do - ENJOY!  

## Disclaimer
We (makeITyourway) nor any contributor are taking any guarantee for this script, your backups or anything else.
Neither we are taking responsability for loss of data, damage to your system or anything else ;). 
THIS IS NOT AN OFFICIAL BORG PROJECT - THIS IS DONE BY makeITyourway.
Please verify the functions yourself with the sample project, before you start deploying to production.
Feel free to fork (keep the creator name) or report bugs or anything to us.
Suggestions are welcome, too !!!

