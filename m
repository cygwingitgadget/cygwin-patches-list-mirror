From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin/Makefile.in and cinstall/Makefile.in
Date: Mon, 25 Dec 2000 19:23:00 -0000
Message-id: <20001225222322.A7249@redhat.com>
References: <20001218204418.12970.qmail@web117.yahoomail.com>
X-SW-Source: 2000-q4/msg00058.html

On Mon, Dec 18, 2000 at 12:44:18PM -0800, Earnie Boyd wrote:
>Allows the use of -O3 or -finline-functions by disallowing them for
>cygwin/autoload.cc, cygwin/exceptions.cc and cinstall/autoload.c.

I've modified exceptions.cc and autoload.h to allow inlining without
special compile options.

I'll let DJ decide if the cinstall changes are desirable.

cgf
