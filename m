Return-Path: <cygwin-patches-return-8477-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 97037 invoked by alias); 21 Mar 2016 20:34:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 97022 invoked by uid 89); 21 Mar 2016 20:34:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 20:34:39 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 340A5A803F7; Mon, 21 Mar 2016 21:34:37 +0100 (CET)
Date: Mon, 21 Mar 2016 20:34:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/5] Link against libdnsapi to avoid undefined reference
Message-ID: <20160321203437.GN14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-2-git-send-email-pefoley2@pefoley.com> <20160321192450.GD14892@calimero.vinschen.de> <CAOFdcFP=cJyuiB=dPEqa2XpFV5jmVoepwr0CQ1=2R0j9bA-CHA@mail.gmail.com> <20160321195244.GJ14892@calimero.vinschen.de> <CAOFdcFMbLNOXCNcMYexqqUWa5GS4CyiSgrcjPHuUr7dnnR_ifg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="XBg9NAhDNArbJUtw"
Content-Disposition: inline
In-Reply-To: <CAOFdcFMbLNOXCNcMYexqqUWa5GS4CyiSgrcjPHuUr7dnnR_ifg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00183.txt.bz2


--XBg9NAhDNArbJUtw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 904

On Mar 21 16:19, Peter Foley wrote:
> On Mon, Mar 21, 2016 at 3:52 PM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > While you're at it, ideally we make ourselves independent of the MingW
> > header version and use DnsFree directly, replacing DnsRecordListFree
> > in autoload.cc and libc/minires-os-if.c, no?
>=20
> Hmm, it isn't immediately obvious as to the meaning of the 2nd (n)
> parameter to LoadDLLfunc()
> How would I go about finding the correct value for the DnsFree function?
> Function documentation is at
> https://msdn.microsoft.com/en-us/library/windows/desktop/ms682011(v=3Dvs.=
85).aspx

Number of arguments multiplied by 4.  That's just for the 32 bit
WINAPI.  LoadDLLfunc (DnsFree, 8, dnsapi) should do it.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--XBg9NAhDNArbJUtw
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8FrdAAoJEPU2Bp2uRE+gxsQP/1MQiXv4InbaY8kBoZplbt8h
N5npd5eZPtC4/naCXg62TO6pPOtHwynD/OJbvQeZIasGPSiqc+b4csDnret9bGUK
5yM50+5Xp6YTuSNi+eW3k5SYL6i4QNQA1vULQIprwz9L2Agn42qbphdcsTIItzqT
UwDTjzDhBJuN+Atsi51dGY7gSAH/3iYYAY8VdktahQi1EBw0VDu8rsgQHwCfD4qb
jc1w9A5GrCfYtQxSwsyknmoy4nmkTm6OhJQ4G2B7/EpK20ZAx9SGdFtGHbILtm+8
yWG6IUa13nECDQdxJFvyzF6JGJLn4wK5gU/+yTMMcKwyhzGoAFMzxRyH0sF7Syv5
fv5p+4Ttkl1qMOCJJBrpTpx0p4+o0JG45P49Xow/eIzb57gckj4etAiP++LwNwIV
9h8iesA1fZc+oE4h8V1NJjMu5a9HNEfN9cUCPJaMvNDIbFQuDOLmRm8tafK2Pm0w
GPLFKidyrXEZhfwcCNS6eqbnTNFF8kJM5TZmX1h+BXf1QmW7PHXGw4iVMpuy9pMA
QF5IQKQm3ELCef52uHK3BMzJ7QS33KzC1ZGF92/fg2ZeCx6CI36rSOfUuZJTs4Ww
gco1vLUxghC/ToerYl507bSQVNN+1EUyajcGzBHLFbyyA/4ZP5GVs6kgQkLFeU12
FBe+hog5Osn83gSG2sPK
=yzqX
-----END PGP SIGNATURE-----

--XBg9NAhDNArbJUtw--
