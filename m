From: Corinna Vinschen <vinschen@cygnus.com>
To: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
Cc: cygpatch <cygwin-patches@sources.redhat.com>
Subject: Re: preliminary patch3 for i18n: eliminate calls to wcstombs.
Date: Sat, 22 Jul 2000 08:23:00 -0000
Message-id: <3979BC54.B491BCFA@cygnus.com>
References: <s1sn1jb45yi.fsf@jaist.ac.jp> <20000721155529.B26237@cygnus.com> <s1sk8ef422b.fsf@jaist.ac.jp> <39797348.194FB06F@cygnus.com> <s1saefa47t7.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00028.html

Kazuhiro Fujieda wrote:
> > If there's a need to use WideChar... and MultiByte...
> > functions more often later, it might help to define those macros in
> > winsup.h.
> 
> _link() in syscalls.cc uses MultiByteToWideChar now.  So I
> believe we already have a chance to define them in winsup.h.

You're right. I have just moved the macros to winsup.h and
changed the call in _link() accordingly. I'll check that in
later today.

Corinna

-- 
Corinna Vinschen
Cygwin Developer
Cygnus Solutions, a Red Hat company
