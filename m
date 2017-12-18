Return-Path: <cygwin-patches-return-8975-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53968 invoked by alias); 18 Dec 2017 17:07:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53957 invoked by uid 89); 18 Dec 2017 17:07:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 18 Dec 2017 17:07:52 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 3A15A4900F	for <cygwin-patches@cygwin.com>; Mon, 18 Dec 2017 17:07:51 +0000 (UTC)
Received: from [10.10.120.183] (ovpn-120-183.rdu2.redhat.com [10.10.120.183])	by smtp.corp.redhat.com (Postfix) with ESMTPS id DF98169414	for <cygwin-patches@cygwin.com>; Mon, 18 Dec 2017 17:07:50 +0000 (UTC)
Subject: Re: [PATCH] Implement sigtimedwait (revised)
To: cygwin-patches@cygwin.com
References: <20171215010555.2500-1-mark@maxrnd.com> <20171218091700.GA11071@calimero.vinschen.de> <Pine.BSF.4.63.1712180131070.73988@m0.truegem.net> <20171218104855.GA7214@calimero.vinschen.de>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <d2824b5f-b5a3-9e24-64bf-455668ab149b@cygwin.com>
Date: Mon, 18 Dec 2017 17:07:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171218104855.GA7214@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="d3l6lWmESSi40w1LCq2fGP9KvIF3T3oUo"
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00105.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d3l6lWmESSi40w1LCq2fGP9KvIF3T3oUo
Content-Type: multipart/mixed; boundary="diX8Gg9keeCdeJurnJdiMhl2MCWGF5FtQ";
 protected-headers="v1"
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: cygwin-patches@cygwin.com
Message-ID: <d2824b5f-b5a3-9e24-64bf-455668ab149b@cygwin.com>
Subject: Re: [PATCH] Implement sigtimedwait (revised)
References: <20171215010555.2500-1-mark@maxrnd.com>
 <20171218091700.GA11071@calimero.vinschen.de>
 <Pine.BSF.4.63.1712180131070.73988@m0.truegem.net>
 <20171218104855.GA7214@calimero.vinschen.de>
In-Reply-To: <20171218104855.GA7214@calimero.vinschen.de>


--diX8Gg9keeCdeJurnJdiMhl2MCWGF5FtQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
Content-length: 705

On 2017-12-18 04:48, Corinna Vinschen wrote:
> On Dec 18 01:34, Mark Geisert wrote:
>> On Mon, 18 Dec 2017, Corinna Vinschen wrote:
>>> Hi Mark,
>> [...]
>>> as I wrote on Friday, the patch looks good to me.  I just need a
>>> contributors license agreement from you per the "Before you get started"
>>> section on https://cygwin.com/contrib.html
>>
>> Hi Corinna,
>> Y'all should have one from me on file already.  Back in Feb/Mar 2016 I d=
id
>> some work on the gmon profiler and documentation for same.
>=20
> I can't find it, neither on cygwin-developers nor on cygwin-patches.
> AFAICS, I missed to ask you for one back in 2016.

It was sent through the old process in February 2016.

--=20
Yaakov


--diX8Gg9keeCdeJurnJdiMhl2MCWGF5FtQ--

--d3l6lWmESSi40w1LCq2fGP9KvIF3T3oUo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 228

-----BEGIN PGP SIGNATURE-----

iHQEARECADQWIQRFYAu5jKh4qpenARn/IK+aZu4flAUCWjf15RYceXNlbGtvd2l0
ekBjeWd3aW4uY29tAAoJEP8gr5pm7h+UKoEAnitR3d8g7DTe5nD4qZ02HsD2usWM
AJ9gl5+AavxRzx7aJScN1SdvVrecHA==
=GhGl
-----END PGP SIGNATURE-----

--d3l6lWmESSi40w1LCq2fGP9KvIF3T3oUo--
