From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: A few fixes to winsup/utils/cygpath.cc
Date: Wed, 26 Dec 2001 09:46:00 -0000
Message-ID: <20011226174623.GA21656@redhat.com>
References: <20011226130350.7718.qmail@lizard.curl.com> <20011226173530.GB21023@redhat.com> <20011226174012.23919.qmail@lizard.curl.com>
X-SW-Source: 2001-q4/msg00356.html
Message-ID: <20011226094600.P5o-oifC9DjWLnxI62q4JJn9GfC4_6SyeLPTTzHFt-Q@z>

On Wed, Dec 26, 2001 at 12:40:12PM -0500, Jonathan Kamens wrote:
>2001-12-26  Jonathan Kamens  <jik@curl.com>
>
>	* cygpath.cc (doit): Detect and warn about an empty path.  Detect
>	and warn about errors converting a path.
>	(main): Set prog_name correctly -- don't leave an extra slash or
>	backslash at the beginning of it.

Applied.  Thanks.

cgf
