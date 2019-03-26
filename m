Return-Path: <cygwin-patches-return-9239-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31820 invoked by alias); 26 Mar 2019 18:28:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31809 invoked by uid 89); 26 Mar 2019 18:28:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 26 Mar 2019 18:28:28 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MeTD8-1gat2K3JUC-00aT7B; Tue, 26 Mar 2019 19:28:24 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 59D72A8054E; Tue, 26 Mar 2019 19:28:24 +0100 (CET)
Date: Tue, 26 Mar 2019 18:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190326182824.GB4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>,	cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20190326182538.GA4096@calimero.vinschen.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00049.txt.bz2


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3381

On Mar 26 19:25, Corinna Vinschen wrote:
> Hi Michael,
>=20
>=20
> Redirected to cygwin-patches...
>=20
>=20
> On Mar 26 18:10, Michael Haubenwallner wrote:
> > Hi Corinna,
> >=20
> > as I do still encounter fork errors (address space needed by <dll> is
> > already occupied) with dynamically loaded dlls (but unrelated to
> > replaced dlls), one of them repeating even upon multiple retries,
>=20
> Why didn't rebase fix that?

Btw., is that 32 or 64 bit?  Both?


Corinna


> >  I'm
> > coming up with attached patch.
> >=20
> > What do you think about it?
>=20
> I'm not opposed to this patch but I don't quite follow the description.
> threadinterface->Init only creates three event objects.  From what I can
> tell, Events are stored in Paged and Nonpaged Pools, so they don't
> affect the processes VM.  What am I missing?
>=20
>=20
> Thanks,
> Corinna
>=20
>=20
> >=20
> > Thanks!
> > /haubi/
>=20
> > >From dfc28bcbb7ed55fe33ddb8d15e761b4d5b4815f8 Mon Sep 17 00:00:00 2001
> > From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
> > Date: Tue, 26 Mar 2019 17:38:36 +0100
> > Subject: [PATCH] Cygwin: fork: reserve dynloaded dll areas earlier
> >=20
> > In dll_crt0_0, both threadinterface->Init and sigproc_init allocate
> > windows object handles using unpredictable memory regions, which may
> > collide with dynamically loaded dlls when they were relocated.
> > ---
> >  winsup/cygwin/dcrt0.cc | 6 ++++++
> >  winsup/cygwin/fork.cc  | 6 ------
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> > index 11edcdf0d..fb726a739 100644
> > --- a/winsup/cygwin/dcrt0.cc
> > +++ b/winsup/cygwin/dcrt0.cc
> > @@ -632,6 +632,12 @@ child_info_fork::handle_fork ()
> >=20=20
> >    if (fixup_mmaps_after_fork (parent))
> >      api_fatal ("recreate_mmaps_after_fork_failed");
> > +
> > +  /* We need to occupy the address space for dynamically loaded dlls
> > +     before we allocate any dynamic object, or we may end up with
> > +     error "address space needed by <dll> is already occupied"
> > +     for no good reason (seen with some relocated dll). */
> > +  dlls.reserve_space ();
> >  }
> >=20=20
> >  bool
> > diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
> > index 74ee9acf4..7e1c08990 100644
> > --- a/winsup/cygwin/fork.cc
> > +++ b/winsup/cygwin/fork.cc
> > @@ -136,12 +136,6 @@ frok::child (volatile char * volatile here)
> >  {
> >    HANDLE& hParent =3D ch.parent;
> >=20=20
> > -  /* NOTE: Logically this belongs in dll_list::load_after_fork, but by
> > -     doing it here, before the first sync_with_parent, we can exploit
> > -     the existing retry mechanism in hopes of getting a more favorable
> > -     address space layout next time. */
> > -  dlls.reserve_space ();
> > -
> >    sync_with_parent ("after longjmp", true);
> >    debug_printf ("child is running.  pid %d, ppid %d, stack here %p",
> >  		myself->pid, myself->ppid, __builtin_frame_address (0));
> > --=20
> > 2.17.0
> >=20
> >=20
>=20
> >=20
> > --
> > Problem reports:       http://cygwin.com/problems.html
> > FAQ:                   http://cygwin.com/faq/
> > Documentation:         http://cygwin.com/docs.html
> > Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
>=20
>=20
> --=20
> Corinna Vinschen
> Cygwin Maintainer



--=20
Corinna Vinschen
Cygwin Maintainer

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyab0gACgkQ9TYGna5E
T6Bg/w/+Jjl4WsHZijnsj/YbgoMHMQaLWyTy2MdyfBBNbBEEF72FY7U32+7/+3fD
UGRrI5n+qILtn2/1zh/EpmvXdK5hqIt99lP2jZ8dGibGc4cLiZNw1c/fAYCPVeK/
qTIfPBBVFy3vcqSURe/4Um26PPx370yEvV3SxstsI3JL+2xftQl4R+kfyRmSuMD8
yL34S7+mAPb5fvn+GNXz2pTvImGXybwqFRiGSdYMvGk088UKtJJGbftFE54qWlU5
jkxdQVWLoYr0tM404aV0jt3B5w+P7fz+r5S2ThpDLVXm/ZJFVQsPPwg8E0exrtqV
DaN7i4+Uf+jgAKWjFmk0rc/krz3HksV8UCjBktRdgBeuooHTIpk1yzZfXVwm8+pY
FzZrQ2yc3QwtlPPf5Yax4ZOqtPcQE92AH1e7vCozZ0QT1xY7FXlCeK+ZD4M6FByI
EpR31ObxYHcLdK/B5OOoNab7DULTdwC90Ew2lrziBkSiI2X4KzzmN6j2X/UDfQ/R
ZAYkmkRdIYRYwqxYseTWbBRDxHs8ED6R4AhvE2EtyVYYLCLxA44unZbdrRZzy8cT
+d5wJKRtEarDq4KmNJXOE3QyMufAsqzwWheW7KR4vj9SWsQC6bf0Z76fhJ9T9Drq
CGkoV0H16j5qBurRLIpM06KX3aYBz5sgh859fPsyyKpkmwJ8CG4=
=IgEx
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
