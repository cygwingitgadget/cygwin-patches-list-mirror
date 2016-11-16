Return-Path: <cygwin-patches-return-8651-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14212 invoked by alias); 16 Nov 2016 14:01:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14196 invoked by uid 89); 16 Nov 2016 14:01:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.8 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Blake, blake, Hx-languages-length:1154, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 16 Nov 2016 14:01:38 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id B2AF37AE93	for <cygwin-patches@cygwin.com>; Wed, 16 Nov 2016 14:01:36 +0000 (UTC)
Received: from [10.3.116.206] (ovpn-116-206.phx2.redhat.com [10.3.116.206])	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uAGE1aZE032042	for <cygwin-patches@cygwin.com>; Wed, 16 Nov 2016 09:01:36 -0500
Subject: Re: Return the correct value for sysconf(_SC_PAGESIZE)
To: cygwin-patches@cygwin.com
References: <CAOTD34ZMkY=Sfp6-8AFDg_Q=7NZB2oS+=QthfWauoboP6=szfg@mail.gmail.com> <20161115145849.GA25086@calimero.vinschen.de> <CAOTD34ajMRiL0RMJTrVvzK8bMwAta3XJ8Pi7sk27ww1B4HLp3Q@mail.gmail.com> <20161115161955.GD25086@calimero.vinschen.de> <CAOTD34Y=YeufL-kYHUsrQg1oWOdk3F_-Z+H6GSiadRXJ9LuRwA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: url=http://people.redhat.com/eblake/eblake.gpg
Message-ID: <6f461a14-f503-1aa1-e417-a5b4b24606bc@redhat.com>
Date: Wed, 16 Nov 2016 14:01:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAOTD34Y=YeufL-kYHUsrQg1oWOdk3F_-Z+H6GSiadRXJ9LuRwA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="5GUfi4FUOO3J9DQmG7Qx9F4HwDlJA3Wkc"
X-IsSubscribed: yes
X-SW-Source: 2016-q4/txt/msg00009.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5GUfi4FUOO3J9DQmG7Qx9F4HwDlJA3Wkc
Content-Type: multipart/mixed; boundary="OnubcB7D253iSQEQpIAO0vAlQiLexBPGU";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: cygwin-patches@cygwin.com
Message-ID: <6f461a14-f503-1aa1-e417-a5b4b24606bc@redhat.com>
Subject: Re: Return the correct value for sysconf(_SC_PAGESIZE)
References: <CAOTD34ZMkY=Sfp6-8AFDg_Q=7NZB2oS+=QthfWauoboP6=szfg@mail.gmail.com>
 <20161115145849.GA25086@calimero.vinschen.de>
 <CAOTD34ajMRiL0RMJTrVvzK8bMwAta3XJ8Pi7sk27ww1B4HLp3Q@mail.gmail.com>
 <20161115161955.GD25086@calimero.vinschen.de>
 <CAOTD34Y=YeufL-kYHUsrQg1oWOdk3F_-Z+H6GSiadRXJ9LuRwA@mail.gmail.com>
In-Reply-To: <CAOTD34Y=YeufL-kYHUsrQg1oWOdk3F_-Z+H6GSiadRXJ9LuRwA@mail.gmail.com>


--OnubcB7D253iSQEQpIAO0vAlQiLexBPGU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1119

On 11/16/2016 07:56 AM, Erik Bray wrote:

>> There is no good reason to use the non-POSIXy page size.  It doesn't
>> help you in the least for any pagesize-related functionality.  Mmap
>> as well as malloc and friends only work with _SC_PAGESIZE sized pages.
>>
>> It sounds as if you're looking for a solution for which there's no
>> problem...
>=20
>=20
> FWIW the background here is that I'm working on porting psutil [1] to
> Cygwin, and trying to accomplish as much as *possible* through the
> POSIX interfaces without having to fall back on the Windows API.  It's
> actually a great exercise in what is and isn't possible with Cygwin :)
>=20
> In this case I was trying to compute process memory usage from
> /proc/<pid>/statm which gives values in page counts, so I need the
> page size (the actual page size) to compute the values in bytes.

If /proc/<pid>/statm is reporting memory in multiples that are not the
POSIX _SC_PAGESIZE, that is a bug in the statm file emulation that
should be fixed there.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--OnubcB7D253iSQEQpIAO0vAlQiLexBPGU--

--5GUfi4FUOO3J9DQmG7Qx9F4HwDlJA3Wkc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 604

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYLGa/AAoJEKeha0olJ0NqowIH/2UYwvuOlzNxB6OhoQlr2gj0
+ZjgKRIUBKx8JhqH9fMqgrCidaSmhYXKA7rbaO3SXtfks3YeLKd8EGHiVwWZKNro
5KmVLWj/D8vICo3jSgIQq2jysBkiHD8zi+H7GZwvyk8UfK9QcF6ImbnboW3fEeI0
wlGEv1TYmkF5sPAWkPRc1GpNGXI+Ir6fVBU9cvTyTArQZGdCUu1PolJSTHrCRYAy
xAQrXLGkaG4/f8SuzIeoLrbGgfXswHn6ppj7IBtyv0jTNmTaWxPNYygYkchpK0jP
+DNda+lBS62tDYFR1nqgAI253h2AAOTSBCYemYJKXbtOLqeYkP6YnyGiIHB341s=
=Vh5I
-----END PGP SIGNATURE-----

--5GUfi4FUOO3J9DQmG7Qx9F4HwDlJA3Wkc--
