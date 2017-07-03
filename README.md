# borg_backup_wrapper

## What is this ?
I just felt very comfortable with duply and duplicity (since i wrote my own wrappers) but now i found BORG Backup which is really aweseome and offers some more cool features
So i just created my own wrapper script to make life with borg become more easier when administration bigger projects with multiple backups per host.
So this is what came out at the end.

Basically this is just a tool who triggers borg-backup commands in the end.
But it makes life easier  when you just have your project files and this wrapper will handle the rest for you.

Since this is the very first version - please contribute or report bugs you find !

## What is borg backup
IF you don't know it, you might dont want this wrapper - but give it a try !!
Maybe one of the coolest backup tools around.
But i won't tell you what it is - read here: [Borg Backup Website](https://borgbackup.readthedocs.io/en/stable/)

## Usage
1) Install borgbackup. [Read this for more instructions](https://borgbackup.readthedocs.io/en/stable/installation.html)
2) Copy file `projects/sample.bw.sh` to `projects/\<yourproject\>.bw.sh` and modify it to your needs (read the comments wisely!)
3) init the repository `borg-wrapper.sh -p \<yourproject\> --init`
4) create a backup `borg-wrapper.sh -p \<yourproject\> --backup`
5) check creation of backup `borg-wrapper.sh -p \<yourproject\> --list`

## Features

### Actions
`-b,--backup`
trigger a backup of the project

`-C, --check <name of specific backup artefact>`
Check the last projects repository content

`-i, --init` 
Initialize the projects repository

`-I, --info <name of specific backup artefact>`
List infos of the backup artefact content

`-l, --list`
List the projects repository content

`-P, --prune`
Prune/Wipe the last projects repository content

`-s, --shell`
Start a shell and source all BORG vars to it

### Options
`-h, --help`
show this help

`-d, --debug`
Enable debugging

## Disclaimer
We (makeITyourway) nor any contributor are taking any guarantee for this script, your backups or anything else.
Neither we are taking responsability for loss of data, damage to your system or anything else ;). 
THIS IS NOT AN OFFICIAL BORG PROJECT - THIS IS DONE BY makeITyourway.
Please verify the functions yourself with the sample project, before you start deploying to production.
Feel free to fork (keep the creator name) or report bugs or anything to us.
Suggestions are welcome, too !!!

## Changelog
v0.1 	first shot of this thingy - let's give it a try ...

## 2DOS
Those features might be in possible upcoming releases 
- treat return codes of borg
- implement CRON auto (backup & check/verify)
- implement ICING Check (yeah)
- maybe mailing ?
