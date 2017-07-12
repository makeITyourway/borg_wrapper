function f-bw_init {
	        #BORG INIT REPO (if not existent)
                bw_log "3" "${bw_action} - Checking if repo exists"
                if [[ ! -d "${bw_repository}" ]] ; then
			#create the repo
                        ${borg_bin} init ${bw_additional_options} ${bw_repository}
			f-bw_catcherror $?
                        bw_log "2" "${bw_action} - Repo ${bw_repository} initialized"
                        exit 0
                else
			#failure
                        bw_log "1" "${bw_action} - Repo ${bw_repository} already exists"
                        exit 1
                fi
}
