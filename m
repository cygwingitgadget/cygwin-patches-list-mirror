Return-Path: <cygwin-patches-return-8116-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54127 invoked by alias); 3 Apr 2015 14:08:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54116 invoked by uid 89); 3 Apr 2015 14:08:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 Apr 2015 14:08:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4B503A8095D; Fri,  3 Apr 2015 16:08:07 +0200 (CEST)
Date: Fri, 03 Apr 2015 14:08:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Only construct ucontext for SA_SIGINFO signal handlers
Message-ID: <20150403140807.GV13285@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1428003041-14404-1-git-send-email-jon.turney@dronecode.org.uk> <20150403111806.GO13285@calimero.vinschen.de> <20150403121707.GT13285@calimero.vinschen.de> <551E8CBB.4020306@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="t3wCcZxwnWQbJWrM"
Content-Disposition: inline
In-Reply-To: <551E8CBB.4020306@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00017.txt.bz2


--t3wCcZxwnWQbJWrM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2734

On Apr  3 13:51, Jon TURNEY wrote:
> On 03/04/2015 13:17, Corinna Vinschen wrote:
> >On Apr  3 13:18, Corinna Vinschen wrote:
> >>On Apr  2 20:30, Jon TURNEY wrote:
> >>
> >>>        sigset_t this_oldmask =3D set_process_mask_delta ();
> >>>-      thiscontext.uc_sigmask =3D this_oldmask;
> >>>+      context.uc_sigmask =3D this_oldmask;
> >>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>
> >>This call to set_process_mask_delta() should occur before constructing
> >>the context, so that filling in uc_sigmask can be moved into the above
> >>`'if' branch.
>=20
> Ok, I will move it.
>=20
> >>On second thought, isn't this slightly wrong anyway?  Shouldn't that be
> >>
> >>          context.uc_sigmask =3D _my_tls.sigmask;
> >>	 context.uc_mcontext.oldmask =3D this_oldmask;
>=20
> As I wrote elsewhere:  You'll have to help me understand what the differe=
nce
> in meaning between ucontext_t.uc_sigmask and ucontext_t.uc_mcontext.oldma=
sk
> is.
>=20
> I don't see how the value of _my_tls.sigmask has any meaning at that point
> in the code.

Ok, I had a look into the Linux source and searched the web, and here's
the problem.

One is that sigset_t on Linux is not just a 32 or 64 bit bitmask anymore,
but an array of ulong's used as a rather big sigmask.

OTOH, mcontext_t::oldmask is only the size of "unsigned long".  In fact,
as it turns out by inspecting the Linux kernel, oldmask is nothing else
than the first bits of uc_sigmask which fit into an unsigned long.  And
in the net I found that oldmask is just the old representation of
sigset_t, before the Linux kernel allowed more signals than fit into
a bitmask of unsigned long size.  In fact, it's only for backward compat,
but unused these days.

Given that, setting context.uc_sigmask to this_oldmask is apparently
the right thing to do.  For emulating backward compat (which we don't
need, but it also doesn't hurt), we could set oldmask to the same
value:

  context.uc_sigmask =3D context.uc_mcontext.oldmask =3D this_oldmask;

> >Oh, btw., what about cr2?  Right now, with the above code, it contains
> >a random value.  It should at least be zero'ed out.  Alternatively:
> >
> >   context.uc_mcontext.cr2 =3D (thissi.si_signo =3D=3D SIGSEGV
> >			     || thissi.si_signo =3D=3D SIGBUS)
> >			    ? (uintptr_t) thissi.si_addr : 0;
> >
>=20
> Sure, but can we deal with that as a separate patch?

Yes, but you can just apply it as well.  cr2 is the address of a page
fault, so that's equivalent to the value in ExceptionInformation[1]
which, in turn, is stored in si_addr in exception::handle.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--t3wCcZxwnWQbJWrM
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVHp7HAAoJEPU2Bp2uRE+gUBMP/2PTfwXmBoXrnk1ubKpmkAwu
Zbgm9DQe+671EkTxQl70DaonLPM8ROwkqLy8qRT4vFy2bzl+zIqYYXm49hR92iGw
Txrq8Qjrjcz7FFYgFI8/EDr3Z5uohIjLOZ1dq4gaL1MEPsDUOPQPORn4rCFirHMW
AR5iECrRljoDOlrF7KiOtBYoe1nmXtv1dNZ2Ok2GvetxkNkmO0GC6mP1mf0DV7nh
2hFTBTRlZtsdP8gpuXVK9QF4e6ahzubKzM6gB/SV5jG2o9FS/cShzUQ9XYNZBGX4
HPl3ta7HcsNdENWr51dH4oqQVFhawrqz7zvvxT5cdv9Q3hW2Y97G9YmlYpqVDY+7
LCrvRHpOGvvYJ06TreNHr69jo6X7AoZ3giG2KMYVFV1mfTlTfao3h0w2Ir9ren23
9G6dAFq8PradJuZ8aFyz8lt2ERRJS/ZJ4eO4roR0VGiNOyVWSukrNuDYcXYyk/M4
bmqzYJIBlacTVvEPPTb2dIt8j7BOO2IGKr/hdwsnZUhSjiXFg3JnM5XTaIC8lqWu
m3EfOE10AxBTvCjYj6uvNDKdVRxhKqc+d0SSEnvop+Qm/Ot/AvXfLyYD9WY4HKw6
ghkutzwx7mu6AIjWJ3wZ3oXRbsDVIcmzDZPIbPbCKeBJHSGOf/p+XAogqDyI8Vq1
sJqBAF6LQ0GeFvH9aDtm
=mND1
-----END PGP SIGNATURE-----

--t3wCcZxwnWQbJWrM--
