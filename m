From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: the order of ACEs.
Date: Wed, 25 Apr 2001 17:14:00 -0000
Message-id: <s1spue0o6tx.fsf@jaist.ac.jp>
References: <s1sr8ygol8l.fsf@jaist.ac.jp> <20010425230939.K30677@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00164.html

>>> On Wed, 25 Apr 2001 23:09:39 +0200
>>> Corinna Vinschen <cygwin-patches@cygwin.com> said:

> > @@ -661,13 +665,7 @@ alloc_sd (uid_t uid, gid_t gid, const ch
> >  	      return NULL;
> >  	    }
> >  	  acl_len += ace->Header.AceSize;
> > -	  ++ace_off;
> 
> ...why does your patch drop the `++ace_off'? This seems to be
> a mistake.

I understood the `++ace_off' was only for appending `everyone'
ACE afterward. So I inferred it wasn't necessary anymore.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
