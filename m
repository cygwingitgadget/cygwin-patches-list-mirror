Return-Path: <cygwin-patches-return-8457-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36804 invoked by alias); 21 Mar 2016 19:17:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36785 invoked by uid 89); 21 Mar 2016 19:17:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 19:17:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C5AEFA803F7; Mon, 21 Mar 2016 20:17:13 +0100 (CET)
Date: Mon, 21 Mar 2016 19:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/5] Remove misleading indentation
Message-ID: <20160321191713.GC14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-4-git-send-email-pefoley2@pefoley.com> <20160320110319.GF25241@calimero.vinschen.de> <1458580546-14484-3-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <1458580546-14484-3-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00163.txt.bz2


--bAmEntskrkuBymla
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 425

On Mar 21 13:15, Peter Foley wrote:
> GCC 6.0+ warns on misleading indentation, so fix it.
>=20
> winsup/cygserver/ChangeLog
> * sysv_msg.cc (msgsnd): Fix misleading indentation.
> * sysv_msg.cc (msgrcv): Ditto.
> * sysv_sem.cc (semop): Ditto.

Patch applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8Ei5AAoJEPU2Bp2uRE+gM2sP+gL8FUeKa9zCcgtqV15xonjt
oiDqkkKn4hRMU3mocwD+L7RZBqgPJNpeHl15FgaFA3z6en1VROrqwFN8xhVkhlE8
KITg9wG7G50mcDe99NQ8eSd8jUBpDGGiZhji3HzRh2glWU1shC/kei9ruI2k1bEF
/6QcJ4kVMbwLm1Qeor2PfblO373oogDbLy9XBIIEIOmYdiZp8HtGeoc+//pcPsZP
QUPIPmRjxvowcFAVX//cUqzaOzy7HiniO95zWuFB7N+Ebk0mBMSf08urRRW33NQ/
SNmI1PiMSM5Ezt1WfoIi1sZfRCBzkCij21Y8Yu9jCxSmeXB0vJ/9Ama5Nicz1a9J
YNHf7Szp+XQXZ5pVg+fGvMZlp9j0M1E1c4cqC+T+PT4nyQaTheQQhRZlhr29GeFw
RtSaHjW+lZ1ckMqTUgh0T+OyqQJdoptsMsO/G//mlA/EjkwOTR5MjoD3CPZQZkve
bLBeb2A0PaU0wN0WpnFYcmahrflL3+byKaeHxhbfkevWNohbN1zjEr6AQ+5U/3yi
uFHOq5KNx+wemcjdQ8QGU6DtzmxyoPKpkNx/vpZHJsjL9k33XYtUZGEWk9C5bQPT
u/E1vRaJpzbrpOjTeG9okj+k9F7q7ueeLf14Ns0ibOj0PdsPOtY7hbVi8z8HREjm
f/3EmvsUL+llD0jKJZmQ
=W9Aa
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
