From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: [PATCH]: uinfo.cc or "all commands start soooooow slow"
Date: Sat, 17 Jun 2000 05:38:00 -0000
Message-id: <394B7155.A330F4B9@vinschen.de>
X-SW-Source: 2000-q2/msg00105.html

Hi,


I have just checked in a patch which could eliminate the
"sooooooo slow on start up" messages in the mailing list.

To get full informations about the user, ntsec needs the name of
the logon domain and the logon server. To get that information,
the function `internal_getlogin' calls NetWkstaUserGetInfo() and
NetGetDCName(). If for some reason the machine has no connection
to it's PDC, this may take a while.

I have found that on NT/W2K systems that functions are called,
regardless of the ntsec setting. My patch fixes that.

Corinna
