#!/bin/bash

function f-bw_list {
	f-bw_repostate

	bw_log "2" "Starting ${bw_action}"
	${borg_bin} list ${bw_additional_options} ${bw_repository}
	f-bw_catcherror $?
	bw_log "2" "Finished ${bw_action}"
}
