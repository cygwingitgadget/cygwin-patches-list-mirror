From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix dlclose()
Date: Sun, 03 Jun 2001 09:19:00 -0000
Message-id: <20010603121928.A29437@redhat.com>
References: <015901c0ebfd$8fb5e650$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00274.html

On Sun, Jun 03, 2001 at 05:19:42PM +1000, Robert Collins wrote:
>Sun Jun  3 17:17:00 2001  Robert Collins <rbtcollins@hotmail.com>
>
>    * dlfcn.cc (dlclose): If the symbol to close was obtained by
>dlopen(NULL,...)
>    do not call FreeLibrary.

Applied. Thanks.

cgf
