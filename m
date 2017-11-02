Return-Path: <cygwin-patches-return-8898-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4174 invoked by alias); 2 Nov 2017 17:10:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4160 invoked by uid 89); 2 Nov 2017 17:10:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Nov 2017 17:10:49 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id D8976721E280C	for <cygwin-patches@cygwin.com>; Thu,  2 Nov 2017 18:10:46 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 208AA5E03A7	for <cygwin-patches@cygwin.com>; Thu,  2 Nov 2017 18:10:46 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0BE6CA80658; Thu,  2 Nov 2017 18:10:46 +0100 (CET)
Date: Thu, 02 Nov 2017 17:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] posix_fadvise() *returns* error codes but does not set errno
Message-ID: <20171102171046.GB31634@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171102154535.12176-1-erik.m.bray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20171102154535.12176-1-erik.m.bray@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00028.txt.bz2


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 314

On Nov  2 16:45, Erik M. Bray wrote:
> Also updates the fhandler_*::fadvise implementations to adhere to the same
> semantics.

Both patches pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ+1GVAAoJEPU2Bp2uRE+gv4kQAJiPVqiS3rgCVLjkiUvXMwiL
JMTJFAvWEkb8lJlkCghDXJMHM1DA8jFLcdy48Wi18FKeY8OWVWioxJpglkojZyIz
P7BP2oD4+8LYfmevryuXSrJKMv2rmSNeU26GWGxO4if0L6/Mh/igbQAme0W3Phqs
Q+2s7qCXpsRE+dejEOnq2qnZlRKcgibuFfqADd0Pf/30+lWdzy7pmclpcgNZqYBU
H8A16KLA93Mq0AifFe6SlEc7fCTtRGaQKzEDfQbz5iHK3XMx+DBeVYuyNwABUJF3
DNDp1y5Mzkmcyq1M/1bN7xPKkzCk0Ru9L5pXk+aOc0UTZLYbKDno/A/jZVpPQpef
hsZz2vcdMD8jupe7hWsTEV7I6hA/Ar6w+A/C8JffyDVOSsA3PtwEyhYmFVgNcrt8
fUd6hTz95MPEf1jRz5v0+n6ChFMaKjNNsvheMkLpHqrRvbgy2gSgWxLGFSWFre6u
X3BZ9jZxaOTKeKFeD2+AzNXfJSwlSkvvsmyhfqv7Zuy1YN4/Vel1Y40s5fXciPzG
F24ADvFwrpzLxNTeCtABywQAZaAJDYIc9Ut62rsEB9jETiXqmh2DYUQlSNL3Wppb
y+rgYOZw3oNMXg2bn+N2Ux7pDwNe08ZH7fGTuBVL/HvKGEHrqUR2Q1Afpcs/KfIa
Fv33O49TkIcKnFJM6Bds
=gQkG
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
