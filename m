Return-Path: <cygwin-patches-return-8349-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21713 invoked by alias); 22 Feb 2016 14:25:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21696 invoked by uid 89); 22 Feb 2016 14:25:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=HX-Envelope-From:sk:corinna, H*F:U*corinna-cygwin, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Feb 2016 14:25:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 19243A8035E; Mon, 22 Feb 2016 15:25:02 +0100 (CET)
Date: Mon, 22 Feb 2016 14:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] gprof profiling of multi-threaded Cygwin programs, ver 2
Message-ID: <20160222142502.GA26624@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C820D8.4010203@maxrnd.com> <56CAF4A3.5060806@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <56CAF4A3.5060806@dronecode.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00055.txt.bz2


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 587

On Feb 22 11:44, Jon Turney wrote:
> Thanks for this.  A few comments inline.
> [...]
> On 20/02/2016 08:16, Mark Geisert wrote:
> >+      // record profiling samples for other pthreads, if any
> >+      cygwin_internal (CW_CYGHEAP_PROFTHR_ALL, profthr_byhandle);
> >+
>=20
> Hmm.. so why isn't this written as cygheap_profthr_all (profthr_byhandle)=
 ?

I asked for it:
https://cygwin.com/ml/cygwin-patches/2016-q1/msg00028.html


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWyxo9AAoJEPU2Bp2uRE+g9tAP/3j+O2spQUrTyDG0yY4XWNES
CD9CCylWJN6gASVkYTNzFyVk13qZguXyLbVRMggOz/139bzGKEjmFQ3iBX9DoU9u
lKT7AWW9/rPlMqpzJYSewgBPzi9WL42pKbZxJoi5KHSQr8FwNlHSyh1JyjNaV0k/
2c5IXaReTr/1eKZpQgl2Hw3mDXz10+xt7PoCUENi+RcfJPmu1AqD+oiQgvtWWhja
4+vPJQP0TQpm35IBqwraH2eYQLFTDFIxoaNKcyZimZC+wFJNoxAvEXbaqJloKji4
ZFB6TrA5zGFdFfSq0LFJMox9pDDu/ZBTIV/ExmCn+HsF/N8QnlA7kh//yP6h2BGx
hvtNUp1c/dmY2WnAB0xz6MQu2vWsQshYX59LRwRROd/CzgLTMggdpyaIJJ8bkJMd
EKsx9DVHrFo9SxRgoCwVWnkBG8yxDvQj5iwrm+/zOYCvS6dfxNLmlgTvyXxXsEmX
gw+T/dPCRnyGTv6hW/x0fW53lO2qMwhc4vLmFAdIQ6nuNW0SPwkZhEg3dlJjtV5e
T7MaMH8RTceXLSN59TJCEZKFFL8algR8op9z9leqeu46LX89YtiPOs/8i+begdg3
ggWXD4TxbuIZeP+bcEpI+Ml6MSPJJCo31hDqS4o4XN9XA/06fX42cg14ngA4+D6u
FkIhsg6OsPiNgI43FlR+
=5dUz
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
