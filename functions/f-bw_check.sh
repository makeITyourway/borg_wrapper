#!/bin/bash

function f-bw_check {
	f-bw_repostate

	bw_log "2" "Starting ${bw_action}"
	${borg_bin} check ${bw_additional_options} ${bw_repository}::"$1"
	f-bw_catcherror $?
	bw_log "2" "Finished ${bw_action}"
	return 0	
}
