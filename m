Return-Path: <cygwin-patches-return-8871-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119446 invoked by alias); 9 Oct 2017 10:19:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119434 invoked by uid 89); 9 Oct 2017 10:19:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-106.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, H*c:application, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Oct 2017 10:19:01 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 47941721BBD2E	for <cygwin-patches@cygwin.com>; Mon,  9 Oct 2017 12:18:59 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id AC10C5E01D9	for <cygwin-patches@cygwin.com>; Mon,  9 Oct 2017 12:18:58 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9608FA80665; Mon,  9 Oct 2017 12:18:58 +0200 (CEST)
Date: Mon, 09 Oct 2017 10:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Feature test macros overhaul: Cygwin netdb.h
Message-ID: <20171009101858.GC3542@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170927013635.19160-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <20170927013635.19160-1-yselkowi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00001.txt.bz2


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 528

On Sep 26 20:36, Yaakov Selkowitz wrote:
> herror etc. are MISC, rcmd etc. are BSD, addrinfo functions are
> POSIX.1-2001, except for IDN functionality which is GNU.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/include/netdb.h | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)

Series ACK.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ200SAAoJEPU2Bp2uRE+glzUP/ihDUjUfHcAO6gmDa6hdWazR
qpMIrp29dsXBxGdTDtm6WXlsQnTswd9ShZX3jkPKB/54EbYgmpFpm3vg6K17qu28
OjNFQJrFlgGgBm+8VbbqHYsq9H5euBR6phWy5qfN8ZnIJq6c2Llaf+h2fADfGu83
6nsRPH4RyOoDb7dE8q7iUgNsD2Eo5qXv6WaloALtnHlqxW4ut4IN+PCMXHHk3zCx
uGds6/9xXxywJs2yOT+Kp6n3+6tirH3rAkkjOd1sYoe+rYmBCl4jYdwB2uFwkGBh
wFH/BQSKLO1iRk/PJX1N8Wx5pYX6tHPYeTc1wGFPHKqfpBgIaQD8QIrLFg2P/5Sy
XrCAn7Bap9kqC8KaTKTytycS1kCy7nVrG2q4kZDQCNJKw7qTKONVVlgBGJFZ4DLc
nUKXZIsGhppColN4DZBhKLX+CoiYttuOx+C92bczoD+9SNWSypNKn60qpz4bsSbA
htv3pLSZuB6/GGu2zguTg5J9HehLdfjSptQd9k0pe9AKhcOirwjYOMtzi2VgN2bR
lVqLaI8K+cJNzEQ6cqeMCX0Tic0luRn9rMRH/xhY4xRKYSPzF/VJ3ibaMAuXjrAB
GD/jV3jwaoQvX5iuHaswF4hiMByfjxC8FK9p73YavWBs4E1HOoQYMwRxz6Atqpr/
4tCETK7jD7oCYAyYExlf
=ruWb
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
