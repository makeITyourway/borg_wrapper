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
	${borg_bin} create ${bw_additional_options} --stats ${bw_repository}::${bw_backupnowname} ${bw_backupdirs} ${t_bw_excludedirs}
	f-bw_catcherror $?

		# Verify the backup
	bw_log "3" "Triggering Check / Verification within ${bw_action}"
	${borg_bin} check ${bw_additional_options} ${bw_repository}::"${bw_backupnowname}" -v
	f-bw_catcherror $?

		# PRUNE old Backups
	bw_log "3" "Triggering PRUNE of old backups ${bw_action}"
	${borg_bin} prune ${bw_additional_options} ${bw_repository} --prefix ${bw_backupprefix} ${bw_backupkeeptime}
	f-bw_catcherror $?

		#running PRE Task
	f-bw_exectask "POST BACKUP TASK" "${bw_postbackuptask}"

#catcherror
	bw_log "2" "Finished ${bw_action}"

	bw_sendmail "2" "SUCCESS" "Successfully Finished ${bw_action} of ${bw_project}"

	return 0	
}
