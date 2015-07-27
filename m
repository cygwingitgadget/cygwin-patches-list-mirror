Return-Path: <cygwin-patches-return-8227-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70557 invoked by alias); 27 Jul 2015 07:50:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 70523 invoked by uid 89); 27 Jul 2015 07:50:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.5 required=5.0 tests=AWL,BAYES_20,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-Spam-User: qpsmtpd, 2 recipients
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Jul 2015 07:50:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8D501A8084F; Mon, 27 Jul 2015 09:50:53 +0200 (CEST)
Date: Mon, 27 Jul 2015 07:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-developers@cygwin.com
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/cygwin: Protect fork() against dll- and exe-updates.
Message-ID: <20150727075053.GD7535@calimero.vinschen.de>
Reply-To: cygwin-developers@cygwin.com
Mail-Followup-To: cygwin-developers@cygwin.com, cygwin-patches@cygwin.com
References: <55B25D13.8040007@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <55B25D13.8040007@ssi-schaefer.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q3/txt/msg00009.txt.bz2


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 5552

Hi Michael,

On Jul 24 17:43, Michael Haubenwallner wrote:
> Hi!
>=20
> When starting to port Gentoo Prefix to Cygwin, the first real problem
> discovered is that fork() does use the original executable's location
> to Create the child's Process, probably finding linked dlls that just
> have emerged in the current directory (sth. like /my/prefix/usr/bin),
> causing "Loaded different DLL with same basename in forked child" errors.

Unfortunately there's some red tape to get over with, first.  We need a
copyright assignment from you before we can go much further.  See
https://cygwin.com/contrib.html, "Before you get started".  Please fill
out the standard assignment form and send the signed PDF to the address
given therein.

> Diving into the details, I'm coming up with (a patch-draft based on) the
> idea to create hardlinks for the binaries-in-use into some cygwin-specific
> directory, like \proc\<ntpid>\object\ ('ve seen this name on AIX),
> and use these hardlinks instead to create the new child's process.
>=20
> Thoughts so far?

Well, yes.  Off the top of my head a couple of potential problems come
to mind:

- /proc is already available as virtual filesystem as on Linux.  Reusing
  it for some purposes is ok, but in this case we're talking about a
  real directory of the same name, which then would be hidden beneath
  the virtual one.  Is that deliberate?  The directory wouldn't be
  accessible from Cygwin applications while native Windows apps would
  see the dir.  I think hidden is bad.  Something like this should take
  place in a visible cache dir.  /var/cache or /var/spool come to mind.

  Also, using the Windows PID as dir name seems a bit weird, given that
  the virtual /proc obviously uses the Cygwin PID.  This sounds like a
  source for confusion.

- What about running Cygwin on filesystems not supporting hardlinks,
  like FAT?

- There's a meme along the lines of "Why is Cygwin soooo Slow!!!1!!11".

  The most important factor for this slowness is the way fork() has to
  be emulated.  The method you're proposing would add to the overhead by
  having to create hardlinks on fork and deleting them again at exit or
  execve time.

  Did you run tests to find out the cost of this additional overhead?

> For now, when <cygroot>\proc\ directory does exist, the patch (roughly) d=
oes:
>=20
> For /bin/bash.exe, cygwin1.dll creates these hardlinks at process startup:
>   \proc\<ntpid>\object\bash.exe         -> /bin/bash.exe
>   \proc\<ntpid>\object\bash.exe.local      (empty file for dll redirectio=
n)
>   \proc\<ntpid>\object\cygwin1.dll      -> /bin/cygwin1.dll
>   \proc\<ntpid>\object\cygreadline7.dll -> /bin/cygreadline7.dll
>=20
> And frok::parent then does:
>=20
>   CreateProcess("\proc\<ntpid>\object\bash.exe", "/bin/bash.exe", ...)
>=20
> Resulting in another \proc\<ntpid>\object\ directory with same hardlinks.
>=20
> While attached patch does work so far already, there's a few issues:
>=20
> *) dll-redirection for LoadLibrary using "app.exe.local" file does operat=
e on
>    the dll's basename only, breaking perl's Hash::Util and List::Util at =
least.
>    So creating hardlinks for dynamically loaded dlls is disabled for now.
>    Eventually, manifests and/or app.exe.config could help here, but I'm s=
till
>    failing to really grok them...

