From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: the order of ACEs.
Date: Thu, 26 Apr 2001 02:22:00 -0000
Message-id: <20010426112235.F3827@cygbert.vinschen.de>
References: <s1sr8ygol8l.fsf@jaist.ac.jp> <20010425230939.K30677@cygbert.vinschen.de> <s1spue0o6tx.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00166.html

On Thu, Apr 26, 2001 at 09:14:34AM +0900, Kazuhiro Fujieda wrote:
> >>> On Wed, 25 Apr 2001 23:09:39 +0200
> >>> Corinna Vinschen <cygwin-patches@cygwin.com> said:
> 
> > > @@ -661,13 +665,7 @@ alloc_sd (uid_t uid, gid_t gid, const ch
> > >  	      return NULL;
> > >  	    }
> > >  	  acl_len += ace->Header.AceSize;
> > > -	  ++ace_off;
> > 
> > ...why does your patch drop the `++ace_off'? This seems to be
> > a mistake.
> 
> I understood the `++ace_off' was only for appending `everyone'
> ACE afterward. So I inferred it wasn't necessary anymore.

Oops, you're right. I should read my own code again...

Thanks for the patch, it's applied.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
