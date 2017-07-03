#!/bin/bash

function f-bw_check {
	bw_log "3" "$bw_action - Checking if repo exists"
        if [[ ! -d "$bw_repository" ]] ; then
		bw_log "1" "$bw_action - You need to initialize (init -i)  a repo first - try $0 -i"
		exit 1
	fi


	bw_log "2" "Starting $bw_action"
	borg check -v $bw_repository::"$1" -v
#catcherror
	bw_log "2" "Finished $bw_action"

	return 0	
}
