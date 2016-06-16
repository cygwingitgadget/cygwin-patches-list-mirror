Return-Path: <cygwin-patches-return-8586-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107705 invoked by alias); 16 Jun 2016 13:03:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107689 invoked by uid 89); 16 Jun 2016 13:03:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=View, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, arrange
X-HELO: calimero.vinschen.de
Received: from ipbcc0227e.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.34.126) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 16 Jun 2016 13:02:48 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 847C7A8067E; Thu, 16 Jun 2016 15:02:46 +0200 (CEST)
Date: Thu, 16 Jun 2016 13:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [setup] move view from left to right
Message-ID: <20160616130246.GC8546@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ea3fb37b-8c1f-38be-a52f-3e2dae74d14c@gmail.com> <20160615124947.GE27295@calimero.vinschen.de> <c0854c9c-3b17-4570-733d-fc325b27d1f9@gmail.com> <f1540797-04ba-316b-487e-daaeb85b3381@gmail.com> <20160615153936.GF27295@calimero.vinschen.de> <6e6c7336-45c1-bc47-5470-c48810376e64@gmail.com> <20160616120712.GA8546@calimero.vinschen.de> <f47c6201-decd-7833-ca12-a3f2e4f20d5e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <f47c6201-decd-7833-ca12-a3f2e4f20d5e@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q2/txt/msg00061.txt.bz2


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1112

On Jun 16 14:32, Marco Atzeri wrote:
> On 16/06/2016 14:07, Corinna Vinschen wrote:
> > On Jun 16 13:13, Marco Atzeri wrote:
> > > On 15/06/2016 17:39, Corinna Vinschen wrote:
> > > > On Jun 15 16:52, Marco Atzeri wrote:
> > > > > On 15/06/2016 16:37, Marco Atzeri wrote:
> > > > > > On 15/06/2016 14:49, Corinna Vinschen wrote:
> > >=20
> > > > What about this:
> > > >=20
> > > > - Arrange the "View" button with the left side of the package table.
> > > >=20
> > > > - Arrange the accompanying text right of the button.
> > > >=20
> > > > - Move "Search [...] Clear" to the center?
> > > >=20
> > > > - If you don't mind the extra work, align the y-pos and height of t=
he
> > > >   search stuff to the other elements in the row?
> > > >=20
> > >=20
> > > http://matzeri.altervista.org/works/setup/Round2/
> > >=20
> > > let me know
> >=20
> > looks great!
> >=20
> >=20
> > Thanks,
> > Corinna
> >=20
>=20
> attached the two patches

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXYqN2AAoJEPU2Bp2uRE+g6ZwQAJ+9BVdGLY95wa12lyc5F7XE
mcHJIbGVLz55lmzyKUwKeUJX7I44QQ+r08MLy5+7IFfTIgOvUAOiy11xBeF2G5xK
MOcSn1ghOy8gBBAQ0w9K3cLdXpUC8JWkvORt7tntjDTQJ1LsxNaiJ2GxPRLr33bS
yUWNoakWgCDphCBUF/mV6b1+B25Dt3wwyDOD6ib4xvfgfgYEr8c8GmRt3CAryrWj
Yof1NtMFrCmhqUmsE4OATuGKosjkJDRnk4GsYTou940BM1DV6xGfY8XDxr+JCK6l
VoBsq0uSXrTDvaONczcZei5cBzGkSNBImOm4oN/d8aWvodn9kcj6NfoXqow4Z35L
Xpt9EyPMkgzcnx7a7WaetvBxjWPRxOjqBjNAe5eZ/qFFWIafAFwFuPIDsioc3WiQ
tejAcGhqdSo71o8aMWSO0xP8XRXq/afGBAnK1nQw/eWmyT90JRZbhUFhV0HP4Uef
6T5ShSY96baGuL62N4OWD/DhvDFRfoUNuxHCHmZGL9XaeOQLDUq1SvrL5rd5OV6r
3xk39zjsGDBPQypzVEIY6QEpGDcFZfhqP46+/xpSaMXjQpsm/Wk5rATZ9eZe1ouz
YCDDcbwYVxPxarCMG9Xd3VEeE7tvrnWhBg394lH4UH3OxoMvqor6KCLpriO6ioi/
SJsrApBHJ9DSB+SlmRP+
=F159
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
