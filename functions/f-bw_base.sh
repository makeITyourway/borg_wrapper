# currently unused - --action=param is not working 
function cut_equal() {
	if [ ! -z! -z  $( echo $1 | grep '=' ) ] ; then
		echo "== $1" 
		return=$(echo $1 | cut -d "=" -f 2)
	else 
		return=$2
	fi
	echo $return
	
}

# check if there are multiple action params (block this !)
function check_action {
	if [[ ! -z "${bw_action}" ]] ; then
		bw_log "1" "Multiple actions specified - exiting"
		exit 1
	fi
}

# Check if repository is created and available
function f-bw_repostate {
	bw_log "3" "${bw_action} - Checking if repo exists"
        if [[ ! -d "${bw_repository}" ]] ; then
                bw_log "1" "${bw_action} - You need to initialize (init -i)  a repo first - try $0 -i"
                exit 1
        fi
}

# check if borg backup is installed - verify binaries
function f-bw_checkborginstallation {
	bw_log "3" "${bw_action} - Checking if borg is installed"
	if [[ ! -f ${borg_bin} ]] ; then 
		bw_log "1" "Borg is not installed correctly (if it is installed check \$borg_bin var in wrapper-borg.sh - exiting"
		exit 1
	fi
}

# verify given backup artefacts against configuration
function f-bw_checkartefactoption {
	#$1 artefactname
	t_return=$(echo $1 | grep "^${bw_backupprefix}")
	if [[ -z "${t_return}" ]] ; then
		bw_log "1" "Given artefact name does not match the project configuration with \$bw_backupprefix = $bw_backupprefix - exiting"
		exit 1
	else
		return 0
	fi
}

#verify given directory 
function f-bw_checkdiroption {
	if [[ ! -d "$1" ]] ; then 
		w_log "1" "Given directory is not a valid directory to mount ($1) - exiting"
		exit 1
	else
		return 0
	fi
}


# check RETURN CODE of actions done
function f-bw_catcherror {
	if [[ $1 -ne "0" ]] ; then
		bw_log "1" "Command operation ${bw_action} failed with RETURN CODE $1. Please see output above for more Information - exiting"
		exit $1
	fi
}

#helper fpr f-bw_checkprojectconfig
function f-bw_checkconfigvalue {
	#$1 value
	#$2 configname
	#$3 exit (yes / no)
	if [[ -z "$1" ]] ; then
		if [[ "$3" -eq "1" ]] ; then
			bw_log "1" "Project Config Value $2 is unset - exiting"
			exit 1
		fi
		
	fi

}
#Check and validate the config values inside the project config (1=break, 0=run ahead)
function f-bw_checkprojectconfig {
	f-bw_checkconfigvalue "${bw_project}" "\$bw_project" "1"
	f-bw_checkconfigvalue "${bw_repository}" "\$bw_repository" "1"
	# TEST what happens without password
	f-bw_checkconfigvalue "${bw_password}" "\$bw_password" "0"
	f-bw_checkconfigvalue "${bw_backupdirs}" "\$bw_backupdirs" "1"
	#do not fail 
	f-bw_checkconfigvalue "${bw_backupexclude}" "\$bw_backupexclude" "0"
	f-bw_checkconfigvalue "${bw_compression}" "\$bw_backupexclude" "0"
	f-bw_checkconfigvalue "${bw_backupkeeptime}" "\$bw_backupkeeptime" "1"
	f-bw_checkconfigvalue "${bw_backupprefix}" "\$bw_backupprefix" "1"
	f-bw_checkconfigvalue "${bw_backupsuffix}" "\$bw_backupsuffix" "1"
	f-bw_checkconfigvalue "${bw_prebackuptask}" "\$bw_prebackuptask" "0"
	f-bw_checkconfigvalue "${bw_postbackuptask}" "\$bw_postbackuptask" "0"
		
}

function f-bw_exectask {
		#$1 - Desription (PRE POST)
		#$2 = Task
	if [[ ! -z "$2" ]] ; then
		bw_log "2" "Running ${1}"
		bw_log "2" "${2}: ${2}"

		t_return=$(${2})

		f-bw_catcherror $?
		bw_log "3" "${t_return}"
	else
		bw_log "3" "NO ${1} defined - skipping"
	fi
}
