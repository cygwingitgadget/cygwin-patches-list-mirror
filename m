Return-Path: <cygwin-patches-return-8253-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66009 invoked by alias); 21 Oct 2015 08:24:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65919 invoked by uid 89); 21 Oct 2015 08:24:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 21 Oct 2015 08:24:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3D382A807CB; Wed, 21 Oct 2015 10:24:07 +0200 (CEST)
Date: Wed, 21 Oct 2015 08:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: New FAQ entry about permissions since Cygwin 1.7.34
Message-ID: <20151021082407.GD17374@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56143209.6060201@cornell.edu> <20151020192559.GC17374@calimero.vinschen.de> <5626C4CC.3000603@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <5626C4CC.3000603@cornell.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00006.txt.bz2


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 877

On Oct 20 18:48, Ken Brown wrote:
> On 10/20/2015 3:25 PM, Corinna Vinschen wrote:
> >Hi Ken,
> >
> >On Oct  6 16:41, Ken Brown wrote:
> >>There have been several recent threads on the cygwin list stemming from=
 the
> >>permissions change in 1.7.34.  I've pointed people to the FAQ about ssh
> >>public key authentication, which is not the first place where someone w=
ith
> >>this problem is likely to look.  The following patch attempts to remedy
> >>this:
> >
> >Unfortunately it doesn't apply cleanly.  There are weird differences in
> >whitespaces and a patch-breaking line wrap.  Can you check and resend,
> >please?
>=20
> Sorry, my mailer must have messed it up.  Here it is as an attachment.

Thanks, applied.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWJ0unAAoJEPU2Bp2uRE+gIYoQAI1/PW6lhMcQ5zmhQG24WUIQ
zvOPPUS8J1wjTJIIpHgQH0LOlB4nubkrX91p/QBFoo2jjx25OWPg0wu7xOP2wnHN
exFWzsg/Qhg1aDJ8fzFUSyEYofZYDv1Fi3rbMnR/4d3jfN3/jRjSUle+VWKxp9Ij
AizS/A2dRoIUa/7utwSRvb2uw3arhGS0ijVn68zlHHu4KFQWCtEu2ZAKcFCss+jr
g4fRSYrmlV9B4xBk15YptzeIipp/de/v6IRChPPigOGA9pKGn/BQ6IzoqwMwYs1n
mrkmRHg2EfanT6u6tZZdpTuKo+wS5DPCLPZ53U+NS/UrYXdCgkbz83JkYllEG/O3
luf/ALIWEW7uTjuOjGaHVSfYtJR0tRxDtr8H2yzOTVTgT5M8LorZBQjtRUQRsPwD
2x1kSaFDmKisl8hlTlL9KNAXVCl9BpLrZm1w6hyA/UzUQqj4cybMKH3YSr/d4ILU
SohV6TKv9GJZyghZVfOsbUQHfxrC8UB0XvksTOfiHTbmFFYs3ny74ltTJqinKfZ7
wGJi7Uhlwqsn9RGwQ4Hp9nwVXu3n0jUgpkB8k81VGHcWcwry5Xv1XiqPxBQoIXHv
EnZ5YEs/IMnD/JedAOBbWfzXaqtKexprsfk4X3QvNB9n7Tr4XDTKOX0ozFsqKJ79
YeQI4syXkRBrgb4tT5a4
=MxvL
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
