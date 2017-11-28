Return-Path: <cygwin-patches-return-8934-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 69289 invoked by alias); 28 Nov 2017 09:32:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 69189 invoked by uid 89); 28 Nov 2017 09:32:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-119.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*R:U*cygwin-patches, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Nov 2017 09:32:44 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 03878721E281E	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 10:32:41 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id A40A75E0418	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 10:32:37 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 13BB1A8072C; Tue, 28 Nov 2017 10:32:40 +0100 (CET)
Date: Tue, 28 Nov 2017 09:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
Message-ID: <20171128093240.GO547@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
In-Reply-To: <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00064.txt.bz2


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1705

On Nov 28 00:03, Mark Geisert wrote:
> Mark Geisert wrote:
> > ---
> >  winsup/cygwin/fhandler_disk_file.cc | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandl=
er_disk_file.cc
> > index 5dfcae4d9..2ead9948c 100644
> [...]
>=20
> Oops, I neglected to include an explanatory comment. Issuing simultaneous
> pwrite(s) on one file descriptor from multiple threads, as one might do i=
n a
> forthcoming POSIX aio implementation, sometimes results in garbage status=
 in
> the IO_STATUS_BLOCK on return from NtWriteFile(). Zeroing beforehand made
> the issue go away.
>=20
> This is mildly concerning to me because there are many other uses of
> IO_STATUS_BLOCK in the Cygwin DLL that haven't seemed to have needed
> initialization.
>=20
> Puzzledly,

Ok, let's start with, why did you tweak pread if you only observed
a problem in pwrite?  In terms of pread, we already have a very recent
patch series:

https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D46702f=
92ea49
https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3Dc983aa=
48798d
https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D181fe5=
d2edac

In this case it turned out that the problem was related to hitting EOF.
I wonder if we hit a similar problem here.

Two points:

- Did you check the status code returned by NtWriteFile?  Not all non-0
  status codes fail the !NT_SUCCESS (status) test.

- Do you have a simple, self-contained testcase?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaHS03AAoJEPU2Bp2uRE+gINoP/1HbFLEmMLdT8Tul7R469hkC
zmk4bnOLuBBphRgr+Tg/EN5FUouYE9dEzOkXHYau7A7P8IbgJQ6+RSw5O+R6XZDE
0dF4BCOupFGJgvO4flRnsnsibWQEybc/0zR7m6rX7IHNCnVpfjqjRKoAVZW0cxzp
vXFdy99Ugm8Z1mBjidV6XGn+ZA9AdKb2VSyNbSNaVI9s7UcqNqV3xtiKf5o4Kfnb
x9jK0nShNEX/hGFsaTMGWlToAfjdtaEtnkUBfKd2oYKa3KwtELCcpx8CaaYK810j
nweFCgnGVqrAU0VUc680v3D0jY6SSl/5Ifg3SSnk4z/d4uypYYHncL06O1/b895s
SNBqvq+oxm0fwQJDcP7uZiH/9Kv57qlMcQDcVVj25lX7bXqRE3I7CTdpstZ4y1f6
eGmJbUi883DC/ffcEMnGjs9D9XqQLXl79Ns0/HhNqd7P+VDMrxd0D0awj7hKDcY1
/az83o7sIbMfzCWi8RFEgZ/Ll8abMWcVxFlGIkQUI2YavCaqkp78WTO3dKuoaMd6
GWhp7jcniFRnRNrTiicrahqLUCBihjBetw1xfp+xAlCi5M8fozDPPeqcdsrmzHlg
R8dlQWnIPl+g13C+GI09N1GHRfbHqScAy/yLeUeZ3MZVgD3tVPdA5AHhhIw8eNiV
56QrojxdUUuuTFX7h0lv
=OeAq
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
