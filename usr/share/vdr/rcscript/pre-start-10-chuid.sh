# $Id$
addon_main() {
	yesno "${START_VDR_AS_ROOT}" && return 0

	if [ -n "${CAP_CHUID}" ] && ! yesno "${FORCE_SETUID_OFF}"; then
		add_param "-u" "vdr"
	else
		add_daemonctrl_param --chuid vdr
	fi
	return 0
}

