Return-Path: <cygwin-patches-return-8433-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124097 invoked by alias); 20 Mar 2016 11:03:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124078 invoked by uid 89); 20 Mar 2016 11:03:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Mar 2016 11:03:21 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0D984A805AC; Sun, 20 Mar 2016 12:03:19 +0100 (CET)
Date: Sun, 20 Mar 2016 11:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 04/11] Remove misleading indentation
Message-ID: <20160320110319.GF25241@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-4-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline
In-Reply-To: <1458409557-13156-4-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00139.txt.bz2


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 953

On Mar 19 13:45, Peter Foley wrote:
> GCC 6.0+ warns on misleading indentation, so fix it.
>=20
> winsup/cygserver/ChangeLog
> * sysv_msg.cc (msgsnd): Fix misleading indentation.
> * sysv_msg.cc (msgrcv): Ditto.
> * sysv_sem.cc (semop): Ditto.
> winsup/cygwing/ChangeLog
> * syscalls.cc (getpriority): Fix misleading indentation.

I only applied the hunk affecting syscalls.cc for now.

The patches to sysv_msg.cc and sysv_sem.cc are not quite right, IMHO.
The GCC warning is rather a problem here.  The indentation is correct
in terms of the original code.  The only reason it's treated as incorrect
is the special handling added in the #ifdef __CYGWIN__ block.  Changing
the indentation just to satisfy the special Cygwin case is not the way
to go.

Ohter than that, partially applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7oN2AAoJEPU2Bp2uRE+g0m8P/AlJ8KsIy+5XnYkg60Z148Ay
or4ACGe5R3W8/lQy//+LDxJFMaMM9CXJ9JscooNQsKLuSPBC4zdyyByQOic2j1kS
rxn2wECElj9WSU6i+nPvSJ70QzqX4ZfMBmH/MNmi32Ruh6UirH9EOHSPRR95MrXX
rQyl8U7HHIRXkqAZa9N2DbbThYI934jMJwlzmsk2XRFyLAReA0JquQrBGa/CeYg0
igtCmKiy/ZqA2TDfA9U/QwZS1g5nGXIm3/kSfe/Emr2xUF1EjXdHKwonxqnWaY7b
zE5vXm2+beG0e/kbmXNPYbUgdKKO0lXG91cD3hqENwj6yj2VEceJ1zzcxIEH9GSW
6FVPIsJuTYEqM4Kd+ac8mGnu96ZLCrdsZQKRNyXKz7Mq1KvVi71J2rCvFCKgYHhk
JvDxzGZOgmeWPjFjVQmyzxJSf8LpEs7/cmv3SROq+ZPMgEDq6QekGUtiiFf+JKwn
4ZWsrTiHjPua0pUh1iBOhUI+jbePV9azBTzNSLSHR+VllIvFaI6tdKkA0CenVaL1
sSdOeOMn3hsIrNm1IDPw8wuWuAFuFidDURVfl8JPmjKvxpIov4GxFUM1Ralu0wyh
I1+88gNxIlOM3beg1CdqPKpLSZQTiKoeumoYexAZzceHTcnqRq8UYEIWfYoVUkEF
21QhKUSIEUb1OMJrJcRf
=7sxT
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--
