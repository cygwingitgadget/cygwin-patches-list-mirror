From: edward <tailbert@yahoo.com>
To: cygwin-patches@cygwin.com
Cc: cygwin-developers@cygwin.com
Subject: Header patches for missing prototypes
Date: Mon, 08 Jan 2001 00:28:00 -0000
Message-id: <20010108082842.19436.qmail@web311.mail.yahoo.com>
X-SW-Source: 2001-q1/msg00015.html
Content-type: multipart/mixed; boundary="----------=_1583532845-65438-1"

This is a multi-part message in MIME format...

------------=_1583532845-65438-1
Content-length: 1675

Hello CygPeeps

I am not sure if these patches should be to cygwin or not, but here
they are.
The following functions are not defined in any of the header files.

newlib/libc/include/grp.h        : initgroups	<- yes it's a stub, but
it's nice to have the prototype
newlib/libc/include/stdio.h      : getw
newlib/libc/include/stdio.h      : putw
newlib/libc/include/string.h     : memccpy
newlib/libc/include/sys/signal.h : killpg
newlib/libc/include/sys/stat.h   : mknod		<- yes it's a stub, but it's
nice to have the prototype
newlib/libc/include/sys/unistd.h : getpgid
newlib/libc/include/sys/unistd.h : setpgrp
newlib/libc/include/sys/unistd.h : vhangup

winsup/cygwin/include/wchar.h    : wprintf

I have included two patches: newlib.patch and winsup.patch in a
compressed tar file.

run as follows:

cd /path/to/parent/of/newlib_and_winsup
gzip -cd newlib.patch | patch -p0
gzip -cd winsup.patch | patch -p0

Here are the ChangeLog's

newlib/ChangeLog:

Mon Jan  8 02:57:33 2001  Edward M. Lee  <tailbert@yahoo.com>

	* libc/include/grp.h: added prototype for initgroups
	* libc/include/stdio.h: added prototypes for getw, putw
	* libc/include/string.h: added prototype for memccpy
	* libc/include/sys/signal.h: added prototype for killpg
	* libc/include/sys/stat.h: enable mknod/lstat for CYGWIN
	* libc/include/sys/unistd.h: added prototypes for getpgid, setpgrp,
vhangup

winsup/cygwin/ChangeLog:

Mon Jan  8 03:00:31 2001  Edward M. Lee  <tailbert@yahoo.com>

	* include/wchar.h: added prototype for wprintf


__________________________________________________
Do You Yahoo!?
Yahoo! Photos - Share your holiday photos online!
http://photos.yahoo.com/
edward.tar.gz


------------=_1583532845-65438-1
Content-Type: application/x-gzip; charset=binary; name="edward.tar.gz"
Content-Disposition: inline; filename="edward.tar.gz"
Content-Transfer-Encoding: base64
Content-Length: 2302

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

------------=_1583532845-65438-1--
