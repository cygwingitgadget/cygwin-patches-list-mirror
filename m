From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Export rand48 functions.
Date: Mon, 19 Feb 2001 18:54:00 -0000
Message-id: <20010219215403.B23483@redhat.com>
References: <s1slmr8toe2.fsf@jaist.ac.jp>
X-SW-Source: 2001-q1/msg00088.html

On Thu, Feb 15, 2001 at 04:07:49PM +0900, Kazuhiro Fujieda wrote:
>The following patch enables rand48 functions provided by newlib.
>I've changed the way of initializing the reentrant structure so
>other members than _stdin, _stdout and _stderr are initialized
>to other than zero as well.
>
>ChangeLog:
>2001-02-15  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>
>	* cygwin.din: Export rand48 functions.
>	* thread.cc (MTinterface::Init): Remove the initialization of
>	`reent_data'.
>	* dcrt0.cc: Add the initalizer to the declaration of `reent_data'.
>	* include/cygwin/version.h: Bump CYGWIN_VERSION_API_MINOR to 35.

Applied.  Thanks.

cgf
