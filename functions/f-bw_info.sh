#!/bin/bash

function f-bw_info {
	f-bw_repostate

	bw_log "2" "Starting ${bw_action}"
	${borg_bin} info ${bw_repository}::"$1"
	f-bw_catcherror $?
#catcherror
	bw_log "2" "Finished ${bw_action}"

	return 0	
}
