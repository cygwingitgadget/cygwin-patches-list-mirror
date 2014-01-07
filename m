Return-Path: <cygwin-patches-return-7929-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11127 invoked by alias); 7 Jan 2014 15:08:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11111 invoked by uid 89); 7 Jan 2014 15:08:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.3 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Jan 2014 15:08:23 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 985721A0C27; Tue,  7 Jan 2014 16:08:20 +0100 (CET)
Date: Tue, 07 Jan 2014 15:08:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix potentially uninitialized variable p
Message-ID: <20140107150820.GH2440@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAOYw7dvP64FFXUJS60ixUqj2jr01Dzf3YrchyR79m7AQEb8TKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline
In-Reply-To: <CAOYw7dvP64FFXUJS60ixUqj2jr01Dzf3YrchyR79m7AQEb8TKA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2014-q1/txt/msg00002.txt.bz2


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 336

On Dec 22 00:40, Ray Donnelly wrote:
> [PATCH 2/3] * winsup/cygwin/strace.cc (strace::vsprntf): Fix potentially =
uninitialized variable p

p is never uninitialized in this code.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJSzBhkAAoJEPU2Bp2uRE+gp8cP/0xwxNFOFF7TVdILQn0khCzU
bA2fPclVr1xF/WY6c5nS+v4CgmxCTsesRWwfCNuwK64dWxiPmd0Sexme784IwYQ6
tdft66OMXX8BwkH626a3664OnhGrCh+U8BhMfLP2JOPgV55jMgLeHMFYr6hGWKPU
7Y+L83pMdgylG+nzFl3OxLoASUvoE8w7X1Pc6vY+8IWr1nW7h/VWOG5gOJT4AfjM
jA+GKL7CRaQKMyqYOVujMyPQ8Kfxd0ZYAJN/5RAFdaZLOoV+bJXpFcY52Y2OrZPy
k6IhYXifIuYcl5+rhfygOm+JAGZhAdiOdMqkn9B7CJtdDbt+zqyAkqzUCEIV4K6S
s6RUMK80mXbQbZuaZOQeQh6f+/aDf7ZLPPr+wgYqFf45gQKREqwUPqVKDV8/IaK5
w08JDj4lQ5boff12QPPe4uoMtUFaeevN8TZ4gicBMxJn4UBUUqxaLzJiAsawCQeF
S5X8QUt9G74FAs3qy+9gl0fbWFFCukRQgx0cEYKdqTdxCXE3ZtRv/s6IiLyx0rLA
4rRpB0YOw1Fh0A2s8PbvUZmN6Dfqa8do3e4aUndwCaJ/XdcTIYi6Vz4+R2Kd8Wz4
36lRFhSoAj9FEiWJG5Y45xqZz9+7dMvO3oE6rjUxi0dkv9oxcHePgQf+p9W0frJ4
ptC/VfK2xDuA2THZMtwm
=ssK5
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
