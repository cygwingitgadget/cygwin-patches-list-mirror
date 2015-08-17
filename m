Return-Path: <cygwin-patches-return-8235-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38930 invoked by alias); 17 Aug 2015 07:59:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 38919 invoked by uid 89); 17 Aug 2015 07:59:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 17 Aug 2015 07:59:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 59499A80930; Mon, 17 Aug 2015 09:59:54 +0200 (CEST)
Date: Mon, 17 Aug 2015 07:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] mkglobals: Fix EOL detection
Message-ID: <20150817075954.GB25127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAGHpTBLBua-DJQ1tBapYd_6ypdWGMW+ehAq4r7k_TA44Tn_Oxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <CAGHpTBLBua-DJQ1tBapYd_6ypdWGMW+ehAq4r7k_TA44Tn_Oxg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q3/txt/msg00017.txt.bz2


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 447

On Aug 17 10:41, Orgad Shaneh wrote:
> When globals.cc has CRLF line endings, winsup.h is not removed, and
> compilation fails for duplicate definitions.

Why on earth should globals.h get CRLF line endings?  It's stored
with LF line endings in git.  There's no reason to convert the file.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV0ZR6AAoJEPU2Bp2uRE+gowYP/ifz/X4jcA+VQYXwZukNk/0Q
FtfUN+btDQGQoEQtZeFel0ajp3SigDCj15zZUr1s8WyrEr0+zrGjLidmFMcyJrKJ
RHSUKbb6ZtprVsWypmfJXADLGyI47YHNOZPv5yggtW3ZIcv7uA59Qs0PH9njvR9Q
txRkk/jzY1ULm0IRW7lveMlaejoy+C6ze56zGXhx7U8DD6KfXCbQpge9Dsy85zyJ
qWtXSEm3Ro04px7QJHVvY1tLkPJ4ETnP7+LPYvM5xqURyFCI/vqfUFhYTK7UwPFW
pltS2W1w1LIJ8kSC191LK4RIiZinRCC3p27cLlFRoko14nklFTxHs2Zf57SbR0UH
WFO70qN368OTMjxjjSCfrGDLv3WyyXtsegLG/x8+yX7dUVLkmAonyHsJK63gnzjg
lGS25ZPk0HJwjjtqQkQidP06VArZzCsoQKRnSKPy/SpUux46EZSTCcqBAAZ3SsF3
l8zW2JUwxLx3g4GhasXhu/Dv02CYoXJFmodf0VzVO2nXEzNYvWODXZDz0BoVS/fp
SnLtYw4hEBFj1IKjo8YVLgVXZllUepiOJk4Wd6aUoNJXMDfFZazINnKn0DCawb75
Rw5g95mKrdDqhm4gA2f6fqGhbL8BT+5va6xLGcv+NsQf4R7VEdvkkQLHvi3qbm5d
xWgnJ/M735QrUMIvNaz+
=cEnN
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
