#!/bin/sh
# $Id$
# Author:
#   Matthias Schwarzott <zzam@gmx.de>
#
# This is a multiplexer for all things vdr can call with vdr -r script (e.g. noad ...)
# It calls all shell-scripts located in /usr/share/vdr/record in alphabetical order



#fork to background
if [ -z "${EXECUTED_BY_VDR_BG}" ]; then
	exec /usr/share/vdr/bin/vdr-bg.sh "${0}" "${@}"
	exit
fi

SVDRPCMD=/usr/bin/svdrpsend

HOOKDIR=/usr/share/vdr/record
OLD_HOOKDIR=/usr/lib/vdr/record

. /usr/share/vdr/inc/functions.sh

mesg() {
	${SVDRPCMD} MESG "\"$@\""
}

VDR_RECORD_STATE="$1"
VDR_RECORD_NAME="$2"
VDR_RECORD_NEW_NAME="$3"

for HOOK in ${HOOKDIR}/record-*.sh ${OLD_HOOKDIR}/record-*.sh; do
	[ -f "${HOOK}" ] && . "${HOOK}" "$@"
done
