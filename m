Return-Path: <cygwin-patches-return-8064-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 60990 invoked by alias); 12 Mar 2015 14:44:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 60974 invoked by uid 89); 12 Mar 2015 14:44:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 12 Mar 2015 14:44:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B92B9A80A55; Thu, 12 Mar 2015 15:44:27 +0100 (CET)
Date: Thu, 12 Mar 2015 14:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Improve stackdumps on x86_64
Message-ID: <20150312144427.GA26510@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <55019D23.6060308@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <55019D23.6060308@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00019.txt.bz2


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 420

On Mar 12 14:05, Jon TURNEY wrote:
> +	* exceptions.cc (stack_info): Add sigstackptr member.
> +	(walk): Unwind sigstackptr inside _sigbe and sigdelayed.
> +	* gendef (_sigdelayed_end): Add symbol to mark end of sigdelayed.

Patch is fine.  Please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVAaZLAAoJEPU2Bp2uRE+g7ooQAJODs7kIfbISsAjkxV9WbYmX
ob9i4k5T7xof/g1mnPPgmdA1Z5aVroBjJV3FmA0nieTqg9hCGU4M8ofkgjp64g8i
yp0XY1Otmja2IoPXN8Na3NRAqUruUJBQY541tDk2F85nBTTD+UgFyD7iVQzpvXln
CadbUmQuIOeys2fGRKazX/m8iyJY/yBVp5FcgMcmReNaqkQjr9i8i32UI9Izugsy
Rba4XdQLsriH6nT4fuV6bwkhNGoF/PxsJQmPgo/IQuWRZLK/WIlAsSnb+XazxePz
Wqv5ou75CpVE967e5pPqTADbaSen5rUJsJ0d1uMY3gjQ4ONzrN/ICw2VHUpUmSec
7Bu+0tj9RKjV2LpzAt9cv05P+u8AenAmuokgDEtcaRA99RCnEexZ/IiHeAybz+Fv
SgjZ72Dk1cjr9eRVb3hav6lXUGJEeN387OVQ9EVdi6NK+av4Eh6IX0HkPb2TCMdS
4sG0JxR/Vzw1Z2sggtI6cFE0egqO4yHGfl+i6j7H10o2P0nRUxU4IxMn1hB2hA2m
31O3gn6fwSTs/ZXAus90SMdPV7YzQ2IWVud7T4d3a6TSjhwLJfYKC9+7OeXwTc0o
24EmhSoVVYziEgyrbaV5ZjYfumCX3SiHYspSRveMR/8kjbHn8p+9M2Wn8mC77fn3
26pO5i8iO9kzdQaz2q/c
=vAQa
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
