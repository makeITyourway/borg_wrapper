#!/bin/bash

function f-bw_cron {
	f-bw_repostate
	
	# wrap exludedirs for backup
	for t_excludedir in ${bw_backupexclude} ; do
	        t_bw_excludedirs="--exclude ${t_excludedir} ${t_bw_excludedirs}"
	done

	bw_log "2" "Starting ${bw_action}"

		#running PRE Task
	f-bw_exectask "PRE BACKUP TASK" "${bw_prebackuptask}" 

		# backing up
	bw_log "3" "Triggering Backup within ${bw_action}"
	${borg_bin} create -v --stats ${bw_repository}::${bw_backupnowname} ${bw_backupdirs} ${t_bw_excludedirs}
	f-bw_catcherror $?

		# Verify the backup
	bw_log "3" "Triggering Check / Verification within ${bw_action}"
	${borg_bin} check -v ${bw_repository}::"${bw_backupnowname}" -v
	f-bw_catcherror $?

		#running PRE Task
	f-bw_exectask "POST BACKUP TASK" "${bw_postbackuptask}"

#catcherror
	bw_log "2" "Finished ${bw_action}"

	return 0	
}
