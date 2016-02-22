Return-Path: <cygwin-patches-return-8351-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48904 invoked by alias); 22 Feb 2016 16:55:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48876 invoked by uid 89); 22 Feb 2016 16:55:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=HX-Envelope-From:sk:corinna, H*F:U*corinna-cygwin, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Feb 2016 16:55:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 96E65A8035E; Mon, 22 Feb 2016 17:55:40 +0100 (CET)
Date: Mon, 22 Feb 2016 16:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] gprof profiling of multi-threaded Cygwin programs, ver 2
Message-ID: <20160222165540.GC29199@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C820D8.4010203@maxrnd.com> <56CAF4A3.5060806@dronecode.org.uk> <20160222142502.GA26624@calimero.vinschen.de> <56CB33F1.4070805@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <56CB33F1.4070805@dronecode.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00057.txt.bz2


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 878

On Feb 22 16:14, Jon Turney wrote:
> On 22/02/2016 14:25, Corinna Vinschen wrote:
> >On Feb 22 11:44, Jon Turney wrote:
> >>Thanks for this.  A few comments inline.
> >>[...]
> >>On 20/02/2016 08:16, Mark Geisert wrote:
> >>>+      // record profiling samples for other pthreads, if any
> >>>+      cygwin_internal (CW_CYGHEAP_PROFTHR_ALL, profthr_byhandle);
> >>>+
> >>
> >>Hmm.. so why isn't this written as cygheap_profthr_all (profthr_byhandl=
e) ?
> >
> >I asked for it:
> >https://cygwin.com/ml/cygwin-patches/2016-q1/msg00028.html
>=20
> Ok.  I guess I don't understand why it's exported at all in that version =
of
> the patch.

I don't understand the question.  cygheap_profthr_all isn't exported
anymore in v2.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWyz2MAAoJEPU2Bp2uRE+ganQQAJ0LO7G58YF7p6Hx8Crl080G
JkjpQGbLXsaCsE0uXt6V83soQYu7ULJv95fxQQKT9sTPcRWRP9Zl4T0pOhxID1Aj
ZJr4m+40oVvdxRDtKr/RjXcOqYuuCpOGOE6WXokXO+cSsmYKbnjugiwUVAu5Pdxu
Ptj3669G+PAD26M4lMSSjXEOBdp0tNv+FtZCCs1cq7kx4tb2cv+xnkOQ8JR1zewo
gogt6w/0qtT6+vvzKU0eEgzC30W+ZsK0PxT1EFDnQKDXeJ9z86khT3wCuhOPocr7
L5obHi2DiRDwNr/zvzV0GxH780qDWNay4/pCsmSlm4X7yCYfJ9W0LPdzkjhTiozh
ianPMidBz+47N9Dzo+Gtc/rQzL57sX8aL3fqtGoj/di4qqCNmAjb4hBsGBsdd5Ai
8+rAQ2J67PPzM61c7NSLKSA1HOym4X6oZoU1p8LEePa5T52NwPTx8uzmVH/0YiYP
KPBcP+I7tZAZyPpUHsCg5aVfSPzm4aOSfVULMrMN57QBUUIlV6vi3SI0QVSBRTAZ
UrQlBrW9axcTYXKUJX70fe5y7UHHNb6NarjGo2bFIyywjgqWAVWFqpNhcL9CxNXr
JqZE3SPj413VNtcLzs7cviuFTulxynPJQhRRxOQzhEpASTZO3ePR+Yu0FE/S2lLG
LLENl0m1oO2q6bPznxEW
=5aAU
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
