From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: link(existing_file_1,existing_file_2) return 0 and actually doing the link
Date: Wed, 30 Aug 2000 21:07:00 -0000
Message-id: <20000831000628.D1996@cygnus.com>
References: <4585031418.20000829122541@logos-m.ru>
X-SW-Source: 2000-q3/msg00047.html

On Tue, Aug 29, 2000 at 12:25:41PM +0400, Egor Duda wrote:
>Hi!
>
>  link(existing_file_1,existing_file_2)  returns 0 and actually doing the
>link, but should not.

Couldn't you achieve the same effect here by just testing that the value
of real_b.get_win32.file_attributes () == (DWORD)-1 ?

cgf
