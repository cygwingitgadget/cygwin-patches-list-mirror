Return-Path: <cygwin-patches-return-8601-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48640 invoked by alias); 14 Jul 2016 18:39:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48629 invoked by uid 89); 14 Jul 2016 18:39:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-3.2 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, our
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 14 Jul 2016 18:39:31 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id E90EFC05AA42	for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2016 18:39:29 +0000 (UTC)
Received: from [10.3.116.64] (ovpn-116-64.phx2.redhat.com [10.3.116.64])	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u6EIdTwo023403	for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2016 14:39:29 -0400
Subject: Re: [PATCH] Fix 32-bit SSIZE_MAX
To: cygwin-patches@cygwin.com
References: <1468443748-25335-1-git-send-email-eblake@redhat.com> <20160714150944.GB21341@calimero.vinschen.de>
From: Eric Blake <eblake@redhat.com>
Openpgp: url=http://people.redhat.com/eblake/eblake.gpg
Message-ID: <5787DC61.5040109@redhat.com>
Date: Thu, 14 Jul 2016 18:39:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20160714150944.GB21341@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="gdMLaL68Px6WU2XRFBtFHwjVriraSCQHN"
X-IsSubscribed: yes
X-SW-Source: 2016-q3/txt/msg00009.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gdMLaL68Px6WU2XRFBtFHwjVriraSCQHN
Content-Type: multipart/mixed; boundary="42KO7Ac6C15IFVXcOcla4Swo1xkeJoV5F"
From: Eric Blake <eblake@redhat.com>
To: cygwin-patches@cygwin.com
Message-ID: <5787DC61.5040109@redhat.com>
Subject: Re: [PATCH] Fix 32-bit SSIZE_MAX
References: <1468443748-25335-1-git-send-email-eblake@redhat.com>
 <20160714150944.GB21341@calimero.vinschen.de>
In-Reply-To: <20160714150944.GB21341@calimero.vinschen.de>


--42KO7Ac6C15IFVXcOcla4Swo1xkeJoV5F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1248

On 07/14/2016 09:09 AM, Corinna Vinschen wrote:
> On Jul 13 15:02, Eric Blake wrote:
>> POSIX requires that SSIZE_MAX have the same type as ssize_t, but
>> on 32-bit, we were defining it as a long even though ssize_t
>> resolves to an int.  It also requires that SSIZE_MAX be usable
>> via preprocessor #if, so we can't cheat and use a cast.
>>
>> If this were newlib, I'd have had to hack _intsup.h to probe the
>> qualities of size_t (via gcc's __SIZE_TYPE__), similar to how we
>> already probe the qualities of int8_t and friends, then cross our
>> fingers that ssize_t happens to have the same rank (most systems
>> do, but POSIX permits a system where they differ such as size_t
>> being long while ssize_t is int).  Unfortunately gcc gives us
>> neither __SSIZE_TYPE__ nor __SSIZE_MAX__.  On the other hand, our
>> limits.h is specific to cygwin, we can just shortcut to the
>> correct results rather than being generic to all possible ABI.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  winsup/cygwin/include/limits.h | 10 +++++++++-

> Looks good, please apply.

And I remembered to update the release notes, too.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--42KO7Ac6C15IFVXcOcla4Swo1xkeJoV5F--

--gdMLaL68Px6WU2XRFBtFHwjVriraSCQHN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 604

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJXh9xhAAoJEKeha0olJ0NqoBcIAJtrle7Z9Fjb9keuThUV54Fy
nrqDo/GkfPLNm1fTJsNuD+vpCX0BFYS5ty/cNy1ma2UO1DrieZwS7bNcCJEFfaZk
JfvMotNolIXGfJmXloQx9IxZyYRKRUJmPQ60B5vbtnq8IwayZbdQcHvdteYkF43A
AbnAd0uQkcw74aTwh8q5f1WNERSFzBJXH149jZNNQoXrSqxoip4hWKm6W3CViYAT
TSt0duRjPa1anh3WqcBInffMRKd41LaxE+m8OsxkhfidiiF03DWA5XmLWcT3o6PA
mQ38iVWdZIkLr1/ZSmSDZcyi05tBTRQP6AlDJ7aP1QjmIZUpqJrys+KHbNgggFs=
=gyBQ
-----END PGP SIGNATURE-----

--gdMLaL68Px6WU2XRFBtFHwjVriraSCQHN--
