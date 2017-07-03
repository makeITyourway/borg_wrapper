#!/bin/bash


# Base Variables
version="v0.2"


#Loglevel for logfile (1 CRIT, 2 DEBUG, 3INFO)
bw_loglevel="1"


### binaries
borg_bin="/usr/bin/borg ${bw_additional_options}"





# source the functions
for file in ./functions/* ; do
    source $file
done
bw_log "3" "Borg wrapper starting"


# getting the args
while (( "$#" )); do
	# debug
#		echo "--> $1 ($2)"

	case $1 in
		### ACTIONS 
		-b|--backup|-c|--create)
			check_action
			bw_action="backup"
			bw_log "3" "selected action: $bw_action"
		;;
		-C|--check|-v|--verify)
			check_action
			bw_action="check"
			bw_log "3" "selected action: $bw_action"
			if [[ -z "$2" ]] ; then
				echo "Missing backup artefact - exiting"
				exit 1
			else
				bw_o_checkbck=$2
			fi				
			shift
			
		;;
		-i|--init)
			check_action
                        bw_action="init"
			bw_log "3" "selected action: $bw_action"
		;;
		-I|--info)
			check_action
			bw_action="info"
			bw_log "3" "selected action: $bw_action"
			if [[ -z "$2" ]] ; then
				echo "Missing backup artefact - exiting"
				exit 1
			else
				bw_o_infobck=$2
			fi				
			shift
		;;
		-l|--list)
			check_action
			bw_action="list"
			bw_log "3" "selected action: $bw_action"
		;;
		-P|--prune) 
			check_action
			bw_action="prune"
			bw_log "3" "selected action: $bw_action"
		;;
		-s|--shell)
			check_action
			bw_action="shell"
			bw_log "3" "selected action: $bw_action"
		;;
			
		### READ PROJECT
		-p)
			if [[ -z "$2" ]] ; then
				echo "Missing project name - exiting"
				exit 1
			else
				bw_o_project=$2
				if [[ -f "projects/${bw_o_project}.bw.sh" ]] ; then
					source projects/${bw_o_project}.bw.sh
				else 
					bw_log "1" "could not find projectfile projects/${bw_o_project}.bw.sh"
					exit 1
				fi
			fi
			shift
		;;

		### OPTIONS
		-d)
			bw_log "2" "Sent debugging flag on CLI"
			bw_o_debug="--debug"
			bw_loglevel="3"
		;;
		-h|--help)
			f-bw_help
			exit 0
		;;

	esac
	shift
done

bw_log "3" "successfully parsed the CLI - params"


# Variable check
if [ -z "$bw_o_project" ] ; then
	bw_log "1" "No BorgWrapper project sepcified - exiting"
	exit 1
fi
# Passphrase
if [ -z "$bw_password" ] ; then
	  bw_log "1" "No BorgWrapper Passphrase set in config - exiting"
          exit 1
else
	bw_log "3" "exporting BORG_PAASSPHRASE with password"
	export BORG_PASSPHRASE="$bw_password"
fi

if [[ -z "$bw_backupkeeptime" ]] ; then
	bw_log "1" "No Backup Keeptime set inf config - exiting"
	exit 1
fi	



case $bw_action in 
	list)
		bw_log "3" "running ACTION: $bw_action"
		f-bw_list
		bw_log "3" "finished ACTION: $bw_action"
	;;

	init)
		bw_log "3" "running ACTION: $bw_action"
		f-bw_init
		bw_log "3" "finished ACTION: $bw_action"
	;;

	backup)
		bw_log "3" "running ACTION: $bw_action"
		f-bw_backup
		bw_log "3" "finished ACTION: $bw_action"
	;;	
	info)
		bw_log "3" "running ACTION: $bw_action"
		f-bw_info $bw_o_infobck
		bw_log "3" "finished ACTION: $bw_action"
	;;
	check)
		bw_log "3" "running ACTION: $bw_action"
		f-bw_check $bw_o_checkbck
		bw_log "3" "finished ACTION: $bw_action"
	;;

	prune)
		bw_log "3" "running ACTION: $bw_action"
		f-bw_prune
		bw_log "3" "finished ACTION: $bw_action"
		
	;;
	shell)
		bw_log "3" "running ACTION: $bw_action"
		f-bw_shell
		bw_log "3" "finished ACTION: $bw_action"
		
			
esac

