Return-Path: <cygwin-patches-return-9110-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62532 invoked by alias); 4 Jul 2018 14:52:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61668 invoked by uid 89); 4 Jul 2018 14:52:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=Hx-languages-length:1409
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Jul 2018 14:52:51 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MSao8-1fiO7241Ia-00Ray3 for <cygwin-patches@cygwin.com>; Wed, 04 Jul 2018 16:52:49 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D0C46A818EF; Wed,  4 Jul 2018 16:52:47 +0200 (CEST)
Date: Wed, 04 Jul 2018 14:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Why /dev/kmsg was deleted from cygwin1.dll in git?
Message-ID: <20180704145247.GS3111@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180704044424.813ee03eff360d6bcb58446b@nifty.ne.jp> <20180704105420.GN3111@calimero.vinschen.de> <20180704220138.26b42dc96fb1b49a9dc693d2@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="h9WqFG8zn/Mwlkpe"
Content-Disposition: inline
In-Reply-To: <20180704220138.26b42dc96fb1b49a9dc693d2@nifty.ne.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00005.txt.bz2


--h9WqFG8zn/Mwlkpe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1411

On Jul  4 22:01, Takashi Yano wrote:
> Hi Corinna,
>=20
> On Wed, 4 Jul 2018 12:54:20 +0200
> Corinna Vinschen wrote:
> > On Jul  4 04:44, Takashi Yano wrote:
> > > Why was /dev/kmsg deleted from cygwin1.dll in git?
> > > Due to this change, syslogd in inetutils package no longer works.
> >=20
> > /dev/kmsg doesn't really give any useful information.  It was never used
> > for more than some exception information, but it required a complete
> > fhandler class on its own.  I wanted to get rid of the useless code.
>=20
> I looked into this problem and I realized that the real cause is not the =
absence of /dev/kmsg but old codes in the connect_syslogd() function in
> syslog.cc.
>=20
> I removed these codes and confirmed that syslogd works again.

Hang on.  /dev/kmsg was implemented using a mailslot and it was never
accessible via the syslog(3) interface.  The code you removed has
nothing to do with /dev/kmsg.

What the code does is to check if we have a listener on the /dev/msg UDP
socket, otherwise log data may get lost or, IIRC, the syslog call may
even hang.  So removing this code sounds like a bad idea.

Can you please explain *why* removing this code helps and what happens
if syslogd is not running after removing the code?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--h9WqFG8zn/Mwlkpe
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAls83z8ACgkQ9TYGna5E
T6AYIhAAmLDQie7hC7OdpzbMApMzvaWryeTEkQjvXS0Xb4QpG0toeMykjug7ufxP
4DbDfRMY+0avmVjOnr/5XvxldTlX49zjMKkit04Fck0r3N5MXAUJKKP6jEx8qylD
dq+iR9PsZcbm1+j0D++okPzB/F4Ho9kjcGRtBdD4o6XybY2A8cLqltJ6Av4Xrguk
xfZFdKLILAHDv+wJndnCJFQlOvaYjzhN9AOhi3OI1rz46j2ov0w790/7AluISUmT
QYHob+HlpeqHOZXw11Upna/mLL3yFBYRxA6w2AIDMnOr/y16AUGE1HUDS+t0CP2L
vIIeaU7cTomh1u7nn2+pIDBZ8v2xOKhHxFn6NAlQdC5dCvxs/MB/3H1r2ynCOZ3D
lIec2oZVmgGgkl1lqfdIE8hNfvFzAzv/IrKbXMeDwoScb/pkALcDzm+TjcpbRBa5
2/ecC8cdl690v8C7y5QtN184L+wFWNv0xsr5sD8kbugvnJ/s1F04UjZiSxz2GdKu
QfaYr2v1QUzkM+YLxQglxwHHT9RcPldaVKCA4Hasxy2spudRj+De1yN2hFHO5Ary
uQTI/16d8fOypxh1VrQCqRolFa7ZYrlPEuG8OoXQw8ydqCUcUV0Bto//AQ8QflrC
txZt9owPe9ph524OHMLGMxbP9cfFaeXm96S0LHsOyYAOXGm3BTM=
=7Gmw
-----END PGP SIGNATURE-----

--h9WqFG8zn/Mwlkpe--
