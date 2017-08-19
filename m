Return-Path: <cygwin-patches-return-8828-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27118 invoked by alias); 19 Aug 2017 16:37:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27091 invoked by uid 89); 19 Aug 2017 16:37:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=junkies, Hx-languages-length:1459, HTo:U*cygwin-patches, H*c:application
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 19 Aug 2017 16:37:23 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id D533A71AF2C44	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 18:37:20 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 3B04F5E046F	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 18:37:20 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1D06EA806F8; Sat, 19 Aug 2017 18:37:20 +0200 (CEST)
Date: Sat, 19 Aug 2017 17:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Yaakov Selkowitz <yselkowi@redhat.com>
Subject: Re: renameat2
Message-ID: <20170819163720.GA16422@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Yaakov Selkowitz <yselkowi@redhat.com>
References: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu> <20170818151525.GA6314@calimero.vinschen.de> <f7e3cc27-6989-54d8-8e3e-c11cdd5dfeca@cornell.edu> <20170819095707.GE6314@calimero.vinschen.de> <68b3c713-3261-e9d7-0865-384d18553744@cornell.edu> <20170819162828.GF6314@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20170819162828.GF6314@calimero.vinschen.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00030.txt.bz2


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1518

On Aug 19 18:28, Corinna Vinschen wrote:
> On Aug 19 10:29, Ken Brown wrote:
> > Hi Corinna,
> >=20
> > On 8/19/2017 5:57 AM, Corinna Vinschen wrote:
> > > Hi Ken,
> > >=20
> > > On Aug 18 18:24, Ken Brown wrote:
> > > The patch is ok as is, just let me know what you think of the above
> > > minor tweak (and send the revised patch if you agree).
> >=20
> > Yes, I agree.  But can't I also drop the third test (where you said "go=
od
> > catch") for the same reason?  I've done that in the attached.  If I'm w=
rong
> > and I still need that third test, let me know and I'll put it back.
>=20
> Nope, you're right.  Same rules apply for the third test.  Patch pushed.
> Doc changes coming? :)

Oh, one more thing.  This is a question to Yaakov, too.

diff --git a/newlib/libc/include/stdio.h b/newlib/libc/include/stdio.h
index 5d8cb1092..331a1cf07 100644
--- a/newlib/libc/include/stdio.h
+++ b/newlib/libc/include/stdio.h
@@ -384,6 +384,9 @@ int _EXFUN(vdprintf, (int, const char *__restrict, __VA=
LIST)
 #endif
 #if __ATFILE_VISIBLE
 int    _EXFUN(renameat, (int, const char *, int, const char *));
+# ifdef __CYGWIN__
+int    _EXFUN(renameat2, (int, const char *, int, const char *, unsigned i=
nt));
+# endif
 #endif

Does it makes sense to guard the renameat2 prototype more extensively
to cater for standards junkies?  __MISC_VISIBLE, perhaps?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZmGk/AAoJEPU2Bp2uRE+guqkP/jTs01Sw8NlJEl52pcl8mIE0
8lSOlQ0yI/nxKzgCnSNJcheTZCYzvl8wwV+b0fP5LKjVNObGRrvOWTTBp8vydVmA
GEP9UXMTiV6r4iCyvGUUvUYUtGLDkDxsnkFp32t5JoTVhjf3/XBx/Jus9cYeb4Mr
KqtMbzyukcOXK+MuFYSuCjyc5c2UM1/Rnd30rgqSDBOVIe83QGNwQMd3DHzrgoHA
HkPurtBG8XhIbSZ1d79Ycc6s1xp2UESl8TRbSoW9uI0wpgGVt1t1o+a1hWWwm6Py
Bf4h4bjbfHF3FOsh0mNzezFniYFIwdHMCwhk9vKCih+G/b54IqzA1ZFkaMPkLdRs
HKKs2tWGzqQfimG5vfx/eUKqRsQK1K70SSIVzS+PIpM/shDIg33H84W/c/mWetwV
GO7JwiGliwcTJ2EU1BlpL39msKvHhSHy5Csk1RcP3R/uXAdEPiaRwg/eQ55BDYEm
cBvrLgQSoD5VdnCFiwW06oecuFsUl6+/3xSVAb1lj2M3cgvoTyaKMqYEZ19k+jLk
ztqx1az5fAnpaFbD1EkC66uZGMMvnClNgFKtP0OOlZb3eWqrBI2P152VoS2jhE6B
Nc7sxVHrEfu13D3GnePAyYWZDpDy2g4b0pkaRKWH1scm6t0D/nObFL9lMoBX0Gm4
GJUDpX7cVy18YuJ9BgoL
=sBO8
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
