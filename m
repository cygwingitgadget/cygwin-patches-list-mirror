Return-Path: <cygwin-patches-return-4708-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14037 invoked by alias); 5 May 2004 13:55:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14023 invoked from network); 5 May 2004 13:55:30 -0000
Message-ID: <4098F250.29E4291@phumblet.no-ip.org>
Date: Wed, 05 May 2004 13:55:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: chdir
References: <20040505002003.GA8846@coe.bosbc.com> <3.0.5.32.20040504200359.007fcec0@incoming.verizon.net> <20040505002003.GA8846@coe.bosbc.com> <3.0.5.32.20040505004236.007ff280@incoming.verizon.net> <20040505095134.GA6206@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00060.txt.bz2

Corinna Vinschen wrote:
> 
> On May  5 00:42, Pierre A. Humblet wrote:
> > At 08:25 PM 5/4/2004 -0400, Christopher Faylor wrote:
> > >Another thing occurs to me -- maybe it would simplify things just to
> > >store a patch_conv structure on the cygheap rather than use a separate
> > >cwdstuff structure.  It would take up more space on the cygheap but I
> > >think it would probably be cleaner in general.
> >
> > Maybe, but the simplicity isn't obvious to me. For example a path_conv
> > would have a win32 path and a normalized_path, but the normalized_path
> > could start with a drive. That's not what cwdstuff::posix currently
> > expects, because it might confuse Unix programs.
> 
> Erm... so what's the difference to what your patch is doing now?
> You're using path.normalized_path unchanged which means, it could
> start with a drive, too.

Erm, see below.

> > The main questions are whether using the normalized_path below is valid
> > and why pcheck_case == PCHECK_RELAXED is needed.
> >
> > -  else if ((!path.has_symlinks () && strpbrk (dir, ":\\") == NULL
> > -           && pcheck_case == PCHECK_RELAXED) || isvirtual_dev (devn))
> > -    cygheap->cwd.set (native_dir, dir);
> > +  else if (!isdrive (path.normalized_path)
> > +           && pcheck_case == PCHECK_RELAXED)
> > +    cygheap->cwd.set (native_dir, path.normalized_path);
> >    else
> >      cygheap->cwd.set (native_dir, NULL);
> 
> path.normalized_path could contain a drive letter so what your above
> change does is to let a drive letter through, while the original
> implementation doesn't.  That's what the `strpbrk (dir, ":\\")' is for.

Yes, and that's also what "isdrive (path.normalized_path)" is doing.
Except it's testing specifically for a drive, and not for a random :
that could happen with managed mounts.

> If we don't want to touch that (which is IMHO a good idea for 1.5.10 at
> least), we have to keep the strpbrk in, otherwise your patch looks ok to
> me.  The advantage is that we could apply the below patch as well which
> would simplify the dot and space stripping.
> 
> Uh, yes, the PCHECK_RELAXED test *is* needed.  Neither the path in "dir"
> in the old implementation, nor path.normalized_path are case adjusted.
> Using them would break the PCHECK_ADJUST case.

OK, but it should be fine with PCHECK_STRICT, shouldn't it?
So a better test would be pcheck_case != PCHECK_ADJUST.
Erm, what's the role of PCHECK_ADJUST in a chdir()? What could
be broken? 

I noticed that if we have a mount \\someshare\root  => /abc
then "cd //someshare/root" will result in the Posix working directory
being //someshare/root, not /abc. Do we care? If we do,
the test for a unc path should be added to the isdrive() test.
By the way, 1.5.9 also returns //someshare/root in that case.
However if there is a symlink xxxx pointing to \\someshare\root 
then "cd xxxx" yields the Posix working directory being /abc.

To simplify, why not call cygheap->cwd.set (native_dir, NULL)
all the time, except in the virtual case?
 
Pierre
