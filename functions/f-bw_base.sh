function cut_equal() {
	if [ ! -z! -z  $( echo $1 | grep '=' ) ] ; then
		echo "== $1" 
		return=$(echo $1 | cut -d "=" -f 2)
	else 
		return=$2
	fi
	echo $return
	
}

function check_action {
	if [[ ! -z "$bw_action" ]] ; then
		bw_log "1" "Multiple actions specified - exiting"
		exit 1
	fi
}
