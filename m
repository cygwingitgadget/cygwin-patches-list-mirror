From: Egor Duda <deo@logos-m.ru>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: link(existing_file_1,existing_file_2) return 0 and actually doing the link
Date: Wed, 30 Aug 2000 23:02:00 -0000
Message-id: <45249158951.20000831100110@logos-m.ru>
References: <4585031418.20000829122541@logos-m.ru> <20000831000628.D1996@cygnus.com>
X-SW-Source: 2000-q3/msg00048.html

Hi!

Thursday, 31 August, 2000 Chris Faylor cgf@cygnus.com wrote:

>>  link(existing_file_1,existing_file_2) returns 0 and actually doing
>>  the link, but should not.

CF> Couldn't you achieve the same effect here by just testing that the value
CF> of real_b.get_win32.file_attributes () == (DWORD)-1 ?

i'm  checking  if it's possible to create new directory entry. imagine
we have writable-only directory c:\test and trying to

GetFileAttribute("c:\\test\\test.tst");

it  will  fail  even  if  c:\test\test.tst  doesn't  exist  and can be
created.  using  GetFileAttributes requires analysis of returned error
code,   and   i'm  not sure i can outline the set of error codes which
indicate we should still try to create link.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

