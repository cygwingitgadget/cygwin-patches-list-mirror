Return-Path: <cygwin-patches-return-9137-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44048 invoked by alias); 23 Jul 2018 15:37:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44036 invoked by uid 89); 23 Jul 2018 15:37:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=Glad, cygwin-patches, cygwinpatches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 23 Jul 2018 15:37:03 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MLyNI-1feJV240gG-007iPF for <cygwin-patches@cygwin.com>; Mon, 23 Jul 2018 17:37:01 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 359B7A809C3; Mon, 23 Jul 2018 17:37:00 +0200 (CEST)
Date: Mon, 23 Jul 2018 15:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: getfacl output
Message-ID: <20180723153700.GC3312@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <48785885-6501-f00e-1949-d923fe7ed41b@cornell.edu> <20180723150622.GB3312@calimero.vinschen.de> <2961960c-9b29-708d-8491-72f938728f90@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <2961960c-9b29-708d-8491-72f938728f90@cornell.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00032.txt.bz2


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1525

On Jul 23 11:15, Ken Brown wrote:
> [Redirecting to cygwin-patches.]
>=20
> On 7/23/2018 11:06 AM, Corinna Vinschen wrote:
> > On Jul 23 10:43, Ken Brown wrote:
> > > This is obviously very minor, but I bumped into it because of a faili=
ng
> > > emacs test.
> > >=20
> > > Cygwin's getfacl prints only one colon after "mask" and "other", but =
Linux's
> > > prints two.  I'm sure this was done for a reason, but I'm wondering i=
f it
> > > would be better to follow Linux.
> >=20
> > The original version was designed after Solaris documentation,
> > but the layout is supposed to look like Linux for a while, so
> > ther missing colon is a bug.
> >=20
> > >    I'll be glad to submit a patch.
> >=20
> > Glad to review it :)
>=20
> Attached.
>=20
> Ken

> From de841bf40ecdbf93e87d0900d4dd567af32b072f Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Mon, 23 Jul 2018 10:10:03 -0400
> Subject: [PATCH] getfacl and setfacl: Align with Linux
>=20
> Make getfacl print two colons instead of one after "other" and "mask".
> Change the help text for setfacl to indicate that there can be either
> one colon or two.
> ---
>  winsup/utils/getfacl.c | 12 ++++++------
>  winsup/utils/setfacl.c |  6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)

Pushed.  I just wonder if we shouldn't simplify getfacl to use
acl_to_text instead.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltV9hwACgkQ9TYGna5E
T6CRrA/9G1TfhHwW7iOLknWGHvWV6X/Wpy6Pc4NVCzn7RntrmX0Z2KktktMSUkmm
3arcz3iPzoyxTuXkQuVjAlwnTA0RdQ6Malu3A51KR+iJ5cUHLrgxxCbxr0Ts+6EI
SJZp2Vp0xWnk1BoSpmEo4aIIU1nnVFuAmS8ucCfEwR0XJFhcMMr3EhhdarhCJDg0
8R6AnAZks+2VUnfTYtt9ytjbXr7yqPz9XOdCd6vAqmm3yGv9ogyWINVBeJDDSuYb
AxywCEznsTFOZO6lF2NVTBuiciG2pBSXkN3s+zMqubb9KuCl/IN7F92nAqMlxDih
0BICJHy7fHiJVw2UiX2ulT3FR6ge89Ua3y5d4xLP2sk2JOo646qJnNlV/w/Ifrud
1QpeUUvXBEII3PGUDg23vHQZjYQh7l7Fm5904sgIZXccJp13L7KGOhb6eUAxQ62J
EMtaVy0th/lOuZc9YnejQ8QVm4GaOwhiFdodZw12QTi5XNqnCVW8UKxHxkzj4g2U
hBMB778BiZ31VH4gL4klcKMpWYj/yGX9K5WZFkDT7yzWvl/sQWf4EboCTL3ZZbGc
3SDfXvtSJhRR2YWngFSOEoZKgHakKIVobukNwXVxJF1GP8QJ7ck9pT7sD/gRBDDB
uGLL46AF3xBSmanZIC5STAA5VR2YvbFyZKn5HeXFu60J/XzQC/s=
=EbGr
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
