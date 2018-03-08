# MAIL Binary location (should fit for most systems, since we now use which :D)
mail_bin=$(which mail)

function bw_sub_mail() {
	my_subject=$1
	my_message=$2
	#using /bin/mail
	if [[ ! -z "${bw_mailrecipient}" ]] ; then
mail -s "${my_subject}" "${bw_mailrecipient}" <<EOF
${my_message}
EOF
	else
		bw_log "2" "No Mail recipient specified - not sending any mail"
	fi

}

# send mail
function bw_sendmail() {
	my_level="$1"
	my_keyword="$2"
	my_addinfo="$3"
	
	if [[ "${bw_action}" == "backup"  ]] || [[ "${bw_action}" == "cron"  ]] ; then
		if [[ "${bw_mailtrigger}" -le "0" ]] ; then
				# do nothing 
				break
		elif [[ "${my_level}" -le "${bw_mailtrigger}" ]] ;  then
				bw_log "3" "sending email"
				bw_sub_mail "BORG-Wrapper ${bw_project} ${my_keyword}" "${my_addinfo}"
				
				#bw_log "3" "sending success email"
				#bw_sub_mail "BORG-Wrapper(${w_project} - OK" "Backup of ${w_project} was successful\n\n${my_addinfo}"
		fi
	fi
}
