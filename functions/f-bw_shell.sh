#!/bin/bash
function f-bw_shell {
	f-bw_repostate
	bw_log "2" "Starting ${bw_action}"
	export BORG_REPO="${bw_repository}"
	export BORG_PASSPHRASE="${bw_password}"
	export repo="${bw_repository}"
	
	echo -e "\n\n\n\n---------------------------------"
	echo -e "- Starting borg shell for project ${bw_o_project}-"
	echo -e "you can now use the \"borg\" command - all ENV VARS are set."
	bw_log "3" "Additional ENNV VARS are: \$repo (repository)"
	echo -e "exit with \"exit\" or CTTL+D"
	echo -e "---------------------------------\n"
	
	# calling bash
	/bin/bash --rcfile <(echo PS1="\[borg\]${bw_o_project}\# ")

	echo -e "---------------------------------"
	echo -e "- Exiting BORG Shell 4 project ${bw_o_project}-"
	echo -e "---------------------------------\n"
	
	bw_log "2" "Finished ${bw_action}"
}

