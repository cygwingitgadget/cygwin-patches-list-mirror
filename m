From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: Using either ntsec or ntea
Date: Wed, 15 Mar 2000 15:09:00 -0000
Message-id: <20000315180952.A25022@cygnus.com>
References: <38CFEC22.77DC61CC@vinschen.de>
X-SW-Source: 2000-q1/msg00002.html

On Wed, Mar 15, 2000 at 09:01:38PM +0100, Corinna Vinschen wrote:
>I have a patch that excludes the usage of ntea on ntfs if ntsec is set.
>This is my "answer" to your question for mutual exclusive usage of
>ntea and ntsec.
>
>Unfortunately I'm not sure that we should implement it. Maybe we
>could use the ntea feature for communication with samba. Iff samba
>supports usage of all information that is written by BackupWrite,
>information in ntea could be used for all attributes (S_IFLNK,
>S_IFBLK, S_IFCHR). Wouldn't that be nice? I'm not sure if this is
>possible (lack of insight in NetBIOS communication) but that
>could be answered by Jeremy at least.

Ok.  Let's wait until we hear from Jeremy.

cgf
