Return-Path: <cygwin-patches-return-8535-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104043 invoked by alias); 1 Apr 2016 15:10:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104032 invoked by uid 89); 1 Apr 2016 15:10:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Apr 2016 15:10:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 402F5A8060E; Fri,  1 Apr 2016 17:10:40 +0200 (CEST)
Date: Fri, 01 Apr 2016 15:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Refactor to avoid nonnull checks on "this" pointer.
Message-ID: <20160401151040.GG16660@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459441102-19941-1-git-send-email-pefoley2@pefoley.com> <20160401121318.GA16660@calimero.vinschen.de> <56FE73D7.8030306@cygwin.com> <CAOFdcFN0+eH76u6A0Z=gsyE8iEtzQFUTjyheQYzRk5Hfst_s=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Content-Disposition: inline
In-Reply-To: <CAOFdcFN0+eH76u6A0Z=gsyE8iEtzQFUTjyheQYzRk5Hfst_s=Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00010.txt.bz2


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 654

On Apr  1 09:34, Peter Foley wrote:
> On Fri, Apr 1, 2016 at 9:12 AM, Yaakov Selkowitz <yselkowitz@cygwin.com> =
wrote:
> > See https://gcc.gnu.org/gcc-6/porting_to.html, section named "Optimizat=
ions
> > remove null pointer checks for this".
>=20
> If there's an better way to do this, I'm all ears.

As I mentioned in my first reply, I'd prefer if the callers check the
pointer explicitly.  Changing the methods to static methods seems ...
wrong.  Ugly, if you don't mind me saying so.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/o9wAAoJEPU2Bp2uRE+gBIYQAJ2OudCbGH/MRsMVnLFvsNXD
ueBz+xeV3LuNO5OFfYqkwNYsFWndGKZJs1oDlJ3ud5DyyzuNN/99Jf0mMb9yK8Td
ZQnvPycWI4Dor2zr33UC2pWMhgH1gMGCWYaoQxxCTyov1ssBEgpNbuDUpV32JuLc
U28ppnTpX0XxvpfVlksg/tJ9lfS7joDtAOaf2Q8rfB90uwEAAiJy8jNin1Fducgo
NAb+7H0zQvXXTadzGZcwYizRcyJ6EPGwCwxsMcEpeGs5hQYTj6KHDPaaLwbr5cWC
SfZj91fWWMzCZpzsF0dvAeIPbkBqoeqGJGDeCQz2gpbHVg8dwhCyj0TtEieaobE+
ETcXkv9Xt8LZO4SZouhfRmDtFuaDQkmJPe9ktlOxv9aVpfgWfh1xKjTs2NMHENRy
hHQLqvPiqDrljElJ4VqESEhUmUqpeOsxhUnNIuVd8oSugBCT0RfR3ElEKiBt4uim
pjvdYii0VkFqW97HFRv6ez6Klmimuc7tq0e1teJ0TsR62PKdStl7zTW6buE9x4iG
omF6EcfH7dJzgwTcLO79oIPV+BcZ8xa4p7R7BITZErME9c6pdSp5bl3M15ouPcqi
oFBhglVv9SOvy/Bvh7DQmkGjZ7oyuEaXeVHgJRcG8v9geAkJUNNQ2X/xzJvjGhyZ
VUXJadVOJoxnYJsdWGbD
=xy0k
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--
