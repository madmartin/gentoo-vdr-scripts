
include commands-functions

addon_main() {
	ebegin "  Checking config files"
	if [ ! -d "${vdr_user_home}" ]; then
		mkdir -p "${vdr_user_home}"/{shutdown-data,merged-config-files}
		chown vdr:vdr -R "${vdr_user_home}"
		ewarn "    created ${vdr_user_home}"
	fi
	merge_commands_conf /etc/vdr/commands /etc/vdr/commands.conf "${ORDER_COMMANDS}"
	merge_commands_conf /etc/vdr/reccmds /etc/vdr/reccmds.conf "${ORDER_RECCMDS}"

	if [ -f /etc/vdr/setup.conf ]; then
		if [ -n "${STARTUP_VOLUME}" ]; then
			/bin/sed -i /etc/vdr/setup.conf -e "s/^CurrentVolume =.*\$/CurrentVolume = ${STARTUP_VOLUME}/"
		fi

		if [ -n "${STARTUP_CHANNEL}" ]; then
			/bin/sed -i /etc/vdr/setup.conf -e "s/^CurrentChannel =.*\$/CurrentChannel = ${STARTUP_CHANNEL}/"
		fi
	fi

	eend 0
	if [ ! -e /etc/vdr/channels.conf ]; then
		ewarn "    /etc/vdr/channels.conf missing, creating empty file."
		touch /etc/vdr/channels.conf
		chown vdr:vdr /etc/vdr/channels.conf
	fi
	return 0
}
