From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Minor mkpasswd patch
Date: Fri, 14 Dec 2001 09:15:00 -0000
Message-ID: <20011214171608.GA24469@redhat.com>
References: <20011214121658.A2348@dothill.com>
X-SW-Source: 2001-q4/msg00315.html
Message-ID: <20011214091500.xsaoHdOD2z0cU6xCjW0PpFrj53uF2u3ElJpROMkeY4U@z>

On Fri, Dec 14, 2001 at 12:16:58PM -0500, Jason Tishler wrote:
>The attached fixes a SEGV caused by using the '-p' option:
>
>Fri Dec 14 12:10:39 2001  Jason Tishler <jason@tishler.net>
>
>	* mkpasswd.c (opts): Add indication that '-p' option requires an
>	argument.

Thanks.  Applied.

cgf
