From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Re: generating /etc/passwd and /etc/group for domians with users with cyrillic names
Date: Tue, 10 Apr 2001 23:37:00 -0000
Message-id: <s1s1yr0q6vv.fsf@jaist.ac.jp>
References: <130292291322.20010409223921@logos-m.ru> <20010410184619.Y956@cygbert.vinschen.de> <s1s66gcqmks.fsf@jaist.ac.jp> <20010410223404.A24731@redhat.com>
X-SW-Source: 2001-q2/msg00029.html

>>> On Tue, 10 Apr 2001 22:34:04 -0400
>>> Christopher Faylor <cgf@redhat.com> said:

> Would it make sense to augment newlib to do the right thing, then?

No, I'm afraid it wouldn't.

`wcstombs' must be sensitive to a locale selected by an
application according to the ISO C standard.
In this case, however, it must be sensitive to the system
default locale of Windows.

I believe we should use WideCharToMultiByte for i18n of such
Windows specific tools.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology


> 
> cgf
> 
