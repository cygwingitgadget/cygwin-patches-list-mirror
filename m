From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: preliminary patch for incorporating internationalizing facilities
Date: Wed, 28 Jun 2000 14:51:00 -0000
Message-id: <s1sog4lo4ou.fsf@jaist.ac.jp>
References: <s1sr99ho8cf.fsf@jaist.ac.jp> <395A676F.F78E67A6@cygnus.com>
X-SW-Source: 2000-q2/msg00118.html

>>> On Wed, 28 Jun 2000 23:00:31 +0200
>>> Corinna Vinschen <vinschen@cygnus.com> said:

> >    /* The two paths were the same length, so just determine normal
> >       lexical sorted order. */
> > -  res = strcasecmp (ap->posix_path, bp->posix_path);
> > +  res = strcmp (ap->native_path, bp->native_path);
> 
> I don't understand that part. It seems to be a clear mistake that
> the posix paths are compared but why are you using `strcmp' now?
> What's about the case?

I believe this change causes no serious problem. It affects only
the case that there are two or more representations of the same
native path in the mount table.

strcasecmp is a locale-dependent function in ISO C. I don't want
to use it if it can be safely replaced with another function.  I
judged strcasecmp can be safely replaced with strcmp in this case.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
