From: Matt <matt@use.net>
To: cygwin-patches@sources.redhat.com
Subject: cinstall patches
Date: Tue, 26 Dec 2000 03:59:00 -0000
Message-id: <Pine.NEB.4.10.10012260335470.16114-400000@cesium.clock.org>
X-SW-Source: 2000-q4/msg00059.html

The default selection is to Install from Internet with a Direct
Connection. Now, most users will just press enter to get through the
entire install. Yay! :)

When using Direct Connection, setup.exe leaks socket handles for each file
it gets (can be verified with HandleEx from sysinternals.com). I'll try
and track this down tomorrow if I get a chance.


Tue Dec 26 03:46:00 2000  Matt Hargett <matt@use.net>

	* winsup/cinstall/res.rc: Added accelerators and improved focus
	order. Removed WS_DISABLED from "OK" buttons to accomodate
	default focus changes in net.cc and source.cc.

	* winsup/cinstall/net.cc (dialog_proc): If no radio button
	is selected, a default is selected.

	* winsup/cinstall/source.cc (dialog_proc): Ditto.

	(check_if_enable_next): Removed. No longer needed since
	a radio button will always be selected.

	(load_dialog): Removed call to check_if_enable_next.

	(dialog_cmd): Ditto. Also added default to switch.
