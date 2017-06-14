Return-Path: <cygwin-patches-return-8784-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 88115 invoked by alias); 14 Jun 2017 19:15:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 88037 invoked by uid 89); 14 Jun 2017 19:15:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-11.9 required=5.0 tests=BAYES_00,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=H*c:application, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 14 Jun 2017 19:15:40 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 1D9278123F;	Wed, 14 Jun 2017 19:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 1D9278123F
Authentication-Results: ext-mx01.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx01.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=vinschen@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 1D9278123F
Received: from calimero.vinschen.de (ovpn-117-161.ams2.redhat.com [10.36.117.161])	by smtp.corp.redhat.com (Postfix) with ESMTP id DD2F37841E;	Wed, 14 Jun 2017 19:15:28 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 97BF4A80706; Wed, 14 Jun 2017 21:15:27 +0200 (CEST)
Date: Wed, 14 Jun 2017 19:15:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com, newlib@sourceware.org
Subject: Re: [PATCH] Export XSI sigpause
Message-ID: <20170614191527.GA8342@calimero.vinschen.de>
Reply-To: newlib@sourceware.org, cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, newlib@sourceware.org
References: <20170614154501.2508-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20170614154501.2508-1-yselkowi@redhat.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00055.txt.bz2


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 919

On Jun 14 10:45, Yaakov Selkowitz wrote:
> There are two common sigpause variants, both of which take an int argumen=
t.
> If you request _XOPEN_SOURCE or _GNU_SOURCE, you get the System V version,
> which removes the given signal from the process's signal mask; otherwise
> you get the BSD version, which sets the process's signal mask to the given
> value.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  newlib/libc/include/sys/signal.h       | 14 +++++++++++++-
>  winsup/cygwin/common.din               |  1 +
>  winsup/cygwin/include/cygwin/version.h |  3 ++-
>  winsup/cygwin/signal.cc                | 12 ++++++++++++
>  winsup/doc/posix.xml                   | 10 ++++++++--
>  5 files changed, 36 insertions(+), 4 deletions(-)

ACK, looks good.  Please add this to the cygwin release notes file, too
(in a 2nd commit).


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer
Red Hat

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQYtPAAoJEPU2Bp2uRE+grDgP/1oWsfHO/cj63bd298tkOt/J
fhiv/sAQMEP/+mTa5XP+f+iE4W899koVlNJDnk0+nNCZir0IbIgKkv9zg+/Y5Y1t
oU7N70ozzLpOTQGOGK7osrkvmAiCfqFuwYIr+ENf7GW4tEH/TZpudVnVzzNEVoVt
I2a+etKrpWfp6EUWtOCNOowE7bSvmuJa/10rT6RyNXxRv9QE0ECl3Cwrj9qQjtl9
YjMBSpS8e1HufSStxK/iqgfggQtyj09Q5u+K3g+YDK1A/iTwTBO2h0vsdhUDYqVy
1GJvZkXMjXNxd2kxw9kQ7DUurc2+Myrz+DYRgW6b8+cRP0tuxub09BfJ4dHB0dP8
xwPQ/k4hbUZhTMdhNUtG1jeILDWd5sgs5jHcYaQbXAYkNja6TjQFBPmmFk3PbhhB
zlUOrQkwDODjVCbWxia0oUZ5t2CpourIyNYys0CPgr9scGg8zufIUkXMmDHccL5j
r0R3YoSysn/Dv/mSrzMmULypiY0BiVqh88NS13Z9KNdw7+mlRmy8E2a8XKq8AJav
yHZuS1d44N6lQxE9Z4GJzb48chFp0ltPfLKZ9ZPLkMM5Q7K6Q/340Vb3osSlsD6k
+LEbO5PM0YhYEOdJx5oyrzX1ByOON8rbhrbB9CXNc8S1wmJ0tlDTPEg3QQjlhVZu
Tg06EdfgzatmpQ5f4Gb7
=y4ib
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
