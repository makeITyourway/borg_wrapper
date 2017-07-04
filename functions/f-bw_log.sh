function bw_log {
	#$1 loglevel
	#$2 logmessage
	case $1 in 
		1)
			t_bw_logtag="[C]"
		;;
		2)
			t_bw_logtag="[D]"
		;;
		3)
			t_bw_logtag="[I]"
		;;
		*)	
			t_bw_logtag="[-]"
		;;
	esac
	# check for logoutput
	if [[ $1 -le ${bw_loglevel} ]] ; then
		echo -e "${t_bw_logtag}\t$2"
	fi
	
}
