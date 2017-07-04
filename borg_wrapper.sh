#!/bin/bash


# Base Variables
version="v0.3"

# READ DIR 
t_dir=$(dirname $0)

# source the functions
for file in ${t_dir}/functions/* ; do
    source ${file}
done

#Loglevel for logfile (1 CRIT, 2 DEBUG, 3INFO)
bw_loglevel="1"


### binaries
borg_bin="/usr/bin/borg"
f-bw_checkborginstallation
borg_bin="${borg_bin} ${bw_additional_options}"




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
			bw_log "3" "selected action: ${bw_action}"
		;;
		-C|--check|-v|--verify)
			check_action
			bw_action="check"
			bw_log "3" "selected action: ${bw_action}"
			if [[ -z "$2" ]] ; then
				bw_log "0" "Missing backup artefact - exiting"
				exit 1
			else
				f-bw_checkartefactoption "$2"
				bw_o_checkbck=$2
			fi				
			shift
			
		;;
		--cron)
			check_action
                        bw_action="cron"
			bw_log "3" "selected action: ${bw_action}"
			
		;;
		-i|--init)
			check_action
                        bw_action="init"
			bw_log "3" "selected action: ${bw_action}"
		;;
		-I|--info)
			check_action
			bw_action="info"
			bw_log "3" "selected action: ${bw_action}"
			if [[ -z "$2" ]] ; then
				bw_log "1" "Missing backup artefact - exiting"
				exit 1
			else
				f-bw_checkartefactoption "$2"
				bw_o_infobck=$2
			fi				
			shift
		;;
		-l|--list)
			check_action
			bw_action="list"
			bw_log "3" "selected action: ${bw_action}"
		;;
		-m|--mount)
			check_action
			bw_action="mount"
			bw_log "3" "selected action: ${bw_action}"
			if [[ -z "$2" ]] ; then
				bw_log"1" "Missing backup artefact - exiting"
				exit 1
			else
				f-bw_checkartefactoption "$2"
				bw_o_mountbck=$2
			fi			
			if [[ -z "$3" ]] ; then
				bw_log"1" "Missing backup artefact - exiting"
				exit 1
			else
				f-bw_checkdiroption "$3"
				bw_o_mountdir=$3
			fi				
			shift
			shift
			
		;;
		-P|--prune) 
			check_action
			bw_action="prune"
			bw_log "3" "selected action: ${bw_action}"
		;;
		-s|--shell)
			check_action
			bw_action="shell"
			bw_log "3" "selected action: ${bw_action}"
		;;
			
		### READ PROJECT
		-p|--project)
			if [[ -z "$2" ]] ; then
				bw_log"1" "Missing project name - exiting"
				exit 1
			elif [[ "$2" == "all" ]] ; then
				bw_log "3" "you hit a special keyword !! - congrats - running through all projects (excluding smaple)"
				for t_project in ${t_dir}/projects/* ; do
    					if [[ -z $(echo ${t_project} | grep "sample.bw.sh") ]] ; then
						# source ${t_project}
						echo $t_project
						#$0 --project ${t_project} --"${bw_action}"
					fi
					
				done
			else
				bw_o_project=$2
				if [[ -f "${t_dir}/projects/${bw_o_project}.bw.sh" ]] ; then
					source ${t_dir}/projects/${bw_o_project}.bw.sh
				elif [[ -f ${bw_o_project} ]] ; then
					source ${bw_o_project}
				else 
					bw_log "1" "could not find projectfile ${bw_o_project} - exiting"
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




# PRoject  Variable check
f-bw_checkprojectconfig
	bw_log "3" "exporting BORG_PAASSPHRASE with password"
	export BORG_PASSPHRASE="${bw_password}"


#### Run triggered Actions 
case ${bw_action} in 
	backup)
		bw_log "3" "running ACTION: ${bw_action}"
		f-bw_backup
		bw_log "3" "finished ACTION: ${bw_actio}n"
	;;	
	check)
		bw_log "3" "running ACTION: ${bw_action}"
		f-bw_check ${bw_o_checkbck}
		bw_log "3" "finished ACTION: ${bw_action}"
	;;
	cron)
		bw_log "3" "running ACTION: ${bw_action}"
		f-bw_cron ${bw_o_checkbck}
		bw_log "3" "finished ACTION: ${bw_action}"
	;;
	init)
		bw_log "3" "running ACTION: ${bw_action}"
		f-bw_init
		bw_log "3" "finished ACTION: ${bw_action}"
	;;
	info)
		bw_log "3" "running ACTION: ${bw_action}"
		f-bw_info ${bw_o_infobck}
		bw_log "3" "finished ACTION: ${bw_action}"
	;;
	list)
		bw_log "3" "running ACTION: ${bw_action}"
		f-bw_list
		bw_log "3" "finished ACTION: ${bw_action}"
	;;
	mount)
		bw_log "3" "running ACTION: ${bw_action}"
		f-bw_mount ${bw_o_mountbck} ${bw_o_mountdir}
		bw_log "3" "finished ACTION: ${bw_action}"
	;;
	prune)
		bw_log "3" "running ACTION: ${bw_action}"
		f-bw_prune
		bw_log "3" "finished ACTION: ${bw_action}"
		
	;;
	shell)
		bw_log "3" "running ACTION: ${bw_action}"
		f-bw_shell
		bw_log "3" "finished ACTION: ${bw_action}"
	;;		
			
esac
	bw_log "3" "Exiting BORG-WRAOOER - thanks for using me ;)"
exit 0
