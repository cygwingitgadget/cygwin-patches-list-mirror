From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: 1.1.8: access violation in dlopen
Date: Wed, 14 Feb 2001 15:45:00 -0000
Message-id: <20010214184548.B25019@redhat.com>
References: <da.259b715.27bc6cc9@aol.com>
X-SW-Source: 2001-q1/msg00075.html

On Wed, Feb 14, 2001 at 06:20:40PM -0500, Chrisiasci@aol.com wrote:
>Sorry,
>
>I thought I already attached it, but my b... mail did not agree...
>
>Christophe
>
>here it is :
>
>Wed Feb 14 14:54:40 2001 Christophe Iasci <chrisiasci@aol.com>
>
>    * dlfcn.cc (dlopen): Do not call LoadLibrary with a NULL pointer, when the library is not found

I've installed this.  One minor observation, however: The formatting of
the code that you submitted did not match the surrounding code.  The
reference on the Contributing link points to the GNU coding standards.
If you do consider providing future patches (and I hope that you do)
please try to adhere to this standard.

Thanks,
cgf
