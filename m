From: Chrisiasci@aol.com
To: <cygwin-patches@cygwin.com>
Subject: Re: 1.1.8: access violation in dlopen
Date: Wed, 14 Feb 2001 15:21:00 -0000
Message-id: <da.259b715.27bc6cc9@aol.com>
X-SW-Source: 2001-q1/msg00074.html

Sorry,

I thought I already attached it, but my b... mail did not agree...

Christophe

here it is :

Wed Feb 14 14:54:40 2001 Christophe Iasci <chrisiasci@aol.com>

    * dlfcn.cc (dlopen): Do not call LoadLibrary with a NULL pointer, when the library is not found

