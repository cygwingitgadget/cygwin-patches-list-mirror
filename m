Return-Path: <cygwin-patches-return-9008-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 117373 invoked by alias); 19 Jan 2018 07:28:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 117361 invoked by uid 89); 19 Jan 2018 07:28:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=incentive, H*M:cygwin, H*Ad:U*yselkowitz, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jan 2018 07:28:49 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 2F5A78B104	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 07:28:48 +0000 (UTC)
Received: from [10.10.120.72] (ovpn-120-72.rdu2.redhat.com [10.10.120.72])	by smtp.corp.redhat.com (Postfix) with ESMTPS id CE0B3600C0	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 07:28:47 +0000 (UTC)
Subject: Re: [PATCH] cygwin: make sys/socket.h completely visible from netinet/in.h
To: cygwin-patches@cygwin.com
References: <20180116032447.14572-1-yselkowi@redhat.com> <20180116093004.GC3009@calimero.vinschen.de>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <46dd6b85-ecb2-02f2-7da4-45c44a782559@cygwin.com>
Date: Fri, 19 Jan 2018 07:28:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180116093004.GC3009@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="3NbPhUMNAdmVGEsUGwFVaDRQyy1Hvn2dt"
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00016.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3NbPhUMNAdmVGEsUGwFVaDRQyy1Hvn2dt
Content-Type: multipart/mixed; boundary="EsaiDRa8Xhd4XylbQkFcFsccOmV9GZxs8";
 protected-headers="v1"
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: cygwin-patches@cygwin.com
Message-ID: <46dd6b85-ecb2-02f2-7da4-45c44a782559@cygwin.com>
Subject: Re: [PATCH] cygwin: make sys/socket.h completely visible from
 netinet/in.h
References: <20180116032447.14572-1-yselkowi@redhat.com>
 <20180116093004.GC3009@calimero.vinschen.de>
In-Reply-To: <20180116093004.GC3009@calimero.vinschen.de>


--EsaiDRa8Xhd4XylbQkFcFsccOmV9GZxs8
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
Content-length: 502

On 2018-01-16 03:30, Corinna Vinschen wrote:
> You don't explain the incentive behind removing sys/time.h.=20

POSIX does not mention the inclusion of <sys/time.h> in <sys/socket.h>
or <netinet/in.h>, nor is there anything in the latter two that would
require the former.  I can make this clearer in the commit message.

> Sure this doesn't break anything?
Without a mass scratch rebuild I can never be 100% sure. :-)  But so
far, no issues, and the first part of this definitely helps.

--=20
Yaakov


--EsaiDRa8Xhd4XylbQkFcFsccOmV9GZxs8--

--3NbPhUMNAdmVGEsUGwFVaDRQyy1Hvn2dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 228

-----BEGIN PGP SIGNATURE-----

iHQEARECADQWIQRFYAu5jKh4qpenARn/IK+aZu4flAUCWmGeLhYceXNlbGtvd2l0
ekBjeWd3aW4uY29tAAoJEP8gr5pm7h+URJ4An2PAMi6NlM7+ZjRuGbFHT0ix+2Ja
AJ9B6dWWrCjtD3AQyvQ4WtiifjJP3A==
=mzUz
-----END PGP SIGNATURE-----

--3NbPhUMNAdmVGEsUGwFVaDRQyy1Hvn2dt--
