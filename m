Return-Path: <cygwin-patches-return-8487-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100465 invoked by alias); 23 Mar 2016 10:44:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100430 invoked by uid 89); 23 Mar 2016 10:44:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=dll, H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 23 Mar 2016 10:44:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 48BC5A80643; Wed, 23 Mar 2016 11:44:13 +0100 (CET)
Date: Wed, 23 Mar 2016 10:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/5] Add with-only-headers
Message-ID: <20160323104413.GQ14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-5-git-send-email-pefoley2@pefoley.com> <20160321194758.GH14892@calimero.vinschen.de> <CAOFdcFMC60YLscHWDzsRz3q9cF1-KAc-d=CPhS5W_LeFRb83tg@mail.gmail.com> <20160321203235.GM14892@calimero.vinschen.de> <CAOFdcFMxbfteqjYWG_FOJ73Ey3LUbTQ-hKRJYOdBBBdM3k7m_w@mail.gmail.com> <CAOFdcFNRzey3=r76N1RD=b3rYu7RRow_CzLQitZJc4cV2heY=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="5KxTQ9fdN6Op3ksq"
Content-Disposition: inline
In-Reply-To: <CAOFdcFNRzey3=r76N1RD=b3rYu7RRow_CzLQitZJc4cV2heY=A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00193.txt.bz2


--5KxTQ9fdN6Op3ksq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1030

On Mar 21 17:30, Peter Foley wrote:
> On Mon, Mar 21, 2016 at 5:03 PM, Peter Foley <pefoley2@pefoley.com> wrote:
> > On Mon, Mar 21, 2016 at 4:32 PM, Corinna Vinschen
> > <corinna-cygwin@cygwin.com> wrote:
> >> Still hmm at this point.  AFAICS we only need the handful of definitio=
ns
> >> for new and delete operators, nothing else.  Is there perhaps a way to
> >> define this stuff by ourselves to avoid any requirement for libstdc++
> >> headers for building the DLL?  Or is that just not feasible?
>=20
> It is possible to avoid including libstdc++ headers, but since
> cygserver.exe links against
> libstdc++, we'd still need to build libstdc++, and we still have the
> mingw-crt headers dependency.
> So I'm not sure there's really any point essentially in-lining part of
> libstdc++'s new header so that we
> can build without libstdc++.

Ok.  Thanks for checking.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--5KxTQ9fdN6Op3ksq
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8nN9AAoJEPU2Bp2uRE+gqyEQAJ2q4w2hvpMocUjmLmg0gSvB
y7XXLXyLEe3D8pr+TpKJMUXCti0Tcw9lw6SndklyXuMDBa6bdSd4tBKRxDaGLECd
OMeaTBPhMc6bUxuTs47IF1h7ExsXtPs0X3oDTtscmdgRjemcl4WgiBuIipWat5KJ
7m/Q5GFe8OVtwGtuHKRRrHoWMhDW2aXFzxfHgHxugnXjYjLBtRyhL8PHSFMZ7xp7
tViyfArIRiiMJ6N+OigyzC7ChfWwiv+PzCy+CXMBhmSYxyymAwQ3DS820jGRRHWA
wEdz9aff5tvCD19NJXcZISozM6RNUKbFuydh6oUvgl3bmo2j+14poQRktdtkQ5DE
t+cV9U0lWyT73IqJbWqrIH198LU3Ngq6+V7qrjTJkyWvixa8oD1NyCiJQNy2Oot8
KLZogGHKbHxKRcBAVSgH6LYkHAEetwSoO9dQ7iUId//9R2fHprTRcO6B01C66JDt
oLnbxqB7HIMumbcn7ZSQZ5mESOKppjGMcAD/+WDPxs8rxcsUE+pab/4p0WxuliAs
mm4hwcbldVZZnnQArQRNYqwDxWhOxkY0S+S57/Sc2bpsBar2oFa2O6vcDHvnSiak
62srjxfdl0YqlysXoAYhgQSdqFZIZVRVSKmRAjZMVd+1O86azTnpwXHW3+pTDBIS
mOSs6GqiUBLOkiVzkE9I
=8JSq
-----END PGP SIGNATURE-----

--5KxTQ9fdN6Op3ksq--
