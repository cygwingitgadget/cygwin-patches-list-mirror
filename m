Return-Path: <cygwin-patches-return-8293-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21647 invoked by alias); 17 Dec 2015 21:02:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21635 invoked by uid 89); 17 Dec 2015 21:02:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-100.3 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,SCAM_SUBJECT,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=435, H*r:188.192.47, Hx-spam-relays-external:sk:ipbcc02, H*r:sk:ipbcc02
X-HELO: calimero.vinschen.de
Received: from ipbcc02fe8.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.47.232) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 17 Dec 2015 21:02:37 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 49D7BA8062D; Thu, 17 Dec 2015 22:02:35 +0100 (CET)
Date: Thu, 17 Dec 2015 21:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Respect `db_home` setting even for the SYSTEM account
Message-ID: <20151217210235.GD3507@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com> <cover.1450375424.git.johannes.schindelin@gmx.de> <90c5b45fbe7c26e85e65d69d999b4118a2a89c5a.1450375424.git.johannes.schindelin@gmx.de> <20151217204929.GB3507@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="u+FGODhbLwgAeSOU"
Content-Disposition: inline
In-Reply-To: <20151217204929.GB3507@calimero.vinschen.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00046.txt.bz2


--u+FGODhbLwgAeSOU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2298

On Dec 17 21:49, Corinna Vinschen wrote:
> On Dec 17 19:05, Johannes Schindelin wrote:
> > We should not blindly set the home directory of the SYSTEM account to
> > /home/SYSTEM, especially not when that value disagrees with what is
> > configured via the `db_home` line in the `/etc/nsswitch.conf` file.
> >=20
> > This fixes https://github.com/git-for-windows/git/issues/435
> >=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  winsup/cygwin/uinfo.cc | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> > index a5d6270..8c51b82 100644
> > --- a/winsup/cygwin/uinfo.cc
> > +++ b/winsup/cygwin/uinfo.cc
> > @@ -2129,7 +2129,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_a=
rg_t &arg, cyg_ldap *pldap)
> >  	 it to a well-known group here. */
> >        if (acc_type =3D=3D SidTypeUser
> >  	  && (sid_sub_auth_count (sid) <=3D 3 || sid_id_auth (sid) =3D=3D 11))
> > -	acc_type =3D SidTypeWellKnownGroup;
> > +	{
> > +	  acc_type =3D SidTypeWellKnownGroup;
> > +	  home =3D cygheap->pg.get_home (pldap, sid, dom, domain, name,
> > +				       fully_qualified_name);
>=20
> Uhm, that's a bit over the top, isn't it?  It will affect all S-1-5-X
> accounts as well as the S-1-5-11 Windows account SIDs.  Is that really

s/S-1-5-11/S-1-11/, sorry.

> what you want?
>=20
> Using pldap here may SEGV in cygheap_pwdgrp::get_home, btw, because
> it may be NULL.  cygheap_pwdgrp::get_home doesn't check pldap for
> validity, it expects a valid pointer.  You could either use cldap, or
> cygheap_pwdgrp::get_home would have to check pldap before using it.
>=20
> However, either way there's another problem: Independently of the
> configured db_home schemes, you don't want to ask the DC for info on
> these builtin accounts.  The better approach might be to call the
> PUSER_INFO_3 variant of cygheap_pwdgrp::get_home with a NULL ui
> pointer and just check for ui in the NSS_SCHEME_DESC case.  The other
> called functions fetch_windows_home and fetch_from_path both can
> live with both pointers, pldap and ui being NULL.

Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--u+FGODhbLwgAeSOU
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcyLrAAoJEPU2Bp2uRE+gs5wP+QHkL3MEb6/KAXOIW3bNg4Y9
kZngxq8KoxyO2gddxKxWMnZlewauzn/Oicxtx2A4ddodanEjaUGdM+CBElqwz3fL
GMnzb5htIeGxSG7vgYmPN5PrIG5ZKQFAO0Sgcxsomj5a64yzzr5auldD+7uYPm1t
coAXxm5FwLeBzzOq5TIyUZR74XI2/GZx9A8Vphin7HTIN8MV892c9ZYI0H2wee/B
Gy9hue0XPR7n5Csupx93hFimDL7F6Z821pIxpnxTpBZh8riNCgM2dpBT+IFwR9T5
QU4TR51peysSbAd9PJ86fOTWWOrHJwwsqsyizdpDFE46lkvKCZLbYxebCVaoFzra
jGuu77LYvUYSCuGDhJt0ROSvQQqMycH10oGgpOehmDzc9tgKxmUxtfJLdQnT8VCy
eVRMbGZBsIrrUXsXz/r67Tg/Kphvw8ClwhBJ/26Ln1BIUttlx8bKNVYNJvDvWP6f
d3RY5i+LPljFJvy3leW421j6vhZTXGF/d/dPy4FZF/XwyoGRJlJTCI7ycq0WDXew
xQz1odpZksog/6DvfTnEbmQdMUzlHLdo1t1GF8BuzhZ3O+Rz3YdG2tOtjS4ptN4h
oj2CAwhnfF9IrT1nPlgTZ/RFGeyZjIW/loEn2mayz2DEpIqK+45Fb45A4w48mjE2
qc0nvhqG6UmkQ5/DJbFH
=mum1
-----END PGP SIGNATURE-----

--u+FGODhbLwgAeSOU--
