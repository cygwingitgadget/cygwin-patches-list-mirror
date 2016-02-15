Return-Path: <cygwin-patches-return-8320-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85693 invoked by alias); 15 Feb 2016 12:57:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85682 invoked by uid 89); 15 Feb 2016 12:57:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=mintty, 2k3, 2K3, Hx-languages-length:2520
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Feb 2016 12:57:06 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C8EDFA80595; Mon, 15 Feb 2016 13:57:03 +0100 (CET)
Date: Mon, 15 Feb 2016 12:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin select() issues and improvements
Message-ID: <20160215125703.GE8374@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C03624.1030703@glup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <56C03624.1030703@glup.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00026.txt.bz2


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2532

On Feb 14 03:09, john hood wrote:
> [I Originally sent this last week, but it bounced.]
>=20
> Various issues with Cygwin's select() annoyed me, and I've spent some
> time gnawing on them.
>=20
> * With 1-byte reads, select() on Windows Console input would forget
> about unread input data stored in the fhandler's readahead buffer.
> Hitting F1 would send only the first ESC character, until you released
> the key and another Windows event was generated.  (one-line fix, though
> I'm not sure it's appropriate/correct)

I think so, yes.  I applied this patch, thank you.

With the other patches I have two problems.

One of them is that they are not trivial enough to be acceptable without
copyright assignment (except patch 3, but see below).  Please have a
look at https://cygwin.com/contrib.html, the "Before you get started"
section.  There's a link to an "assign.txt" file with instructions.

The other one is just this:  Can you please describe each change in the
accompanying patch comment so that it's accessible from the git log?

> * Newer versions of Windows may return early on timers, causing select()
> to return early. (fixed, but other timers in Cygwin still have this probl=
em)

It would be nice if we could discuss this a bit more in detail.  I wasn't
aware of this change.

> * The main loop in select() has some pretty tangled logic.  I improved
> that some.  There's room for more improvement

Definitely.

> but that would need
> changing fhandlers and related functions.

If it makes sense, sure.

> Windows scheduling in general seems to be rather poor for Cygwin
> processes, and there are scheduling differences between processes run in
> Windows console (which are seen as interactive by the scheduler) and
> processes run in mintty (which are not).  There doesn't seem to be any
> priority promotion for I/O as you see on most Unix schedulers.

I'm not aware of such a feature.

> I've attached plausible patches; they're also available on
> <https://github.com/cgull/newlib-cygwin>, branch 'microsecond-select'.
> I think it's all Windows XP compatible.  I've put some test programs up
> at <https://github.com/cgull/cygwin-timeouts> too.

XP/2K3 compatibility is not required anymore.  If you think you need
a feature which is only available on Vista or later, feel free.  We just
have to inform the Cygwin mailing list, as promised.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWwcsfAAoJEPU2Bp2uRE+gp4cP/104TunlbB61CiNPmMl1nbzS
8WQbyt4u6ersC7s1h7pypGwbfXQIIoHC2taZC//9NTdQkKfehiYd2qHdCU8lOUAV
xr0CA8ZXEwBmwRg8j/JBJjEdDOTqFz3yGY6S4UMZbUkBnEAVMre3fZ3tkwLk3r+i
vnCb7Gil6FjT9KoRL8WzY6Z0s2sydMVr8EnCfnPDQE9st5SCz01Ifhdy370GBqCF
GDexUKbH45x76Cpixe+C0IueXrGKHjRPMOCNoF77R6f1XDQYRTyC170R+aRXKyx/
hX2LDDQPLkkK7TF2MvcAJpAqZBcF92O0nF2OW9CYrAaWCrM3PfQE9x56GY1RM8Zz
gm9mSUv7k36y/kbUDQYtuZY9Zg+E0+FDHKMXzJtojJ4irpytL+goN3zNl++QgB5E
G9iQJ9t26uoim5W0KCZM/JKS7Rdt/YmJPlKDqe7+/Wvps1YP4NuDYC+f6gfmexli
iLj4zmngACJyxoIRRXQTHTqNoCo67aOP5zjbR6VhHGM2QSLKBmAStnD1JgG6wEuz
G0QlU5+Ezrylpn/TwAXZ1azLAWgxVH9pqdLi85fjYONHQNPSHmB/XEolc2LanNlQ
gEKsL+Dcj7I2aF5m2lktb7JtHbUD8v7PPYbwTVf98WjFaNxRTUMAvLpKCf6o6ut5
iMhDF2eDlq0Lk17EwD4T
=rJa6
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
