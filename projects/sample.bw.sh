#!/bin/bash


#Specify your project name 
# Defines the name of the backup project
# DO NOT use SPACES
	#Exampl:E bw_project="SampleProject2017"
	bw_project="SampleProject2017"

#BORG Repository path / url 
# Defines, where the ackup will be storedi
	# Example: bw_repository="/tmp/borg_sample_repo" 
	# Example: bw_repository="user@hostname:/tmp/borg_sample_repo
	bw_repository="/tmp/borg_sample_repo"

#Repository password
# Defines the encryption passphrase for the backup in the repository
	# Example: bw_password="VerySecretPassword0"
	bw_password="VerySecretPassword0"


#Backup include pattern
# Defines a list of dirs that should be backupped seperated by space
	# Example: bw_backupdirs="/tmp/1/ /tmp/2/"
	bw_backupdirs="/tmp/1/ /tmp/2/"
	
#Backup exclude pattern
# Defines a list of dirs that should be excluded from backup separated by space
	# Example: bw_backupexclude="/tmp/*/logsi/ /tmp/*/session"
	bw_backupexclude="/tmp/*/logsi/ /tmp/*/session"

#Backup Compression settings
# Define the compression methid and strength for your backup projecti
# Possible (borg defined) optionS: 
# lz4 (fast repo, some compression), zlib,N (N=0-9 fast repo, more compression), lzma,N (N=0-9 slow repo, high compression)
# where 0 is always lowest compression and 9 is always highest compression
# bw_compression="" means no compression
	# Example:bw_compression="zlib,5" 
	bw_compression="zlib,5"


#Backup PRUNE config
# Defines the amount of time backups are kept in repository - 2 possibilitys to specify 
# read more about this here: https://borgbackup.readthedocs.io/en/stable/usage.html#borg-prune
# KEEP-WITHIN 1m = 31d, 2d 
# Uncomment this to use "keep Within Time"
	# Example: bw_backupkeeptime="--keep-within 1m"
	#bw_backupkeeptime="--keep-within 1m"
# KEEP-$TIME ( keep-hourly=N, keep-daily=N, keep-daily=N, keep-weekly=N, keep-monthly=N )
# Uncomment this to specify pattern for specific time ranges
	#Example: bw_backupkeeptime="--keep-daily=7 --keep-weekly=4 --keep-monthly=3"
	bw_backupkeeptime="--keep-daily=7 --keep-weekly=4 --keep-monthly=3"
	
#Backup PREFIX
# Defines the prefix type for the backup to store (only change if you know what you're doing)
# this represesnts the dynamic part of the backupname (eg. hostname & project)
	#Example: bw_backupprefix="$(hostname)-${bw_o_project}"
	bw_backupprefix="$(hostname)-${bw_o_project}-"

#Backup Suffix
# Defines the suffix type for backup to sore (only change if you know what you're doing)
# this represeents the dynamic part of the backupname (e.g. date)
	# Example: bw_backupsuffix="$(date +%Y%m%d-%H%M%S)"
	bw_backupsuffix="$(date +%Y%m%d-%H%M%S)"


#PRE BACKUP TASK for CRON
# You can define a task or a list of tasks here (BASH SYNTAX ! watch out for correct escape pattern)
# "" means that nothing will be done
# The command will be executed before a --cron will run
	# Example bw_prebackuptask="/usr/bin/sudo date"
	bw_prebackuptask=""

#POST BACKUP TASK for CRON
# You can define a task or a list of tasks here (BASH SYNTAX ! watch out for correct escape pattern) 
# "" means that nothing will be done
# The command will be executed after a successful --cron command
	# Example bw_postbackuptask="/usr/bin/sudo date"
	bw_postbackuptask=""


#ICINGA VALUES FOR WARN AND CRIT (can be set via option in CLI whcih will overrite those settings)
# You can define warning and critical values for when the --icinga option should represent the desired state
# Settings are in SECONDS (s) 
# use 86400 for a day, 90000 for 25 hours, 604800 for a week and so on ...
	#Example: bw_icingaoptions="WARN,CRIT"
	#Example: bw_icingaoptions="90000,604800"
	bw_icingaoptions="90000,608400"


#Additional cli options 
#feel free to specify additional options - be aware that this is used for all brog_commands
	# Example: bw_additional_options="--debug --warning"
	bw_additional_options="--info"



#Logfile for BorgWrapper
# Defines the  place where to keep the logfile - you can use projectname
	# Example: bw_logfile="./log/${bw_project}.log"
	bw_logfile="./log/${bw_project}.log"





#############################
#/!\ do not touch me here /!\
#############################

# Borg Binary location (should fit for most systens, modify if you are using the binary version or different location)
borg_bin="/usr/bin/borg"

# Borg generated Backupname - should not be touched - you do have config options above 
bw_backupnowname="${bw_backupprefix}${bw_backupsuffix}"






################################################
#/!\/!\ no shit - really don't touch this /!\/!\
################################################

# generate a log entry when project file was read successfully
bw_log "3" "Successfully sourced $bw_project "
