#!/bin/bash

function f-bw_icinga {
	#$1 warning,critical
	t_warn_level=$(echo $1 | cut -d "," -f 1)
	t_crit_level=$(echo $1 | cut -d "," -f 2)

	if [[ "${t_crit_level}" -lt "${t_warn_level}" ]] ; then
		bw_log "1" "Icinga crit-level(${t_crit_level}) is smaller than warnlevel(${t_warn_level}) - exiting"
		exit 1
	fi
	f-bw_repostate

	bw_log "2" "Starting ${bw_action}"
	# get the latest backup time
	t_lastbck_time=$(${borg_bin} list ${bw_repository} | tail -n 1 | cut -d "," -f 2 | cut -b 2-)
	f-bw_catcherror $?

	# Catch failed or empty response
	if [[ -z ${t_lastbck_time} ]] ; then
		bw_log "1" "Did not receive a correct value"
		echo "Was not able to receive a value (mount error ?)" 
		f-bw_catcherror 3
		exit 3
	fi

	# calc to utime
	t_lastbck_utime=$(date -d "${t_lastbck_time}" +%s)
	# calc NOW to utime
	t_now_time=$(date +%s)
	# calc the difference
	t_diff=$(expr ${t_now_time} - ${t_lastbck_utime})
	bw_log "3" "Last Backup was: ${t_lastbck_time} (${t_diff} seconds ago)"
	

	#EXIT Handling
	if [[ "${t_diff}" -ge "${t_warn_level}" ]] && [[ ! "${t_diff}" -ge "${t_crit_level}" ]]; then
		echo "BACKUP WARNING, last borg_wrapper backup was ${t_diff} seconds ago"
		exit 1
	elif [[ "${t_diff}" -ge "${t_crit_level}" ]] && [[ ! "${t_diff}" -le "${t_warn_level}" ]]; then
		echo "BACKUP CRITICAL, last borg_wrapper backup was ${t_diff} seconds ago"
		exit 2
	elif [[ "${t_diff}" -lt "${t_warn_level}" ]] && [[ "${t_diff}" -le "${t_crit_level}" ]]; then
		echo "BACKUP OK, last borg_wrapper backup was ${t_diff} seconds ago"
		exit 0
	else
		echo "Unknown"
		exit 3
	fi	
	
		
	bw_log "2" "Finished ${bw_action}"
}
