Return-Path: <cygwin-patches-return-8347-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 41175 invoked by alias); 22 Feb 2016 10:12:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 41162 invoked by uid 89); 22 Feb 2016 10:12:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-94.7 required=5.0 tests=BAYES_40,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=caution, file's, Hx-languages-length:1602, 100000
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Feb 2016 10:12:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9B1DDA8035E; Mon, 22 Feb 2016 11:12:24 +0100 (CET)
Date: Mon, 22 Feb 2016 10:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] gprof profiling of multi-threaded Cygwin programs, ver 2
Message-ID: <20160222101224.GA29199@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C820D8.4010203@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <56C820D8.4010203@maxrnd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00053.txt.bz2


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1618

Hi Mark,

On Feb 20 00:16, Mark Geisert wrote:
> Version 2 incorporating review comments of version 1.

I'm afraid we need a v3, two points.

One is, for completeness it would be nice if you could add a
description to the git comment along the lines of your original
comment so we have a description in the log.

The other point is:

> +	/* We copy an undocumented glibc feature: customizing the profiler's
> +	   output file name somewhat, depending on the env var GMON_OUT_PREFIX.
> +	   if GMON_OUT_PREFIX is unspecified, the file's name is "gmon.out".
> +
> +	   if GMON_OUT_PREFIX is specified with at least one character, the
> +	   file's name is computed as "$GMON_OUT_PREFIX.$pid".
> +
> +	   if GMON_OUT_PREFIX is specified but contains no characters, the
> +	   file's name is computed as "gmon.out.$pid".  Cygwin-specific.
> +	*/
> +	if ((prefix =3D getenv("GMON_OUT_PREFIX")) !=3D NULL) {
> +		char *buf;
> +		long divisor =3D 100000;	// the power of 10 bigger than PID_MAX
> +		pid_t pid =3D getpid();
> +		size_t len =3D strlen(prefix);
> +
> +		if (len =3D=3D 0)
> +			len =3D strlen(prefix =3D filename);
> +		buf =3D alloca(len + 8);	// allows for '.', 5-digit pid, NUL, +1

I've seen 6 digit PIDs.  In fact, we're not that tight on space here
so we should err on the side of caution and leave room for the entire
possible size of a Windows PID.  That's a LONG, 32 bit, 10 decimal
digits.

Other than that, the patch looks good to me.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWyt8IAAoJEPU2Bp2uRE+g2pMP/RBUlqsRQCLUP0vtgZzVw7h9
DAQdyNuu4hI9c9wGeRuuSzMzQypftMvXWvk06nmrHHsUNsvjQWvIzhUkTKcLn2W4
8Y+gX2cyHnKd25GbSr8xIjhNxQtIbsMDtjlpxuccyxtEXn2Z78AoY9L1ImGx5TUD
AuO2k1y+IT0mQ/vmIqepr4oM3oDNezgSKvAE2lLhHJFMF/OXGbFjKwGnCe9Xck4r
jZW4ObS9HF4ay29ugPfonettWa5CGhzfBgqz5OL9v2MHipcjOVpdy5kKDhcqi6LB
tbNNIvtCcTdr+2BId/snpgguO2JHKIHAsfeO0CX4M3rwR54pNh9Y0iSPoUWbFHnQ
sysE4mHGjjFuG2Nj/yWSOnYjIUBfDaZJaZOOCH6OrsvmOwcqiipLBUc+qyr9gcOx
7sKA/EBvT+bioRh8nDw93Gd4oRCKOlri3ix9Yu2D1kbFVoiubEsg2kPfScdq+8eA
YkbRM+sptSxeHhm3dkC9+xEihCL6ooE1yTJ6C24hnMxwgOEWl1fodPIu1qLe3Dwl
oXcNNra0p4ta+YmstxWjC6nP3M9e8P3Zru4joqqNPKhK70k0XL0DH+AIMw9iRavo
ZVeSJUrWBOfw5FZbSRFjuhwj/+XlBKDQubHrO/ZPy1PsIsEw8QKfIz9S1W0lJC74
1gChYApQkyR7qNkSqFza
=q4vn
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
