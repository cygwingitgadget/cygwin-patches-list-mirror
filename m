Return-Path: <cygwin-patches-return-9723-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70858 invoked by alias); 24 Sep 2019 20:12:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 70828 invoked by uid 89); 24 Sep 2019 20:12:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 24 Sep 2019 20:12:18 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 0E13C86668;	Tue, 24 Sep 2019 20:12:17 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 84E445C21F;	Tue, 24 Sep 2019 20:12:16 +0000 (UTC)
Subject: Re: [PATCH v2] Cygwin: rmdir: fail if last component is a symlink, as on Linux
To: Ken Brown <kbrown@cornell.edu>, "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20190924175530.1565-1-kbrown@cornell.edu> <5a1ced2e-ad71-0765-03af-a7bb421acad0@redhat.com> <b3edf101-b719-0a82-6ad3-54f0c1afc5ad@cornell.edu>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <90b9e16d-a395-1736-fe20-c7a1f37a02bd@redhat.com>
Date: Tue, 24 Sep 2019 20:12:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b3edf101-b719-0a82-6ad3-54f0c1afc5ad@cornell.edu>
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="XwK6IjWLzD4BhTXTlvtR572Rje3yxklGU"
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00243.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XwK6IjWLzD4BhTXTlvtR572Rje3yxklGU
Content-Type: multipart/mixed; boundary="bNsiyRd3A6KVsQs9S9LqIZcjzhrYPPT1a";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Ken Brown <kbrown@cornell.edu>,
 "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Message-ID: <90b9e16d-a395-1736-fe20-c7a1f37a02bd@redhat.com>
Subject: Re: [PATCH v2] Cygwin: rmdir: fail if last component is a symlink, as
 on Linux
References: <20190924175530.1565-1-kbrown@cornell.edu>
 <5a1ced2e-ad71-0765-03af-a7bb421acad0@redhat.com>
 <b3edf101-b719-0a82-6ad3-54f0c1afc5ad@cornell.edu>
In-Reply-To: <b3edf101-b719-0a82-6ad3-54f0c1afc5ad@cornell.edu>


--bNsiyRd3A6KVsQs9S9LqIZcjzhrYPPT1a
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Content-length: 1958

On 9/24/19 2:28 PM, Ken Brown wrote:

>>
>> Looks okay to me.
>=20
> Thanks.  Does the "intentionally ignoring POSIX" part apply to rmdir also=
?  I=20
> didn't find it easy to decipher POSIX.
>=20
> Even for mkdir, POSIX says, "If path names a symbolic link, mkdir() shall=
 fail=20
> and set errno to [EEXIST]."  See=20
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/mkdir.html#tag=
_16_325.
>=20
> But I'm not clear on how POSIX decides whether "path names a symbolic lin=
k" in=20
> the case where the last component is a symlink followed by a slash.

POSIX says that "/path/to/symlink" names a symlink, but
"/path/to/symlink/" (attempts to) name the directory at the contents of
the symlink.  In mkdir("/path/to/symlink/", if symlink is dangling, then
the official result is to create an empty directory at the target of the
symlink, so that symlink is no longer dangling.  In
rmdir("/path/to/symlink/"), if an empty directory exists at that
location, the directory must be removed leaving symlink dangling.

The POSIX rules are self-consistent and match what Solaris does, but it
is surprising action-at-a-distance.  Linux kernel developers have
repeatedly stated that they are unwilling to implement that behavior,
and would much rather have mkdir("/path/to/symlink/") fail with EEXIST
(the dangling symlink exists, and we can't create a directory to replace
it, nor will we create a directory to make the symlink non-dangling),
and similarly rmdir("/path/to/symlink/") fail because symlink is not a
directory, even though symlink/ resolves to a directory.

So even though we are knowingly violating POSIX, having both functions
be consistent with Linux is reasonable.  (I still hope that POSIX will
relax its stance to allow both Solaris AND Linux behaviors, but that's
not going to happen any time soon...)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--bNsiyRd3A6KVsQs9S9LqIZcjzhrYPPT1a--

--XwK6IjWLzD4BhTXTlvtR572Rje3yxklGU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 488

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2KeJ8ACgkQp6FrSiUn
Q2pznAf+PDjS0PcBfF3W6j1VKrNP2tMbwdhfp7l3+exI5ri7AeWoOp6kQ0A7UlZM
86wAghoTbAQinpyfjJ6Ps0TKEZS+PjBkJ1sSX6d7ixRrLqPdHdSy+3dEqABK103s
THwf/4cEgLK2hdRRzmqiScVveTEWe/pajWvqzVdrMbZIpXFbrt5qLE+Wqh50JXNq
VG+MWv39pDy2oQjnO/eFYXKnd/50UKiJP6uu6jTXnX/Y98FGCwR5c1AbGa8L751Q
VOaSn1BbRSt7CH087bM7rIPs9E0iFhWmqdByQ4wP37JvMg+vaHspDkimGs2FnHVN
OFtAWa/HxKwmIRJAll8KbJ8P91Fotg==
=PIeu
-----END PGP SIGNATURE-----

--XwK6IjWLzD4BhTXTlvtR572Rje3yxklGU--
