Return-Path: <cygwin-patches-return-8311-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 42493 invoked by alias); 12 Feb 2016 20:34:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 42476 invoked by uid 89); 12 Feb 2016 20:34:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 12 Feb 2016 20:34:28 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])	by mx1.redhat.com (Postfix) with ESMTPS id AEDC1C0A8484	for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2016 20:34:27 +0000 (UTC)
Received: from [10.3.113.62] (ovpn-113-62.phx2.redhat.com [10.3.113.62])	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1CKYRll004964	for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2016 15:34:27 -0500
Subject: Re: [PATCH] cygwin: update child info magic
To: cygwin-patches@cygwin.com
References: <1455244717-12688-1-git-send-email-yselkowi@redhat.com> <20160212093359.GC19968@calimero.vinschen.de> <56BE0DFC.7000702@cygwin.com> <20160212171815.GA21562@calimero.vinschen.de> <56BE3B05.1030108@cygwin.com> <20160212203112.GA27302@calimero.vinschen.de>
From: Eric Blake <eblake@redhat.com>
Openpgp: url=http://people.redhat.com/eblake/eblake.gpg
Message-ID: <56BE41D3.6070807@redhat.com>
Date: Fri, 12 Feb 2016 20:34:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160212203112.GA27302@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="DGlsXaQ93iDmJva4PCDQ1bfmG28BwMcef"
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00017.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DGlsXaQ93iDmJva4PCDQ1bfmG28BwMcef
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 989

On 02/12/2016 01:31 PM, Corinna Vinschen wrote:

>>
>>  extern "C" {
>>  extern child_info *child_proc_info;
>> -extern child_info_spawn *spawn_info asm ("_" "child_proc_info");
>> -extern child_info_fork *fork_info asm ("_" "child_proc_info");
>> +extern child_info_spawn *spawn_info asm (
>> +                                        "_"
>> +                                        "child_proc_info");
>> +extern child_info_fork *fork_info asm (
>> +                                      "_"
>> +                                      "child_proc_info");
>>  }
>=20
> Is that deliberate or a bug?

Deliberate. gcc 5 now adds additional #line directives around every
macro expansion that came from a different file, so that you can more
easily track which files were involved in macro expansion.  The output
here is show with #line directives filtered out, but it is a gcc feature.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DGlsXaQ93iDmJva4PCDQ1bfmG28BwMcef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 604

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWvkHTAAoJEKeha0olJ0Nq1iMH/3Mz8Y00ZaHxYA2hTVCpYn1s
SEar2ZrmyiAEU7/wi31Y2pByBGM8ORFMFED+4dQurcNQ5ETuFDnIXcRf0Kkj3+wM
7pQ2F3FJwD/fGKylic8fE842e7mPXACiIGgUG5to/PRgPnK5aBu0K6Os3n0KOR+c
aEy6Rr7GOaRvhIfhGx2TEZVUS8Due52+tkxhe+12XGs9zy5IlmA37U5riJv8m3TA
uPvy/pO9H/2sCTCtoIEXqKIYQVJ3Hq1Uv25iSjUhhKyhFNcMuU+1uFnpAGYd7ona
8K82v83FApTrbxTjiVcnnFNUtDQ5AR+t2fbECR/4urtgNj4amk+OxDSER4rQbOc=
=KFto
-----END PGP SIGNATURE-----

--DGlsXaQ93iDmJva4PCDQ1bfmG28BwMcef--
