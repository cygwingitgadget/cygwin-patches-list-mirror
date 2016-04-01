Return-Path: <cygwin-patches-return-8529-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130847 invoked by alias); 1 Apr 2016 12:27:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 129939 invoked by uid 89); 1 Apr 2016 12:27:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=letter, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Apr 2016 12:27:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 707A5A8060E; Fri,  1 Apr 2016 14:27:42 +0200 (CEST)
Date: Fri, 01 Apr 2016 12:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/4] Remove leftover cruft from config.h.in
Message-ID: <20160401122742.GE16660@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459447458-6547-1-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <1459447458-6547-1-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00004.txt.bz2


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 773

On Mar 31 14:04, Peter Foley wrote:
> HAVE_BUILTIN_MEMTEST and AC_ALLOCA were removed in 4bd8eb7d1b.
> Cleanup leftover references.

> Use the 3-arg form of AC_DEFINE.

> MALLOC_DEBUG and NEWVFORK haven't been defined since 2008
> (46162537516c5e5fbb).  Remove all references to tem.

> Don't use obsolete LIB_AC_PROG_CC.
> Run autoupdate.

All patches applied.  Given that patch 3 made MALLOC_CHECK obsolete,
I removed the definition and all calls in an extra patch.

Btw., if it's not asked too much I'd be glad if a patch series like this
comes with a cover letter (e.g. git format-patch --cover-letter).


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/mk+AAoJEPU2Bp2uRE+g9AkP/1r1np3GZM+lAKBKCicTZ5Ji
kFSC63XPkOKge1FgC53mPWZhEzJUlkVfrKexGUs80wocRUP/0vAv77Sx0o7jONni
EJ1eiyHaugKR/n/QwXFJKoSuxppMoPMuhkcckXJP0ivayVYDYVQDf9tG/zRBji7Z
B2nKkKiyUeji8tgp7EnOLsGmAewJ6oza1Y6MFR0+a1ahjlVECxaCbXkJkeCEOuoV
eDjRmQjQuWGxifDeW/6GsnMqPQwiMcpAlXBYGwgzJ27HETCgzVQplLlBDi0zM7Qq
NiG03R1DcUhompBH3YM6hUqH+HYMBUAC7H4cEmxzxKIfzq4iIdII4Ptz5CuaJCvz
uspGyWqc9IKfG//ruvYsvMiYSeCYEBuC47p6KGhQR3GOXCC7YBT3thUELG1q1QR1
T7ZOgkH7zFCd2419hLYbiOEgdISf5NMlohsVXgrdcCRSW72rj5eeAGUyGmAPiSnw
qZsZ+s8DChHQ1Pm1jxduqsVKHOEJwOjubvBJJLm+VN3YFexiZgR1oFUQpEHmy3pe
K0JLkwp4jXop8MOD8D2XNmE7SqiTjWFaDDfAXxzF9orzMIDB99e1a8XJcPBQU0o1
bjzJ6h308nizC9FzhVctJbl+n8n60OFN/TvaluFX3aXG9HQjeomx7rNMo6lyORgD
7/kNQzy35druINEc8hkv
=N7qT
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
