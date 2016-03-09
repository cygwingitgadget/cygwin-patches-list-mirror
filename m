Return-Path: <cygwin-patches-return-8381-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80215 invoked by alias); 9 Mar 2016 22:44:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80197 invoked by uid 89); 9 Mar 2016 22:44:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-93.9 required=5.0 tests=BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=DOT, Maintainer, columns, Geisert
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 09 Mar 2016 22:44:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id ED39BA80674; Wed,  9 Mar 2016 23:44:00 +0100 (CET)
Date: Wed, 09 Mar 2016 22:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Support profiling of multi-threaded apps.
Message-ID: <20160309224400.GA13258@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56DFE128.6080308@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <56DFE128.6080308@maxrnd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00087.txt.bz2


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1412

Hi Mark,

On Mar  9 00:39, Mark Geisert wrote:
> This is Version 3 incorporating review comments of Version 2.  This is ju=
st
> the code patch; a separate doc patch is forthcoming.

The patch looks fine to me code-wise.  I just have a few style requests:

> +	if ((prefix =3D getenv("GMON_OUT_PREFIX")) !=3D NULL) {
> +		char *buf;
> +		long divisor =3D 1000*1000*1000;	// covers positive pid_t values

Why "long"?  It's safe to use here, but it doesn't match the incoming
datatype.  pid_t is 4 bytes, but long is 8 bytes on x86_64.  If you
like it better that way we can keep it in but wouldn't, say, int32_t
be a better match?  Also, can you convert the TAB to a space preceeding
the comment so it's within 80 columns, please?

I'm also a bit unhappy with some of the comments not trailing on a code
line.  E.g.:

// sample the pc of the thread indicated by thr, but bail if anything amiss

// record profiling samples for other pthreads, if any

Ideally that would be /**/ style comments, starting in uppercase and
as full sentences ending with a dot, e.g.:

/* Sample the pc of the thread indicated by thr, but bail if anything amiss=
. */

/* Record profiling samples for other pthreads, if any. */

With these changes I'll apply the patch.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4KcwAAoJEPU2Bp2uRE+g4f4P/3iHU2LsbtDEHaB+G9w835lq
2S7Dv2PW+EQbLGDkw/5Yj1iVk8VazgKDr+FbBTZefIsWf8eONI/MIvwxSLvHeFHX
BvAcujRO/YSPgoycam1Kb9CTEOVHpRgcZlpEwRjDcGpYtHuaPYurVvcsoR69j/Tr
OgXVHJ/MBovI4gK0IYFjaTfAh8D9K4uG5Qi1CSkfyNpnZJaB82G8ViGze+fwR2Zt
wxgUzFve47S/F6W/vHzQZLMtpRgLcMVo76knSSdYzdCInviV+WsLZG1gfQWpscYQ
VNtlD2jPrMcYvQXqPSpHeAMoTnmzwPt+4kcHVty1TRsGyJ7TVTdoDpVGQ3FL2RG5
8bvBisaAwJBs6sxqltP8Z4jtnTMVrUpFuDXYd4e7QUQqy3cMo/8viRPxrbhRfba0
fEcyIVjcQ8ebpE2HXS0ypAforoJS5ZbDRMoUg3YY0FzzTH+HxAm/3i7YrdJWQwKX
kxO+UagQIoDxyjvVV70dAAPs4e5DWiWHqRYUmhBeg7FNaFM0D4uZ0eHYyrioH+7E
97exI/Lasdtwwa7jGzOvxapynVs8Fqhf1NX2yH9LF331q4glgXH+QM+DhHmkOwxG
a7pAXZXRV3EaTdzDA8uhW7pz4l+9Y1jqweSvoAylEP+JYV4a3u1kXilN8a1tRMOH
fnAOqEfi5R8tTywBkSOn
=Fcgk
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
