From: DJ Delorie <dj@delorie.com>
To: matt@use.net
Cc: cygwin-patches@sources.redhat.com
Subject: Re: cinstall patches
Date: Tue, 26 Dec 2000 14:51:00 -0000
Message-id: <200012262250.RAA24592@envy.delorie.com>
References: <Pine.NEB.4.10.10012260335470.16114-400000@cesium.clock.org>
X-SW-Source: 2000-q4/msg00060.html

No default for these options can be determined in advance.  That's why
I didn't default them to anything.  The user *must* pick one.

> 	* winsup/cinstall/res.rc: Added accelerators and improved focus
> 	order. Removed WS_DISABLED from "OK" buttons to accomodate
> 	default focus changes in net.cc and source.cc.
> 
> 	* winsup/cinstall/net.cc (dialog_proc): If no radio button
> 	is selected, a default is selected.
> 
> 	* winsup/cinstall/source.cc (dialog_proc): Ditto.
> 
> 	(check_if_enable_next): Removed. No longer needed since
> 	a radio button will always be selected.
> 
> 	(load_dialog): Removed call to check_if_enable_next.
> 
> 	(dialog_cmd): Ditto. Also added default to switch.
