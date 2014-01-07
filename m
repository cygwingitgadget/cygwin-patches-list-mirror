Return-Path: <cygwin-patches-return-7930-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16571 invoked by alias); 7 Jan 2014 15:12:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16560 invoked by uid 89); 7 Jan 2014 15:12:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.3 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Jan 2014 15:12:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4C9441A0C27; Tue,  7 Jan 2014 16:12:49 +0100 (CET)
Date: Tue, 07 Jan 2014 15:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Reattach trailing dirsep on existing directories too.
Message-ID: <20140107151249.GI2440@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAOYw7duMgGSfpxa4OtOPRhY5Mw6q=__shhJxELZ53Ez9_WETRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Content-Disposition: inline
In-Reply-To: <CAOYw7duMgGSfpxa4OtOPRhY5Mw6q=__shhJxELZ53Ez9_WETRQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2014-q1/txt/msg00003.txt.bz2


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 569

On Dec 22 01:03, Ray Donnelly wrote:
> I hope this is OK and I've done it in the best place. Please advise if
> it needs any changes.

I have no idea if this is ok.  This is a patch to a very crucial
function in terms of path handling, and it's not clear that this isn't
doing the wrong thing.  What is this patch trying to accomplish?  Do you
have example user space code which is failing for this very reason?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJSzBlxAAoJEPU2Bp2uRE+g5AoP/jz/j3uXmTK3GYXKmorGg9cw
4FlGVRgljDQkwa9GB5wwrJS5G9KkbE10IDi3UPGMPEJOPW4UXwNP0poe7kBT60wK
0/FLNpmTr4DTLK7Ihy6HdRdMGW7vjOoMefLUyXpydMFhNyhK9VwcoHxMGsaMsuf0
10cxuJTB7egDaJVhrhDW5OW4aQEP/mWAPU1EljC4sD2lVVSdOcfSw0UYnBoPxhwV
JLi8u+tqQMMvuL/FP15AkVsV8410M540/HrclJ3sQYt+yUg/Zuy3XMb4wH6AZr4P
gO93dfljv62q+ilNpgIX6tY+tJkDzBoGQv2hvT2O42i9MoEalomZVYqstPlIJB++
ijigaFjC22+nZkiLEwRPB8T+MzmlBGWYcyqfC6oKUs5fNCsZGI1PIKQ+4bxh6wIv
AR46e+fG+3sP9c4LW/968bfX/FAKYnbN0rorOkG7RpYtfnB7mpsha1DESJBm08Lb
4dY0r+mM5XGxssUr8D1u6DyQZGVsEqp0IAWlLBnMRr2rQ0Jn3qLwEgiLzpHUbROI
7lgIXU7zFKgioLW1HVkZaSoHJ2XRMTazb/mAm+gHdHzV5J4nURztqpXS/31SGO3X
zkKWgzJ3i+QfO7pBsBJaNfgcNcQTxeXnkzVSIc6HClynLQi3NcwOnKV+0Y7ySUFd
WFSMnsZ8w0qzYdK/hDmk
=aHfr
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--
