Return-Path: <cygwin-patches-return-9021-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77849 invoked by alias); 24 Jan 2018 10:02:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77710 invoked by uid 89); 24 Jan 2018 10:02:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 24 Jan 2018 10:02:00 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id D347A721E281E	for <cygwin-patches@cygwin.com>; Wed, 24 Jan 2018 11:01:56 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id C35E75E0378	for <cygwin-patches@cygwin.com>; Wed, 24 Jan 2018 11:01:55 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id ADFDDA80549; Wed, 24 Jan 2018 11:01:55 +0100 (CET)
Date: Wed, 24 Jan 2018 10:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Define internal function mythreadname() -- revised
Message-ID: <20180124100155.GC1571@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180124083423.6432-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20180124083423.6432-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2018-q1/txt/msg00029.txt.bz2


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 403

On Jan 24 00:34, Mark Geisert wrote:
>  This new function returns the name of the calling thread; works for both
>  cygthreads and pthreads.  All calls to cygthread::name(/*void*/) replaced
>  by calls to mythreadname(/*void*/).

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlpoWZMACgkQ9TYGna5E
T6CO4g/9GLt891oDVI714Y56lnMtj2SLoexqY+1L30szhYITOtSj8SDiPN+DMvpl
rNBw8zxgd8EruP2Mx2ZMMl0HT3s/ah9SBjSaCjPfoAgiJmPH7/5MLVUskMWc5nwA
qB8kKotZYJqcz2Qo53+l7LCCJG3615boOpQmMx9qTaIqY9nJAFD7Hew9yVvhbmqS
uAXJUO4AZ0nS9Rf+6WgeDLSg3HqOQEQ0QxcOY1jCxiMWa06PDyfXK+MyKKaf3PPT
aA7BQZJMjoztuUZ/RXIJcDpfSvSjs+3NjLZ55UNyl6XMs25/yIFRiyrmM0Enu/Bm
C+eOPtypP7EcjpLBI79S4el+RSavjOtEVllwA8aUdH4ukZwZ4Az5Fc7so5SYDLfe
LeTeEbdaRrTslv8f0K7FtNwN1bjbl355ka0p5AfsqAiMKbfrpSiROPKmUaeO+fvb
n0G8oTSnLFpKeKTTD6EmIElCW2NKkc3SjoObDgc1S6PPOWb9liO7/1AU0ByY2OPE
UscZ/QgwunVdPxt3WdlCvMARfkiozNYohjWDc3uS9AuHDeUtKpRJ4cYiFf9bdiy7
GymcQjesrEHn/GY+SLp056ena4BRx/C1gaMoqplmz8/PiUVFYrR9aQM7TB0wemHM
mCvGEclA6f70pRaXVqKuPzltbYsGF4mmQ5PoqhKdOj9kfSZrLQ4=
=eM6/
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
