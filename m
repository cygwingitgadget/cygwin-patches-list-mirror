From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: Files with system bit set.
Date: Mon, 08 May 2000 14:28:00 -0000
Message-id: <39173153.D5468099@vinschen.de>
References: <3917298E.821F9CE5@vinschen.de> <20000508171856.A1920@cygnus.com>
X-SW-Source: 2000-q2/msg00044.html

Chris Faylor wrote:
> 
> Doesn't this always set errno to EINVAL?  How is that better?

It's better because it's the expected behaviour for ordinary
files. Excerpt from path_conv::check():

     int len = sym.check (path_copy, suff);

     if (!component)
       path_flags = sym.pflags;

     /* If symlink.check found an existing non-symlink file, then
        it returns a length of 0 and sets errno to EINVAL.  It also sets
        any suffix found into `ext_here'. */
     if (!sym.is_symlink && sym.fileattr != (DWORD) -1)
       {
         if (component == 0)
           {
             fileattr = sym.fileattr;
             goto fillin;
           }
         goto out; // file found
       }


Corinna
