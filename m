From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: getrlimit, setrlimit
Date: Tue, 26 Dec 2000 16:21:00 -0000
Message-id: <20001227012115.A19021@cygbert.vinschen.de>
X-SW-Source: 2000-q4/msg00065.html

Hi,

I added a preliminary version of the functions `getrlimit' and
`setrlimit'.

`getrlimit' returns RLIM_INFINITY except for RLIMIT_CORE and RLIMIT_AS. 

RLIMIT_CORE returns the value of the new global variable `rlim_core'
which is RLIM_INFINITY by default. There's a functionality behind
that variable. If it's value is `0', no stackdump is produced as
on U*X systems no coredump is produced then.

RLIMIT_AS returns always 2GB.

`setrlimit' returns -1 and sets errno to EINVAL except for
RLIMIT_CORE which sets the global variable `rlim_core'.

The main reason for implementing these functions was to ease
porting of OpenSSH.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
