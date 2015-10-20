Return-Path: <cygwin-patches-return-8249-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92687 invoked by alias); 20 Oct 2015 10:34:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92675 invoked by uid 89); 20 Oct 2015 10:34:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 20 Oct 2015 10:34:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CD3E3A806C9; Tue, 20 Oct 2015 12:34:41 +0200 (CEST)
Date: Tue, 20 Oct 2015 10:34:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Evgeny Grin <k2k@yandex.ru>
Subject: Re: [PATCH] Fix compiler errors/warnings when compiling with -O3
Message-ID: <20151020103441.GB17374@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, Evgeny Grin <k2k@yandex.ru>
References: <754151443021620@web4g.yandex.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <754151443021620@web4g.yandex.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00002.txt.bz2


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 461

Hi Evgeny,

On Sep 23 18:20, Evgeny Grin wrote:
> GCC find more suspicious places with -O3. Cygwin use -Werror so uninitial=
ized variables prevent compilations.
> This patch allow compilation with CFLAGS=3D'-O3' CXXFLAGS=3D'-O3'.

Patch applied.  I added a ChangeLog entry for this simple case.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWJhjBAAoJEPU2Bp2uRE+gLccP/39cE0k03oSeguPPS0vbKqpL
QdQ7dnxOI0cspyAZzT420+BZjXkjOWECojf0nLPE6VJfuVOG0yh7WdNEqbZe6oku
VStcGgRQnZEbUnPkQs2Paj5eZfImrLVFo9fkUgljtoYW5gs96dvzpasJ0afjygUY
sOauflwID3xDxV+3k8TR+yLMYZFmE29yfS2un79EII6A+OTg+LjxcRL115WDixuw
Eb8enGDT9pimIBlprFIbGkQJqnLzOdEFq/UoZqfzRwrqL6oMGXgX4EJoU5Rm4L9F
HGpI+mF38kcEoUuAD4+OmTG35gmcyytfmqnUQUR6QEqkjh+2Xp9T4Urwrp2s4KKA
qeE4OBlvn39M4XkSL56MrTo5Jcjt8hQdfO5gDj0EOFWPSSeLa/ayNDVh1qqSux7T
zfQu+DSmYEub5cEFCOF2urALRgB3xGToa/eFYqCIdaqnXAAJFmIJUb+u39KbF3Kv
RaC9iAOhfR2CVKjAo8lEtl4mwLPD4sZxJnWnxlx7WTbNDvCBAIJDkTskkuNhQM3C
gRFvAplCabcMED1lVRa++etuhGyjrOkh1bLeBsw/CkAoy0ZZDuDOR12gnaPKWEYF
vjBKU9kkkmkZZ66Ebm4EmkxxpzISQ3/HVzxlKEezakd1fpCd9sjWAUxyKe9XrYC5
40ZGLDEB4feywzVeXkSK
=dNMC
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
