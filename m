From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Re: oem/ansi codepage support
Date: Fri, 01 Dec 2000 23:20:00 -0000
Message-id: <s1sd7fbcmsj.fsf@jaist.ac.jp>
References: <129109438394.20001129174705@logos-m.ru> <20001202000129.C4544@redhat.com>
X-SW-Source: 2000-q4/msg00034.html

>>> On Sat, 2 Dec 2000 00:01:29 -0500
>>> Christopher Faylor <cgf@redhat.com> said:

> The patch looks good but isn't there an LC_something environment
> variable that is equivalent to this on Linux.

LC_* environment variables aren't equivalent to this.
I recommend that we use the CYGWIN env variable.

On Linux, these variables control the behavior of C library
functions related to i18n: mbstowcs, strcoll, strftime, and so on.
They can't control behavior of kernel functions: the console
device and the file system. Egor's patch corresponds to the
latter on Cygwin.

The Cygwin DLL has C library functions and kernel functions, so
it may be good idea that these variables control both.  This,
however, is meaningful when C library functions are accommodated
to i18n.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
