From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Tue, 27 Nov 2001 10:58:00 -0000
Message-ID: <000701c17775$6a1fea40$2101a8c0@d8rc020b>
References: <20011127184223.GA24028@redhat.com>
X-SW-Source: 2001-q4/msg00258.html
Message-ID: <20011127105800.yHp-mwmSD2v9dATos2HyAxFjIhwQ-emkXuwf-GVDxC8@z>

> >Ah, better yet.  Jeez you guys are clever ;-).  But how
> about we make it:
> >
> >	while (((l = s->gets ()) != 0) && (*l != '\0'))
> >
> >in the interest of making it a bit more self-documenting?
>
> Actually, how about not using != 0.  Use NULL in this context.
>

Also better yet.

> I don't think that *l is hard to understand, fwiw.
>

Right, it isn't.  I did need to do a double-take though at this ungodly hour
of the afternoon, whereas the '\0' would have reduced that to a single-take
;-).

--
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337
