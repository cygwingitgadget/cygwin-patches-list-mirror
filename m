Return-Path: <cygwin-patches-return-8467-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62480 invoked by alias); 21 Mar 2016 19:52:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62450 invoked by uid 89); 21 Mar 2016 19:52:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:1390, H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 19:52:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B8813A803F7; Mon, 21 Mar 2016 20:52:44 +0100 (CET)
Date: Mon, 21 Mar 2016 19:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/5] Link against libdnsapi to avoid undefined reference
Message-ID: <20160321195244.GJ14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-2-git-send-email-pefoley2@pefoley.com> <20160321192450.GD14892@calimero.vinschen.de> <CAOFdcFP=cJyuiB=dPEqa2XpFV5jmVoepwr0CQ1=2R0j9bA-CHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="07FIeBX8hApXX6Bi"
Content-Disposition: inline
In-Reply-To: <CAOFdcFP=cJyuiB=dPEqa2XpFV5jmVoepwr0CQ1=2R0j9bA-CHA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00173.txt.bz2


--07FIeBX8hApXX6Bi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1368

On Mar 21 15:45, Peter Foley wrote:
> On Mon, Mar 21, 2016 at 3:24 PM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > On Mar 21 13:15, Peter Foley wrote:
> >> /home/peter/cross/src/cygwin/winsup/cygwin/libc/minires-os-if.c:289:
> >> undefined reference to `DnsFree'
> >>
> >> winsup/cygwin/ChangeLog
> >> Makefile.in: Add libdnsapi to DLL_IMPORTS
> >
> > Apart from the fact that this is wrong and DnsFree should be added to
> > autoload.cc instead, what exactly is that patch fixing?  DnsFree isn't
> > used anywhere in Cygwin.
>=20
> This fixes the above link error when building cygwin0.dll as part of a
> cross toolchain.
>=20
> The issue appears to be caused by this change in the mingw headers.
> It probably won't show up for anybody not building against the latest
> git version of mingw untill the next release.
> https://github.com/mirror/mingw-w64/commit/38410a
>=20
> I assume this function should still be added to autoload.cc, rather
> then modifying DLL_IMPORTS.
> I'll take a look at that.

While you're at it, ideally we make ourselves independent of the MingW
header version and use DnsFree directly, replacing DnsRecordListFree
in autoload.cc and libc/minires-os-if.c, no?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--07FIeBX8hApXX6Bi
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8FEMAAoJEPU2Bp2uRE+gORYQAJux/VMZBRd4L0P45NJzkO1K
juF48ZOt/+7M6AW+MZdn5n6zqmjGJn7uIk8JqK90OvtqvPFXTguW3oiSl5Zof9Vl
JDVkoSA0WSKms7a6wx5DosotstLRRLLpRGwSQt483F6Vv1/iohZq6GK7QBPX5EG8
or3TyXC+5VhhBWMLqB1rdW3nDYvWfHk5qyxjDFuCuKXVbNcs4Vci1LWbIDBOZdth
QCOHFHa5A1sRblEI9cOwEC7s574PNTPgdgROOrLOfeQI8BDL6lOKzUauzFur9/TQ
cSQz0C8XHMwoBEKw9/snj1Q7SVoPcr3rg4iWuo2eUpk0iGlGmUGfWinh2WJN+kOc
a1aVGx8W17Uye9csJ4vGAZh1m7uO7Cc65ABgGd+LokCNU5JOLsG5TzAYNUM8ERv/
TjsC4N1g+XAL7x4jvvM1uTQ+BWYvcX7kBCzAjNUp6QLmmhlL4fLa3AqlH0CRktSJ
f2t915pVbIFIXjOgY5H2NDyM7uWXY3Pala5kuaKOBM3D1njEBbE9PgBOc+qlCfPF
kmCgRCXWrsREMQU8sORNDw3P5UNcTbpQLZqmd1fT1U2K8XNF3RcykxDUIEBQdA6I
1Mca0AhGx/yyrB8UgWFJG56/JMeFJ4KHwa4bbmWUA69szKilkJPWaY8apv1rLPHJ
0JEzQWQVxdIHp8/HXcWx
=y4pY
-----END PGP SIGNATURE-----

--07FIeBX8hApXX6Bi--
