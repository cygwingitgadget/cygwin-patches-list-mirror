Return-Path: <cygwin-patches-return-7919-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29937 invoked by alias); 5 Dec 2013 13:45:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29924 invoked by uid 89); 5 Dec 2013 13:45:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.2 required=5.0 tests=AWL,BAYES_50,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mx1.redhat.com
Received: from Unknown (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Dec 2013 13:45:30 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB5DjNUB010996	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Thu, 5 Dec 2013 08:45:23 -0500
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id rB5DjMWG007950	for <cygwin-patches@cygwin.com>; Thu, 5 Dec 2013 08:45:23 -0500
Message-ID: <52A08372.7080402@redhat.com>
Date: Thu, 05 Dec 2013 13:45:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: fix off-by-one in dup2
References: <52437121.1070507@redhat.com> <20131204093238.GA28314@calimero.vinschen.de> <20131204113626.GB29444@calimero.vinschen.de> <20131204120408.GC29444@calimero.vinschen.de> <20131204170028.GA2590@ednor.casa.cgf.cx> <20131204172324.GA13448@calimero.vinschen.de> <20131204175108.GB2590@ednor.casa.cgf.cx>
In-Reply-To: <20131204175108.GB2590@ednor.casa.cgf.cx>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="Qgj0LIL5ip7KE8OhfepmXcqs0u1a4nF8O"
X-IsSubscribed: yes
X-SW-Source: 2013-q4/txt/msg00015.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qgj0LIL5ip7KE8OhfepmXcqs0u1a4nF8O
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 2074

On 12/04/2013 10:51 AM, Christopher Faylor wrote:

>>>> One question, though.  Assuming start is =3D=3D size, then the current=
 code
>>>> in CVS extends the fd table by only 1.  If that happens often, the
>>>> current code would have to call ccalloc/memcpy/cfree a lot.  Wouldn't
>>>> it in fact be better to extend always by at least NOFILE_INCR, and to
>>>> extend by (1 + start - size) only if start is > size + NOFILE_INCR?
>>>> Something like
>>>>
>>>>  size_t extendby =3D (start >=3D size + NOFILE_INCR) ? 1 + start - siz=
e : NOFILE_INCR;
>>>>

Always increasing by a minimum of NOFILE_INCR is wrong in one case - we
should never increase beyond OPEN_MAX_MAX (currently 3200).  dup2(0,
3199) should succeed (unless it fails with EMFILE due to rlimit, but we
already know that our handling of setrlimit(RLIMIT_NOFILE) is still a
bit awkward); but dup2(0, 3200) must always fail with EBADF.  I think
the code in CVS is still wrong: we want to increase to the larger of the
value specified by the user or NOFILE_INCR to minimize repeated calloc,
but we also need to cap the increase to be at most OPEN_MAX_MAX
descriptors, to avoid having a table larger than what the rest of our
code base will support.

Not having NOFILE_INCR free slots after a user allocation is not fatal;
it means that the first allocation to a large number will not have tail
padding, but the next allocation to fd+1 will allocate NOFILE_INCR slots
rather than just one.  My original idea of MAX(NOFILE_INCR, start -
size) expresses that.

>>
>> That might be helpful.  Tcsh, for instance, always dup's it's std
>> descriptors to the new fds 15-19.  If it does so in this order, it would
>> have to call extend 5 times.
>=20
> dtable.h:#define NOFILE_INCR    32
>=20
> It shouldn't extend in that scenario.  The table starts with 32
> elements.

Rather, the table starts with 256 elements; which is why dup2 wouldn't
crash until dup'ing to 256 or greater before I started touching this.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Qgj0LIL5ip7KE8OhfepmXcqs0u1a4nF8O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 621

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJSoINyAAoJEKeha0olJ0NqELQH/jrzathPeDVGjQpAUizxIOZD
gfRCM6YWIrxiJEaa/TNmyw5p3omt29OGb0e9OIknJxvmJm0R0Sc5ZLpMk5e/sb/5
oat4AGln/vmqZOhDyf6bAOMtujc63wOfRR9bhNVLiq3MxpUEgnDBqFM4BSeGYa56
Gxe48cM9DiApRUGKo3VDvXQEk/WHDripJyeeqDz8zPsAIYuiFrynbdzo957jusqe
h4DdhxGuMtyHKUHn2RLkn9maIG9FEeVgqCFhQD47P4AfyNVCBt7PIu19rUWf/BQ8
NJuE8U8+CL5YYeFa+m4+0hfjMLive4cTmbww/mzjvngfluxsCqN48fmtqM0qw4g=
=7Edl
-----END PGP SIGNATURE-----

--Qgj0LIL5ip7KE8OhfepmXcqs0u1a4nF8O--
