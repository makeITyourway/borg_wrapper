#!/bin/bash

function f-bw_prune {
	f-bw_repostate
	bw_log "2" "Starting ${bw_action}"
	${borg_bin} prune ${bw_additional_options} ${bw_repository} --prefix ${bw_backupprefix} ${bw_backupkeeptime}
	f-bw_catcherror $?
	bw_log "2" "Finished ${bw_action}"
	return 0	
}
