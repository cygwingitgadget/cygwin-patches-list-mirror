From: Egor Duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Re: \033[xx;yy;zzm patch
Date: Fri, 16 Feb 2001 07:38:00 -0000
Message-id: <13286032277.20010216183727@logos-m.ru>
References: <1772701184.20010215002717@logos-m.ru> <20010214170018.A19427@redhat.com>
X-SW-Source: 2001-q1/msg00077.html

Hi!

Thursday, 15 February, 2001 Christopher Faylor cgf@redhat.com wrote:

>>2001-02-14  Egor Duda  <deo@logos-m.ru>
>> 
>>       * fhandler_console.cc (fhandler_console::char_command): Ignore unknown
>>       rendition codes in \033[xx;yym control sequences

CF> Applied.

CF> Actually, I should have just asked you to apply this yourself.  You have checkin
CF> rights, right?

right. perhaps, next time you can send "approval" message, similar to
those i've seen in binutils list, and i'd check the patch in?

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

