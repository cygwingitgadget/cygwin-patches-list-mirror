From: Earnie Boyd <earnie_boyd@yahoo.com>
To: Earnie Boyd <mingw-dvlpr@lists.sourceforge.net>
Cc: cygwin-patches@cygwin.com
Subject: [Fwd: mingw/include/stddef.h]
Date: Fri, 23 Feb 2001 07:07:00 -0000
Message-id: <3A967CBA.6ABF8725@yahoo.com>
X-SW-Source: 2001-q1/msg00111.html

Danny,

Can you answer Corinna's question?

Earnie.

-------- Original Message --------
From: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: mingw/include/stddef.h
To: cygpatch <cygwin-patches@cygwin.com>

Hi,

the current `stddef.h' file contains surprisingly the following:

...
#ifndef __WCHAR_TYPE__
#ifdef __BEOS__
#define __WCHAR_TYPE__ unsigned char
#else
#define __WCHAR_TYPE__ int
#endif
#endif
...

The surprise is the definition of __WCHAR_TYPE__ as `int' in case
of !BEOS.

Wouldn't it have more sense to define it as `unsigned short'???

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

