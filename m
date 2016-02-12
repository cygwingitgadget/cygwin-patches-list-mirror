Return-Path: <cygwin-patches-return-8307-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 110471 invoked by alias); 12 Feb 2016 17:46:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 110452 invoked by uid 89); 12 Feb 2016 17:46:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=H*F:U*corinna-cygwin, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 12 Feb 2016 17:46:50 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7A9ABA80595; Fri, 12 Feb 2016 18:46:48 +0100 (CET)
Date: Fri, 12 Feb 2016 17:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] cygwin: fix errors with GCC 5
Message-ID: <20160212174648.GB19978@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20160212093124.GB19968@calimero.vinschen.de> <1455298020-14696-1-git-send-email-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <1455298020-14696-1-git-send-email-yselkowi@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00013.txt.bz2


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 824

On Feb 12 11:27, Yaakov Selkowitz wrote:
> GCC 5 switched from C89 to C11 by default. This implies a change from
> GNU to C99 inline by default, which have very different meanings of
> extern inline vs. static inline:
>=20
> https://gcc.gnu.org/onlinedocs/gcc/Inline.html
>=20
> Marking these as gnu_inline retains the previous behaviour.
>=20
> 	winsup/cygwin/
> 	* exceptions.cc (exception::handle): Change debugging to int to fix
> 	an always-true boolean comparison warning.
> 	* include/cygwin/config.h (__getreent): Mark gnu_inline.
> 	* winbase.h (ilockcmpexch, ilockcmpexch64): Ditto.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>

ACK


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWvhqIAAoJEPU2Bp2uRE+gVMMQAKZatOy+1AnyL9OwucU69jog
pLNhS09hAvAb5XNzE+FFqcQJzDJnIre3UkAloNYJb5flGW3Rp0rP8O9vDFTD74pF
TsJk2egotwWJu7LuDba9PkEG7aM5mst6WI+PPoa2zDkzCTsUCDkHNtK/smDvoeDc
0zxXDcMD76lMkxBlNjyySlMrKIKSqi7+2phFrLu1qjFnc3Seiib2KcMrhYxFYd4q
l6imibVJaXgOyxM0w8pXtech9PVhLiZy4BlPHDWX5c2mDm4DWPBwIaoMhxBdtt0C
8Fgxr8vySZUY5+gT2mW8Id2/FZp3Gv7NQLZ2uDw8eJRxORaX+U8jn1y9IYXBhdnH
LWg/mu2c5Aex7WAL8NhIfY9jlT9hY+/39Cqrl4QhgAsnx4e6xmClexjObYQN7bAH
6+kU6t9zz7jTq6JMKuI0CxzBsEy3Z/g35IiwwYf544jzYk81ZApQbnXZvPU0+Msd
lSSaCGJVL9hSpEQAw0u8aUzzmhE2ZIGyIGPlgzJBsVzW7AQ0tzlgeuTZvQ6R1DPm
fuOvN58pXhiOvSQeQORN3T3YlHi7XQhxScQ1gAWFa3bL4tL3YlJFTi1nlXwGJXtJ
fNTwHi3QpjTpQ82XTKEwIPpq/Ovg9gCxUzXE1i4P4SuFDQilYJRs6os+C7l8X1Z7
4NhbxIOCloGz48G5RfT9
=kS7n
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
