check_logins() {
	local NR=$(who | wc -l)
	if [[ "${NR}" -gt "0" ]]; then
		TRY_AGAIN=10
		TRY_AGAIN_MESSAGE="${NR} user(s) are logged in"
	fi
}

if [[ "${VDR_USERSHUTDOWN}" == "0" && "${VDR_CHECK_LOGINS:-yes}" == "yes" ]]; then
	check_logins
fi