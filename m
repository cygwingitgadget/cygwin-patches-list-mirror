Return-Path: <cygwin-patches-return-8513-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 83686 invoked by alias); 30 Mar 2016 18:55:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 83666 invoked by uid 89); 30 Mar 2016 18:55:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=Seriously, Haubenwallner, haubenwallner, HTo:U*cygwin-patches
X-HELO: dancol.org
Received: from dancol.org (HELO dancol.org) (96.126.100.184) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Wed, 30 Mar 2016 18:55:33 +0000
Received: from [2620:10d:c090:180::760e] (helo=[IPv6:2620:10d:c081:1103:2ab2:bdff:fe1c:db58])	by dancol.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)	(Exim 4.84)	(envelope-from <dancol@dancol.org>)	id 1alLHA-0004Nn-2a	for cygwin-patches@cygwin.com; Wed, 30 Mar 2016 11:55:32 -0700
Subject: Re: [PATCH 0/6] Protect fork() against dll- and exe-updates.
To: cygwin-patches@cygwin.com
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
From: Daniel Colascione <dancol@dancol.org>
Message-ID: <56FC211E.4030204@dancol.org>
Date: Wed, 30 Mar 2016 18:55:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="4m2rw5GWJ3qH3x6vCmT9dhfVaA4ATbitO"
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00219.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4m2rw5GWJ3qH3x6vCmT9dhfVaA4ATbitO
Content-Type: multipart/mixed; boundary="PahgggwSXL5Qi4EKFfnsfC8oAouTMaXQa"
From: Daniel Colascione <dancol@dancol.org>
To: cygwin-patches@cygwin.com
Message-ID: <56FC211E.4030204@dancol.org>
Subject: Re: [PATCH 0/6] Protect fork() against dll- and exe-updates.
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>


--PahgggwSXL5Qi4EKFfnsfC8oAouTMaXQa
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-length: 581



On 03/30/2016 11:53 AM, Michael Haubenwallner wrote:
> Hi,
>=20
> this is the updated and split series of patches to use hardlinks
> for creating the child process by fork(), in reply to
> https://cygwin.com/ml/cygwin-developers/2016-01/msg00002.html
> https://cygwin.com/ml/cygwin-developers/2016-03/msg00005.html
> http://thread.gmane.org/gmane.os.cygwin.devel/1378
>=20
> Thanks for review!
> /haubi/
>=20
>=20

Creating a new process now requires a write operation on the filesystem
hosting the binary? Seriously? I don't think that's worth it no matter
the other benefits.


--PahgggwSXL5Qi4EKFfnsfC8oAouTMaXQa--

--4m2rw5GWJ3qH3x6vCmT9dhfVaA4ATbitO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/CEeAAoJEN4WImmbpWBlMv4P/iLfcMnFRVzncCN4kAoL1Oyo
9OoTUIFy9HNPvbsNHR5ru87TpMqaoieyD7k/wEP0WGOujGLs7k15LRcCiBYSSFgk
7JJ6DyEfJpR+X51az6xK63E7e4SFM6chmzoJ6wyNzWOiIyvr5glDzZh1RDjegwum
urcxUTSYzQkFJyd3W7ETUBH3pC28gMZaLp4gznedHpWnSfHgGOnuUirrlmwsOxN1
a0dbVfnW3P9INFukmgPzElYvw+6rMDBsi1dtSCqUJeG+jXOo0ra06p8CILcF3A9h
n1CHIDVcvO6SewI2qkOWt8lisliAJwVfwto3RZUsRX+Uf5+5F1KydZ3FUo19qral
145kobDbHav1hU7M+kNjT3+xw83rq+NIWqZA++uQqi4G6LKRU+qLk4+z2B0uPZ2j
H1PPp3Cjt1+Jw1USNnvr43cLWWBDff2oqVPJhQNGSdhF4t3bWLb8wfDVTyAxsBZF
DMKE/BHKKSzcAgnqJSKb+W/+YAxboM3QP7iMB84lmMOJ0ePhCyg6UaAxpDmkOTLX
KYHjLqNuH6mbL7USOVpTWWbmRCKY3EMWRZ/NErDVTAbc0Ier4rLxyQ54uhaFOXxh
0jCqD86Hj5MCq38v/MgFfaMkE2fXaqO7l12FUZTOa64DlaqxnoYxAedffnr9/jNK
VaT+OksyulXv1xuKMx/U
=77op
-----END PGP SIGNATURE-----

--4m2rw5GWJ3qH3x6vCmT9dhfVaA4ATbitO--
