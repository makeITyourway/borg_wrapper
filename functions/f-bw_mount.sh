#!/bin/bash

function f-bw_mount {
	f-bw_repostate

	bw_log "2" "Starting ${bw_action}"
	${borg_bin} mount ${bw_repository}::"$1"  "$2"
	f-bw_catcherror $?
	bw_log "2" "Finished ${bw_action}"
	return 0	
}
