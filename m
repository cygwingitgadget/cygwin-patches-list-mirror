Return-Path: <cygwin-patches-return-9147-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48074 invoked by alias); 25 Jul 2018 07:35:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47931 invoked by uid 89); 25 Jul 2018 07:35:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=you!
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Jul 2018 07:35:29 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis) id 0M1Wqf-1fy6UB14Jd-00tVjb for <cygwin-patches@cygwin.com>; Wed, 25 Jul 2018 09:35:26 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7D265A809C3; Wed, 25 Jul 2018 09:35:25 +0200 (CEST)
Date: Wed, 25 Jul 2018 07:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: getfacl output
Message-ID: <20180725073525.GG3312@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <48785885-6501-f00e-1949-d923fe7ed41b@cornell.edu> <20180723150622.GB3312@calimero.vinschen.de> <2961960c-9b29-708d-8491-72f938728f90@cornell.edu> <20180723153700.GC3312@calimero.vinschen.de> <4da0ada7-bfb0-4ac1-030b-6b7253d60a1b@cornell.edu> <b6063dcc-b755-b531-186a-6ff43e308d17@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <b6063dcc-b755-b531-186a-6ff43e308d17@cornell.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00042.txt.bz2


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 712

On Jul 24 18:33, Ken Brown wrote:
> On 7/23/2018 12:06 PM, Ken Brown wrote:
> > On 7/23/2018 11:37 AM, Corinna Vinschen wrote:
> > > Pushed.=C2=A0 I just wonder if we shouldn't simplify getfacl to use
> > > acl_to_text instead.
> >=20
> > Yes, that makes sense.=C2=A0 I'll take a look.
>=20
> Patch attached.

Pushed, thank you!  I just applied a minor tweak (removed
#include <cygwin/acl.h>).

> I thought it might be possible to simplify setfacl in a similar way, but I
> didn't see a way to do it.

Yeah, it's a bit more tricky :}  No worries.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltYKD0ACgkQ9TYGna5E
T6CKUQ//d43/ld6aLpVeTh4/DG8MjIuv0cuzGWwSWvx7Ml4p78OW7tRB+sjRTz1c
E9fXVz3StY4/BvjZ54dK4YiRrgd7EzbZ1pteZA3ZAjzNQVOtCfQGTMSJZLqCHilB
vC8mgR+2AJYNKWL6i4qEjb5y9kcqz+6R0w/oQYrO11hW2bS4lkeSiAuY5Tk9AVY4
gOn9ut6MQnPxTgZj6iEJ6MFAdNPP3i0gjw0NtXo+MwPCJilFMZ5IDIUT7ZUqdZd3
raENbjQiP6x6RY8Z19Bi+vM/azNlA3TSyGZnRh4gUobZGBDTGluM62ovSu3vL3Cm
FOslB7XKbZvEUPU4MeeXqQcIUaiS1RZglEIo0YMAHhCJ/KIGj4AxLwowVoKkK+Dx
GKWwBmWMZwGvkGzXtuChFrJ/xYCWrRSqJ6mOtHMHgTZOXOci7gBhofK4q2neN3YE
j7GWNvm188wvVui0WORndlAFGK1AhA/1MIAx9KsLFJCWNwgJJoCdCBpz97PoEMn9
rFPrqGrhhDt4QsCBzdTZCYDtzg+Apsdn5gsIN5CGeEFy9+Ly/3y2jsud6Zy5pKSJ
9loivr5QrJR3RvjSgxT7obvNMec6XPK2GXPOEEZFvmNGqpDbAtEapZd7v+N5vxBH
Rk+WvPXBDTt2XbWqD61ZBZohlGiXtN9OkQGr3RHS5VJtgHsg7Qo=
=v9mW
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
