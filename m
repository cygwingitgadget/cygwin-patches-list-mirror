From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: [PATCH]: Check modification time on /etc/passwd and /etc/group
Date: Fri, 03 Aug 2001 06:15:00 -0000
Message-id: <20010803151518.Y23782@cygbert.vinschen.de>
References: <20010731203820.U490@cygbert.vinschen.de> <20010803144012.X23782@cygbert.vinschen.de> <996843821.24208.3.camel@lifelesswks>
X-SW-Source: 2001-q3/msg00045.html

On Fri, Aug 03, 2001 at 11:03:46PM +1000, Robert Collins wrote:
> On 03 Aug 2001 14:40:12 +0200, Corinna Vinschen wrote:
> > > +  operator pwd_state ()
> > > +    {
> > > +      struct stat st;
> > > +
> > > +      if (!stat ("/etc/passwd", &st) && st.st_mtime > last_modified)
> > > +	{
> > > +	  state = uninitialized;
> > > +	  last_modified = st.st_mtime;
> > > +	}
> > > +      return state;
> > > +    }
> We're reentrant here because of the stat() call. You need to alter the
> read_etc_passwd(function to not recurse forever (as is done for the
> fopen call - thats the passwd_state !=initilizing test). (Or have you
> tested for that particular race?)

I'm not quite sure if I know what you mean. Could you explain that
in a more detailed way? As for testing, I'm using a Cygwin DLL with
this patch since I've created the patch.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
