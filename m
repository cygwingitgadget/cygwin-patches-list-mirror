From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: cygpath: print windows/system directories
Date: Wed, 17 May 2000 10:51:00 -0000
Message-id: <20000517135151.J1995@cygnus.com>
References: <200005171727.NAA10177@envy.delorie.com>
X-SW-Source: 2000-q2/msg00060.html

On Wed, May 17, 2000 at 01:27:25PM -0400, DJ Delorie wrote:
>
>We can still work on other ways to deal with these directories, but I
>had this patch hanging around and it might be useful to someone.
>Objections?

Not from me.  Looks good.

cgf

>2000-05-17  DJ Delorie  <dj@cygnus.com>
>
>	* cygpath.cc: add --windir/--sysdir options
>	* utils.sgml: and document them
