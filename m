Return-Path: <cygwin-patches-return-9218-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85591 invoked by alias); 23 Mar 2019 19:49:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85527 invoked by uid 89); 23 Mar 2019 19:49:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.5 required=5.0 tests=AWL,BAYES_00,KAM_NUMSUBJECT,SPF_HELO_PASS autolearn=no version=3.3.1 spammy=HX-Languages-Length:929, powered, Blake, blake
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Mar 2019 19:49:31 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 833FA3086204	for <cygwin-patches@cygwin.com>; Sat, 23 Mar 2019 19:49:30 +0000 (UTC)
Received: from [10.3.116.65] (ovpn-116-65.phx2.redhat.com [10.3.116.65])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B02760BF2	for <cygwin-patches@cygwin.com>; Sat, 23 Mar 2019 19:49:29 +0000 (UTC)
Subject: Re: [PATCH] default ps -W process start time to system boot time when inaccessible, 0, -1
To: cygwin-patches@cygwin.com
References: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca> <87d0mh5x3u.fsf@Rainer.invalid> <20190323183653.GB3471@calimero.vinschen.de> <874l7tbfh6.fsf@Rainer.invalid>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5e6bcb45-4182-7eab-7333-d4a7e7e8cf9a@redhat.com>
Date: Sat, 23 Mar 2019 19:49:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <874l7tbfh6.fsf@Rainer.invalid>
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="EW0kBF9EScEbdfyX1moZ2yCa7CojgQ3ee"
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00028.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EW0kBF9EScEbdfyX1moZ2yCa7CojgQ3ee
Content-Type: multipart/mixed; boundary="Kd5Kho5qNnAJjbH9F0K3ucDW5OXqy6nWl";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: cygwin-patches@cygwin.com
Message-ID: <5e6bcb45-4182-7eab-7333-d4a7e7e8cf9a@redhat.com>
Subject: Re: [PATCH] default ps -W process start time to system boot time when
 inaccessible, 0, -1
References: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca>
 <87d0mh5x3u.fsf@Rainer.invalid> <20190323183653.GB3471@calimero.vinschen.de>
 <874l7tbfh6.fsf@Rainer.invalid>
In-Reply-To: <874l7tbfh6.fsf@Rainer.invalid>


--Kd5Kho5qNnAJjbH9F0K3ucDW5OXqy6nWl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Content-length: 858

On 3/23/19 1:41 PM, Achim Gratz wrote:
> Corinna Vinschen writes:
>>> replacing one lie with another that is less easy to spot doesn't sound
>>> the right thing to do.  How about ps if reported "N/A" or something to
>>> that effect instead?
>>
>> 1 Jan 1970 may also be a good hint...
>=20
> Well, that was the point: I can deduce just from that date that ps
> didn't actually get data for the start time.  If it starts replacing
> this with the start time of the system instead, it might take a while
> for me to see what is going on.

On the other hand, the lie is pretty realistic - the program can't have
been running longer than your computer has been powered on, and all such
affected programs will have the same timestamp.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Kd5Kho5qNnAJjbH9F0K3ucDW5OXqy6nWl--

--EW0kBF9EScEbdfyX1moZ2yCa7CojgQ3ee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 488

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyWjcgACgkQp6FrSiUn
Q2rT8Af9HPiEJh4ycZW7M25yWoOWExBlfxlyv6gtyNHQ6syeHHBSnpZJg9UL574F
X340CmMic2zeT6lTVC5ZyDmwsC+fH7KSnQV6NF9WHzVV/kcST/XQLoeW70v9smZ6
OLOcyRpFMCnIF8ZE2n0Q+Py8TdoO4e/NtBqHJhD5aGJsDxVy8UoieMdosCTSotYz
PV6aoPte6FABZo/Jqr2EW5FeE6n13ryzBxv73GqPkmpJbor6GuDUrRESmaG6/NoQ
BOLSOyRQN/jAMv7LJbmI+jsJBnqFCPCd1aqv+eg3R3lc495jM9mMC5UnndYOOzdt
OFGlFL62oZ6+v1kyvJxBQn9mJbrZAw==
=vSL1
-----END PGP SIGNATURE-----

--EW0kBF9EScEbdfyX1moZ2yCa7CojgQ3ee--
