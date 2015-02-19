Return-Path: <cygwin-patches-return-8060-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22387 invoked by alias); 19 Feb 2015 13:29:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22340 invoked by uid 89); 19 Feb 2015 13:29:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Feb 2015 13:29:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 24E89A80BED; Thu, 19 Feb 2015 14:29:54 +0100 (CET)
Date: Thu, 19 Feb 2015 13:29:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Compile sigfe.s with CFLAGS
Message-ID: <20150219132954.GI26084@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <54E5E36E.7060407@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Content-Disposition: inline
In-Reply-To: <54E5E36E.7060407@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00015.txt.bz2


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 255

On Feb 19 13:21, Jon TURNEY wrote:
> 	* Makefile.in (sigfe.o): Use CFLAGS.

Please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU5eVSAAoJEPU2Bp2uRE+gKXkP/iwZxtHYEvj1JZHm35Uun0CW
crAZ/38Vjip80ChMJtVdAmD+A4TvXbvrNj3AN2E6snhOJ3SW7Pi6zq9BCfnUfa31
ju+ZDierCIFj3/sLdB8QSxi4dBgafdCwRAsriGSmcysWzNfyGIsnBKoTAVvwCmCK
0eEQyzfybTmbOaZjtM4Xvhwk0+iVFTn9P03HsD4gzWOuvS5+nPDi3MVzchpC6Lf0
6duwS9JOuP9+U0jC+UgyEj9mSQgM7HYr91aZ8dPBd5AKcYxeRlwHVvnsL0DDHH2b
0RFi9YaO+Vh65OxeTHqZrsSePEU8r1mbK/zvFDQsjyquEA9kAbsU0VpKClX2gAI5
+Kg+2n/2yP0hYvyb/1O9bO3vYqktJAWc+EEKfHTkZk3x4A4vxuuCF47SgWcY1jfv
CzsQIwBTxB9V9xabJfPfdwSmCY/Z1GRO07k7J3uRQU+6Mucu802H8iygi0SCQ0hu
djcn5FFr5yfvJPcuKTXK8MPiGmmmKwkq9MJ/HxellB/KGh8KvNRpMYlQ0go2eC81
m29Rz26jkIAdyaLdAj+hfnwOdEdfb/EuaD3N8xM4c7YiCOc8+mKJv4RQ6Slc4d3k
6hemEwvFdbKhq1NWgKowj/qNmEs1r0BQlH2FS+mQjlUlxXvkntXF9/BmqeUTtLtY
59f3CBH045QDqFFZg9tb
=l6PS
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--
