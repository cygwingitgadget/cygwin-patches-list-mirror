From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: \033[xx;yy;zzm patch
Date: Wed, 14 Feb 2001 14:00:00 -0000
Message-id: <20010214170018.A19427@redhat.com>
References: <1772701184.20010215002717@logos-m.ru>
X-SW-Source: 2001-q1/msg00073.html

On Thu, Feb 15, 2001 at 12:27:17AM +0300, Egor Duda wrote:
>Hi!
>
>2001-02-14  Egor Duda  <deo@logos-m.ru>
> 
>	* fhandler_console.cc (fhandler_console::char_command): Ignore unknown
>	rendition codes in \033[xx;yym control sequences

Applied.

Actually, I should have just asked you to apply this yourself.  You have checkin
rights, right?

cgf
