Return-Path: <cygwin-patches-return-8870-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19641 invoked by alias); 9 Oct 2017 10:11:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19602 invoked by uid 89); 9 Oct 2017 10:11:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-104.7 required=5.0 tests=AWL,BAYES_20,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*c:application, mails, Ken, Hx-languages-length:476
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Oct 2017 10:11:52 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id B72E5721BBD2E	for <cygwin-patches@cygwin.com>; Mon,  9 Oct 2017 12:11:48 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id DF2815E01D9	for <cygwin-patches@cygwin.com>; Mon,  9 Oct 2017 12:11:47 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CA171A80666; Mon,  9 Oct 2017 12:11:47 +0200 (CEST)
Date: Mon, 09 Oct 2017 10:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 01/12] cygwin: Remove comparisons of 'this' to 'NULL' in fhandler_dsp.cc
Message-ID: <20171009101147.GB3542@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170917020420.10488-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20170917020420.10488-1-kbrown@cornell.edu>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00000.txt.bz2


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 433

Hi Ken,

On Sep 16 22:04, Ken Brown wrote:
> Fix all callers.
> ---
>  winsup/cygwin/fhandler_dsp.cc | 55 +++++++++++++++++++++++++++++++------=
------
>  1 file changed, 40 insertions(+), 15 deletions(-)

Excellent, thanks for your hard work on this!  Series pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ20tjAAoJEPU2Bp2uRE+gDLIP/A+LB/MiLViK0KEToBtkLkLq
zs+xDnj1gW0fIRIedXWEJb6CcLBNM10vDcWLgwplMPbhQVHT1J51hJQvPPkG2fA0
kKa/X+G12B/2uQOy1cSYwNOXWyvpVRzoCV6GbzWbj3xX+gHgz1nT7MTWoOCvWmZB
Zkk93xbq/fhZWwLN8NJQArwOSMI2QOFibTtfhdgezLJ4AkHUiv8a/F+Y/ruN/c1+
cIRrML7cabhMQ55AmpS4fveCYRtogYZlzEKypQViaSiRnwN4W6bXaQbljLK0cFUO
cHEc69O0p+pb79Fvcs5+eBGOjOITGNF5/gEeaoDqeOjJ3dv4Mmncckj7cqB7av52
RzMK/SApM/Gvw/65Y6xlEufAN2xOi9Y4ntym4jL+FGvEh6fhx6Z0nNE48Hej/Xg7
Vde6bEmVYxD0pgd7FJauwC8B0D4DBIycS16UoW4YeStscQpsoIQTSX8Ztw9STqxL
3KWrAsDa0j9uMVkvIXLDFoQclAEGvpvjNA/YiXGLPT6tpMRqSWMU0MOEOzpWPPpx
GY47Qk/3yZ81SDERX1zawlwOA3fgBhMGtywoCV8Vjl5hmPB5y/LImbunSy1Dhx3U
z/lPRH8mrrcznuV+Ktk48jJqgeO3zpV70C5sAKRC2t1APjI+FxB6h516LV9kQMaQ
qtQ88nloi3eywtIzFKz+
=aic3
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
