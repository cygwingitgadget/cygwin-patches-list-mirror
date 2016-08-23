Return-Path: <cygwin-patches-return-8615-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16063 invoked by alias); 23 Aug 2016 08:58:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16036 invoked by uid 89); 23 Aug 2016 08:58:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-95.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=jon, Jon, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0190b.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.25.11) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Aug 2016 08:58:07 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2D8B4A8060A; Tue, 23 Aug 2016 10:58:05 +0200 (CEST)
Date: Tue, 23 Aug 2016 08:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Add pthread_getname_np and pthread_setname_np
Message-ID: <20160823085805.GB2629@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20160822180848.351616-1-jon.turney@dronecode.org.uk> <20160822180848.351616-2-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20160822180848.351616-2-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.6.2 (2016-07-01)
X-SW-Source: 2016-q3/txt/msg00023.txt.bz2


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 379

Hi Jon,

On Aug 22 19:08, Jon Turney wrote:
> +#define NAMELEN 16

Please use a more descriptive name here, say  THR_NAMEMAX or so, and add
a "for Linux compat" comment.  With this change the patch is ok to apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXvBAcAAoJEPU2Bp2uRE+gXtAQAIFfOE90W4uA/yBeOiD5j/EP
byDRaNL1p14qid03+hvEB/Ayd4eoje6j1UqdoNMnbx7e17BIONkpRv+L/KzjuGQc
ZDwcbx8pYsAZblHbAKH7Ll9RZNiPFbG0ufWrO32W7DSW86M7pd5NA1j91Qp06Q/c
H1TlVnJxz216HwA2RiswSMbxTdhBzYQEnB1G26mglTd90sBxB2i17fn0GQNiMxd6
VeC92g/fLcdIiRlNX8ggji5erqz4wmpYpRvrwvsmjA/I7NNDznHua9sZmVQZ4WD8
zjJN6ocINcs/YnVAGHd9x0HRHhK/8eAezh9BvPJBsPkKTA5p8lc+h2LGN1iw5iZJ
SAPEXvB1kizS5TX33l9eN/E97eZF/l8IfR7q0CACgBv0XDISt8XzFdAc9dykWGJJ
lmUGxdVg8gYq4OCqae57sK2/GxrTS5m9tgcPnae03qfuIejx8RblJoT/gRJD4As9
mtGndOeA2DMn3H2EQFDjWcnuOgx4sVeKlfSC7bqDN0T4u6RYkTSVXHKnABIAjiu1
rXj94dMdQhDEBO0vIbZN595isAwRkwswL2UIKpfxkDvi9LSGceQb7kgN3wgGleNf
CG9ectmkrNA5LG4NZhjO2lOf46kPa9C6sVifTtP2pSLoW3SQHSM6KXIFPMeLUu7V
c/tkw7BtzaFvXu2PWdyX
=a4Au
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
