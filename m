From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: generating /etc/passwd and /etc/group for domians with users with cyrillic names
Date: Tue, 10 Apr 2001 17:58:00 -0000
Message-id: <s1s66gcqmks.fsf@jaist.ac.jp>
References: <130292291322.20010409223921@logos-m.ru> <20010410184619.Y956@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00027.html

>>> On Tue, 10 Apr 2001 18:46:19 +0200
>>> Corinna Vinschen <cygwin-patches@cygwin.com> said:

> Hi Egor,

Can I answer your question on behalf of him?

> I'm somewhat surprised about that patch and pretty curious.
> I had a look into the patch and basically it changes two
> things:
> 
> - calling WideCharToMultiByte instead of wcstombs
> - drops using wcslen.
> 
> Why is that needed? What is the problem with the original functions?

The `wcstombs' included in newlib simply strips the higher byte
of Unicode. It can't translate Cyrillic, Greek, Turkish, and so on
from Unicode to their ANSI codepages. WideCharToMultiByte can do
these translations well.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
