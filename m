From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygpatch <cygwin-patches@sources.redhat.com>
Subject: Re: preliminary patch3 for i18n: eliminate calls to wcstombs.
Date: Sat, 22 Jul 2000 06:25:00 -0000
Message-id: <s1saefa47t7.fsf@jaist.ac.jp>
References: <s1sn1jb45yi.fsf@jaist.ac.jp> <20000721155529.B26237@cygnus.com> <s1sk8ef422b.fsf@jaist.ac.jp> <39797348.194FB06F@cygnus.com>
X-SW-Source: 2000-q3/msg00027.html

>>> On Sat, 22 Jul 2000 12:11:20 +0200
>>> Corinna Vinschen <vinschen@cygnus.com> said:

> I will use local macros `sys_wcstombs' and `sys_mbstowcs' for
> that because the calls to WideCharToBlurb and MultiByte... are
> somewhat complex.

I agree with you.

> If there's a need to use WideChar... and MultiByte...
> functions more often later, it might help to define those macros in
> winsup.h.

_link() in syscalls.cc uses MultiByteToWideChar now.  So I
believe we already have a chance to define them in winsup.h.

> I don't understand the HOMEDRIVE/HOMEPATH part of your patch.
> It seems wrong to me.

Yes, it is wrong. I didn't inspect values of USER_INFO_3
structure well, and failed to catch the intention of your code.

> That's the reason for my way to create a full path first and after
> that extracting the HOMEPATH - containing only the path component -
> and HOMEDRIVE - containing only the drive letter and the trailing
> colon.

I see.

> I have attached my variation of the patch. If nobody objects,
> I will check that in at least Sunday morning (CEST).

There is nothing to object to.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
