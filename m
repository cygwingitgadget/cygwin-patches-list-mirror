From: Christopher Faylor <cgf@redhat.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: generating /etc/passwd and /etc/group for domians with users with cyrillic names
Date: Tue, 10 Apr 2001 19:33:00 -0000
Message-id: <20010410223404.A24731@redhat.com>
References: <130292291322.20010409223921@logos-m.ru> <20010410184619.Y956@cygbert.vinschen.de> <s1s66gcqmks.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00028.html

On Wed, Apr 11, 2001 at 09:58:27AM +0900, Kazuhiro Fujieda wrote:
> Corinna Vinschen <cygwin-patches@cygwin.com> said:
>> Why is that needed? What is the problem with the original functions?
>
>The `wcstombs' included in newlib simply strips the higher byte
>of Unicode. It can't translate Cyrillic, Greek, Turkish, and so on
>from Unicode to their ANSI codepages. WideCharToMultiByte can do
>these translations well.

Would it make sense to augment newlib to do the right thing, then?

cgf
