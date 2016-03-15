Return-Path: <cygwin-patches-return-8405-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81252 invoked by alias); 15 Mar 2016 11:46:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81211 invoked by uid 89); 15 Mar 2016 11:46:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=HX-Envelope-From:sk:corinna, H*R:U*cygwin-patches, H*R:D*cygwin.com, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 15 Mar 2016 11:46:19 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 18027A803FC; Tue, 15 Mar 2016 12:46:17 +0100 (CET)
Date: Tue, 15 Mar 2016 11:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: define byteswap.h inlines as macros
Message-ID: <20160315114617.GC7819@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458011636-8548-1-git-send-email-yselkowi@redhat.com> <CAKw7uVg7QZyVJCO0miU1HXwn6PF-8yxSwzMn7s_t6CkUb2ts5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <CAKw7uVg7QZyVJCO0miU1HXwn6PF-8yxSwzMn7s_t6CkUb2ts5w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00111.txt.bz2


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2265

On Mar 15 11:55, V=C3=A1clav Haisman wrote:
> On 15 March 2016 at 04:13, Yaakov Selkowitz <yselkowi@redhat.com> wrote:
> > The bswap_* "functions" are macros in glibc, so they may be tested for
> > by the preprocessor (e.g. #ifdef bswap_16).
> >
> > Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> > ---
> >  winsup/cygwin/include/byteswap.h | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/winsup/cygwin/include/byteswap.h b/winsup/cygwin/include/b=
yteswap.h
> > index cd5a726..9f73c5a 100644
> > --- a/winsup/cygwin/include/byteswap.h
> > +++ b/winsup/cygwin/include/byteswap.h
> > @@ -16,23 +16,27 @@ extern "C" {
> >  #endif
> >
> >  static __inline unsigned short
> > -bswap_16 (unsigned short __x)
> > +__bswap_16 (unsigned short __x)
> >  {
> >    return (__x >> 8) | (__x << 8);
> >  }
> >
> >  static __inline unsigned int
> > -bswap_32 (unsigned int __x)
> > +__bswap_32 (unsigned int __x)
> >  {
> > -  return (bswap_16 (__x & 0xffff) << 16) | (bswap_16 (__x >> 16));
> > +  return (__bswap_16 (__x & 0xffff) << 16) | (__bswap_16 (__x >> 16));
> >  }
> >
> >  static __inline unsigned long long
> > -bswap_64 (unsigned long long __x)
> > +__bswap_64 (unsigned long long __x)
> >  {
> > -  return (((unsigned long long) bswap_32 (__x & 0xffffffffull)) << 32)=
 | (bswap_32 (__x >> 32));
> > +  return (((unsigned long long) __bswap_32 (__x & 0xffffffffull)) << 3=
2) | (__bswap_32 (__x >> 32));
> >  }
> >
> > +#define bswap_16(x) __bswap_16(x)
> > +#define bswap_32(x) __bswap_32(x)
> > +#define bswap_64(x) __bswap_64(x)
> > +
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > --
> > 2.7.0
> >
>=20
> Would it not be better to leave the original functions as they were
> and simply use these defines?
>=20
> #define bswap_16 bswap_16
> #define bswap_32 bswap_32
> #define bswap_64 bswap_64
>=20
> I believe this is valid C and C++. Untested.

Yes, that would work.  Glibc defines the inlined functions with leading
underscores as well, though.  Maybe we should do the same because some
strange application wants to use the underscored versions?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW5/YIAAoJEPU2Bp2uRE+gucAP/jFXzZtOpABXklFB/75jTs3w
NlPkEw9fv0+HFLisgrAwJdS7E5ZpjEN3Cpz3kDviKXIb0VR4KIrbYJ2f28G3jJop
35zwORtYoV9pMNJuCPdV5InRUB7bUQxT04fHb/AViNvPc+PbTqZq+b4kZ2J5IYz1
AfeCPgPHGjirN8HWjkgdfmPuITyONYx9s0w2j5CJeklcdK0Z7vPMXvxxb3HqQ+fg
rS+kw++jp33PEp2KlxKeFfXBekj2PKNB/o0VYLm4jKrPT+BBHV9lVQrd0heKIem8
qbuBPL0hxEL/NtXN8oYrNsfLC5tvwme8TXfcOuq+mpszwuBbew2znWMZWzpd7IRj
ks4hXgs0wq2CxlOFr5JUH24woKBOabPlvLLQ/lHooGMBni6FEDzeany9Ch1KtaHi
7MUFAC1+d0xjx5jhEvJq1STn07WG8+xCq10ePUOL5RpX1dkIE4WE7hshLIngxdpu
jrKiX/EsP2TzzjH1gxV5yFTngxHn5739nhKhqoJNRDNI6eIJCDjt97KNf5q675JF
qOU/aKJohK1HOaC9e6P7AMN9gu0xw6y4xttgntLjh18KozRICXEzDd0rD4vBEqxi
ZvQgSgju3oys26now3c4Sdri0oFc94PFoAdIqWiZcUsWVQRTeCRxVNp9eUHkhgcb
rtpoVKLH++Ea7ae/saAt
=RGzl
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
