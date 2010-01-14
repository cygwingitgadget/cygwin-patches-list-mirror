Return-Path: <cygwin-patches-return-6908-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9589 invoked by alias); 14 Jan 2010 13:03:09 -0000
Received: (qmail 9492 invoked by uid 22791); 14 Jan 2010 13:03:07 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta06.emeryville.ca.mail.comcast.net (HELO qmta06.emeryville.ca.mail.comcast.net) (76.96.30.56)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 14 Jan 2010 13:03:00 +0000
Received: from omta06.emeryville.ca.mail.comcast.net ([76.96.30.51]) 	by qmta06.emeryville.ca.mail.comcast.net with comcast 	id VQi01d00C16AWCUA6R2zh3; Thu, 14 Jan 2010 13:02:59 +0000
Received: from [192.168.0.106] ([24.10.244.244]) 	by omta06.emeryville.ca.mail.comcast.net with comcast 	id VR2y1d0015H651C8SR2zm7; Thu, 14 Jan 2010 13:02:59 +0000
Message-ID: <4B4F15FB.1050309@byu.net>
Date: Thu, 14 Jan 2010 13:03:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
References: <20100113212537.GB14511@calimero.vinschen.de>  <4B4E96D3.90300@byu.net>  <20100114114700.GC3428@calimero.vinschen.de> <20100114115711.GD3428@calimero.vinschen.de>
In-Reply-To: <20100114115711.GD3428@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1;  protocol="application/pgp-signature";  boundary="------------enigE8A96D3802D5BA1B3ACB3CAC"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00024.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE8A96D3802D5BA1B3ACB3CAC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 1164

According to Corinna Vinschen on 1/14/2010 4:57 AM:
>> time to do that via the O_CLOEXEC flag.
>=20
> Hang on, the file is closed anyway after the mmap call succeeded.
> That's not true for sem_open and shm_open, though.

Well, on Linux, it looks like sem_open does not need to keep the fd open.
 It all boils down to the question of any API that can hand a new fd back
to the user should have the ability to protect said fd with O_CLOEXEC at
creation time.

>=20
> However, what kind of cleanup did you mean?  There's no EINVAL specified
> in POSIX for invalid open flags and invalid flags are already filtered
> out before calling open.

In a multi-threaded app, any fd that is opened only temporarily, such as
the one in mq_open, should be opened with O_CLOEXEC, so that no other
thread can win a race and do a fork/exec inside the window when the
temporary fd was open.  So even though mq_open does not leak an fd to the
current process, it should pass O_CLOEXEC as part of its internal open()
call in order to avoid leaking the fd to unrelated child processes.

--=20
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net


--------------enigE8A96D3802D5BA1B3ACB3CAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 320

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAktPFgAACgkQ84KuGfSFAYCRmwCgqRlfTRowwoOQVKZCAxA33mkh
VckAnidRm66Yj1aToPGWUWV8o1Wl/Ia4
=m/DX
-----END PGP SIGNATURE-----

--------------enigE8A96D3802D5BA1B3ACB3CAC--
