Return-Path: <cygwin-patches-return-8292-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14907 invoked by alias); 17 Dec 2015 20:49:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14892 invoked by uid 89); 17 Dec 2015 20:49:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-100.3 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,SCAM_SUBJECT,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=435, H*r:188.192.47, Hx-spam-relays-external:sk:ipbcc02, H*r:sk:ipbcc02
X-HELO: calimero.vinschen.de
Received: from ipbcc02fe8.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.47.232) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 17 Dec 2015 20:49:31 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B8073A8062D; Thu, 17 Dec 2015 21:49:29 +0100 (CET)
Date: Thu, 17 Dec 2015 20:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Respect `db_home` setting even for the SYSTEM account
Message-ID: <20151217204929.GB3507@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com> <cover.1450375424.git.johannes.schindelin@gmx.de> <90c5b45fbe7c26e85e65d69d999b4118a2a89c5a.1450375424.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="OrT4iOlIQZp3kw4S"
Content-Disposition: inline
In-Reply-To: <90c5b45fbe7c26e85e65d69d999b4118a2a89c5a.1450375424.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00045.txt.bz2


--OrT4iOlIQZp3kw4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2139

On Dec 17 19:05, Johannes Schindelin wrote:
> We should not blindly set the home directory of the SYSTEM account to
> /home/SYSTEM, especially not when that value disagrees with what is
> configured via the `db_home` line in the `/etc/nsswitch.conf` file.
>=20
> This fixes https://github.com/git-for-windows/git/issues/435
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/uinfo.cc | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> index a5d6270..8c51b82 100644
> --- a/winsup/cygwin/uinfo.cc
> +++ b/winsup/cygwin/uinfo.cc
> @@ -2129,7 +2129,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg=
_t &arg, cyg_ldap *pldap)
>  	 it to a well-known group here. */
>        if (acc_type =3D=3D SidTypeUser
>  	  && (sid_sub_auth_count (sid) <=3D 3 || sid_id_auth (sid) =3D=3D 11))
> -	acc_type =3D SidTypeWellKnownGroup;
> +	{
> +	  acc_type =3D SidTypeWellKnownGroup;
> +	  home =3D cygheap->pg.get_home (pldap, sid, dom, domain, name,
> +				       fully_qualified_name);

Uhm, that's a bit over the top, isn't it?  It will affect all S-1-5-X
accounts as well as the S-1-5-11 Windows account SIDs.  Is that really
what you want?

Using pldap here may SEGV in cygheap_pwdgrp::get_home, btw, because
it may be NULL.  cygheap_pwdgrp::get_home doesn't check pldap for
validity, it expects a valid pointer.  You could either use cldap, or
cygheap_pwdgrp::get_home would have to check pldap before using it.

However, either way there's another problem: Independently of the
configured db_home schemes, you don't want to ask the DC for info on
these builtin accounts.  The better approach might be to call the
PUSER_INFO_3 variant of cygheap_pwdgrp::get_home with a NULL ui
pointer and just check for ui in the NSS_SCHEME_DESC case.  The other
called functions fetch_windows_home and fetch_from_path both can
live with both pointers, pldap and ui being NULL.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--OrT4iOlIQZp3kw4S
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcx/ZAAoJEPU2Bp2uRE+gjyAQAJu5hJuObTYvxVLTGSvkRCaX
o7E//fO9nj1DANRP+9gGjE5NUMUs3Hcv2iZDD6/R5ciS0mG2Uq3ZvkeD9S0gpL7a
lnaHFdMCc/LzOjXBAgY/2YbuaBoAdqqo8sIWSdJOr3kWsZK9htoNUNSB1EjBOuiZ
XokB3sZif0Nk+3WT98Y3s46zM+24pNx/H4hYctkGFsMI9Wq+jb6BzK7GpoioPtqi
vCjkMYr4PIbbpq5+y644Xdg8cZ2TAoouyZcEgAhhrTuFTnZDuEPhLSbVLpqx1a6j
b6MLRWhENAftFe6PLN7MRKVCqZEr5hh4Vxcx75kEYcLxQYjIpcY67VKCPtD+Wra2
sDTxM/p9/rNmNmHrhIfqAQEoMLrbeLrZauEkRAa7+hqyY73SRxSca85pGqFz0n1r
HuvzfnMrYRxhP8jWZ9Y03fQuMmHzjoCdbInWFRZ6LPfqFCt1yuj/1Vii3SA5Ivkg
v9S/mnNvqtpi8bWVWU8dvFdyECIFy1qxrPmBkPmroi/FI7QJtnt7orej3+V6GFx9
RnQ7LQhyda6VIBX41rVmYQSWVVzQynJdmL69bqlFrumgiJ/iJhwo+5tyuKzEeUsO
9h70W+Xun05DdCDkXZgqG1Gf+ReLgWh0s+qpvuyJ0MjjVVjfgWx0IX9Ga7KO1IJG
Ijz6ZwrZUtPjx1K3+4u6
=iWkq
-----END PGP SIGNATURE-----

--OrT4iOlIQZp3kw4S--