Hmm.  The DLLs are loaded dynamically anyway, so they will be loaded
dynamically in the child as well in dll_list::load_after_fork_impl.  Why
not simply hardlinking them using a unique filename (e.g. using the
inode number), storing the unique number or name in the dll struct and
then calling LoadLibrary on this name?

> *) Who can clean up \proc\<ntpid>\ directory after power-loss or similar?
>    For now, if stale \proc\<ntpid>\ is found, it is removed beforehand.
>    But when this was from a different user, cleanup will fail. However,
>    using \proc\S-<current-user-id>\<ntpid>\ instead could help here...

Yes, that seems necessary.  The requirement to remove a complete
directory on process startup is a lot of effort, though.  I'm feeling a
sweat attack coming...

> *) Is it really necessary to create these hardlinks in the real filesyste=
m?
>    I could imagine to create them directly in $Recycle.bin instead, or so=
me
>    (other) memory-only thing...

Uh, well, they are hardlinks after all.  They must be created on the
same filesystem.

> Thoughts welcome!

In general I like the basic idea behind this.  But given the overhead it
adds to the already slow fork, I'm rather reluctant.  I'm sure this
needs at least a lot more discussion (for which the cygwin-developers
mailing list, redirected to, would be better suited).  For instance:

- What if a EXE/DLL is replace more than once during the lifetime of
  a process?

- What about reducing the overhead by implementing some kind of generic
  exe/dll cache used by all processes?  It would reduce the requirement
  to cleanup, reduce the footprint of the cache, speed up subsequent
  forks.

- Given that the /bin directory alone can be easily 0.5 Gigs and more,
  the cache(s) can take as much memory.  This really asks for some
  cleanup mechanism.

- The heretical question of course:  Is the underlying problem really
  worth the additional overhead?  The patch is pretty intrusive.
  Is there a simpler way to achieve the same or, at least, a similar
  result?

> Thank you!
> /haubi/

Thank you,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVteLdAAoJEPU2Bp2uRE+g33kP/iwdBTGPUi0RijJ1cQtzOWpr
3kL7rloNhSPQzwKjk3u0XNa/lRbXUGxx/DmATkpXSzNswXk30CLibS2h6C91UHxJ
Fri4M/f7Vc18+DPrMe2PmTk+5Y+QD16fJiJqWW3wBBueWJ19CjZhs63vC/JZc3Qb
16oMAqpnWf9CLS+f5T2QcZUip9vma/E+dmTDDgTlFPsKdbEcdZHr4ciYZ7Hst2nd
icUI2q7HCNgO3RmMbbJ1HPyIZDExeYopMBa6pF38fG48rxn52hU1Vv5gtckxwHYr
iTt+YUqr8NR4vVumeFmZzDWoxL3CnGkSxF0aXj4b0rFQQYBjjFWKJkh80Qx5GSm1
YzirgK0uWkhgBCV9VqFN1XSWligAC+pMDdCYz9FHpG2ux17YUdmyG6SJbFdm12IF
9pFEIPf6C6QALJ2wXQ6fL4aYM8QOYOU/MCGpdsvwgD/UfepY3TOeKhjfpEcrDJvQ
o9z64zpJ6QKKqWMqCYMuPggmyVGh64U7d67UQ0Nk8w8LH6Z6BVTSlIKRhWkPbxTL
aKzN9+ipQ4VGPc5ZITGv5CGVJgry+XuR9LOww0ybKBLPmqunxVK+MbH3qeBeVWdC
S6crdJKdBeCaoD/CQHKVuj0PUs0h0+FYXF4LgO9hhbx6/Iz8lWSm/gP2wOCDXfQ+
TRLBIRtZPGQ31HmH3Bhr
=p3TC
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
