#!/bin/bash

function f-bw_backup {
	f-bw_repostate
	
	# wrap exludedirs for backup
	for t_excludedir in ${bw_backupexclude} ; do
	        t_bw_excludedirs="--exclude ${t_excludedir} ${t_bw_excludedirs}"
	done

	#check for compression
	if [[ ! -z "${bw_compression}" ]] ; then
		t_bw_compression="--compression ${bw_compression}"
	else
		t_bw_compression=""
	fi

	bw_log "2" "Starting ${bw_action}"
	${borg_bin} create --stats ${t_bw_compression} ${bw_repository}::${bw_backupnowname} ${bw_backupdirs} ${t_bw_excludedirs}
	f-bw_catcherror $?
#catcherror
	bw_log "2" "Finished ${bw_action}"

	return 0	
}
