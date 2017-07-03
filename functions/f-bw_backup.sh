#!/bin/bash

function f-bw_backup {
	bw_log "3" "$bw_action - Checking if repo exists"
        if [[ ! -d "$bw_repository" ]] ; then
		bw_log "1" "$bw_action - You need to initialize (init -i)  a repo first - try $0 -i"
		exit 1
	fi

	bw_backupexclude="/test /test2"
		for t_excludedir in $bw_backupexclude ; do
	        t_bw_excludedirs="--exclude $t_excludedir $t_bw_excludedirs"
	done

	bw_log "2" "Starting $bw_actiong"
	borg create -v --stats ${bw_repository}::${bw_backupnowname} -v --stats $bw_backupdirs $t_bw_excludedirs
#catcherror
	bw_log "2" "Finished $bw_actiong"

	return 0	
}
