Return-Path: <cygwin-patches-return-8092-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125438 invoked by alias); 31 Mar 2015 18:37:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125423 invoked by uid 89); 31 Mar 2015 18:37:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 31 Mar 2015 18:37:01 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AFEB7A80A3F; Tue, 31 Mar 2015 20:36:58 +0200 (CEST)
Date: Tue, 31 Mar 2015 18:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Rename struct ucontext to struct __mcontext
Message-ID: <20150331183658.GA15852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427824014-19504-1-git-send-email-jon.turney@dronecode.org.uk> <1427824014-19504-2-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <1427824014-19504-2-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00047.txt.bz2


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 504

On Mar 31 18:46, Jon TURNEY wrote:
> 	* include/cygwin/signal.h : Rename struct ucontext to struct
> 	__mcontext.  Remove unused member _internal.  Fix differences from
> 	the Win32 API CONTEXT type.

Patch is ok, except for the __COPY_CONTEXT_SIZE part.  This requires
a change to stay backward compatible which I apply after your patch.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVGulKAAoJEPU2Bp2uRE+gBr0P/R0xEcrCIte2/LfY8AUz4dBl
+NLZxsHSh0unkKoft8LK0nBTwmuXKDOcrSHUKuq/d+pAUFlrCn5qfA3QaVQMsxbD
NpaQ/x4DsVVnEMJTRaFBMdhiJmL5o9FBtmubp3Y8fnbcnpfOGL6rAzpo7spFMacF
PagjzxqJ5N+WinLBIfZtvTpQJyYMXcuPOC/KIyR6+bM9QrvVSR/iM5vN3v/V6hnE
X044q1S/MWuOVwXaGxGpYwifrSqRUzekv7ZLMUEtotVkndg7U1tH4L1RW+RkmQ7e
HNCbOSQFaglrYFa91LazTg5YBCQ1MoVjNQOWjVOrrlAYZCo06yP7swEBghC/AkXk
iQRJOgcRcuh4ZzYbjP9yyUuJ5hvt1i8H4Hwht1a9FTYr5st492Y9+fn9NE+psqoL
uzhnXkE8+1foFY7KPNmnlLhyVNELgpXKgdymhj7+hheKwQpHLxfwXf+w8u/LlPoW
u/HkMR5nCJ3EUQxWq19S6uGIK9DpKW0vJMrdC35+kri+/8YP1bCOmOw7wYHEp3ql
sv623QbLZybnis8QmhlCx0Ik7o9TKfM5xYutH9XVYdXxgP+tVnwxTlxOhKtt3c+w
Fl3ToK74+wxEuj99JRHAXJUFxEYxKcm+PuV1zUz+wXvAvr5OQuMMSq2rfu3vYdn1
r0h9SE6p6ZS4J8QnPgrt
=5J1B
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
