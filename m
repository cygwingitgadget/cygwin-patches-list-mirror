From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: mingw/include/stddef.h
Date: Fri, 23 Feb 2001 06:59:00 -0000
Message-id: <20010223154619.P908@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00110.html

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
