From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: generating /etc/passwd and /etc/group for domians with users with cyrillic names
Date: Wed, 11 Apr 2001 02:40:00 -0000
Message-id: <86432671428.20010411133903@logos-m.ru>
References: <130292291322.20010409223921@logos-m.ru> <20010410184619.Y956@cygbert.vinschen.de> <s1s66gcqmks.fsf@jaist.ac.jp> <20010410223404.A24731@redhat.com>
X-SW-Source: 2001-q2/msg00031.html

Hi!

Wednesday, 11 April, 2001 Christopher Faylor cgf@redhat.com wrote:

CF> On Wed, Apr 11, 2001 at 09:58:27AM +0900, Kazuhiro Fujieda wrote:
>> Corinna Vinschen <cygwin-patches@cygwin.com> said:
>>> Why is that needed? What is the problem with the original functions?
>>
>>The `wcstombs' included in newlib simply strips the higher byte
>>of Unicode. It can't translate Cyrillic, Greek, Turkish, and so on
>>from Unicode to their ANSI codepages. WideCharToMultiByte can do
>>these translations well.

CF> Would it make sense to augment newlib to do the right thing, then?

it's possible, but, as Kazuhiro's already said, such translation
should depend of current locale, so we can't use native functions --
they're using current win32 codepage which can be unrelated to unix
locale. so, i suppose, newlib will need to use some translation table
from /usr/share/locale/*  Alas, i don't feel i'm good enough in
unix-style i18n to volunteer for the job.

Using native i18n methods is a bit kludgy, but i think it's ok for
windows-specific utility. i've checked the patch in.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

