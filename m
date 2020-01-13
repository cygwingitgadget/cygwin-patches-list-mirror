Return-Path: <cygwin-patches-return-9907-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27663 invoked by alias); 13 Jan 2020 15:28:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27653 invoked by uid 89); 13 Jan 2020 15:28:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:U*cygwin-patches, Ken, act
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 15:28:13 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MacWq-1jOQds1XP0-00cBLS for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 16:28:10 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A279EA806B2; Mon, 13 Jan 2020 16:28:09 +0100 (CET)
Date: Mon, 13 Jan 2020 15:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
Message-ID: <20200113152809.GE5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191229175637.1050-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20191229175637.1050-1-kbrown@cornell.edu>
X-SW-Source: 2020-q1/txt/msg00013.txt


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1718

Hi Ken,

On Dec 29 17:56, Ken Brown wrote:
> Currently, opening a symlink with O_NOFOLLOW fails with ELOOP.
> Following Linux, the first patch in this series allows the call to
> succeed if O_PATH is also specified.
>=20
> According to the Linux man page for 'open', the file descriptor
> returned by the call should be usable as the dirfd argument in calls
> to fstatat and readlinkat with an empty pathname, to have
> the calls operate on the symbolic link.  The second and third patches
> achieve this.  For fstatat, we do this by adding support
> for the AT_EMPTY_PATH flag.
>=20
> Note: The man page mentions fchownat and linkat also.  linkat already
> supports the AT_EMPTY_PATH flag, so nothing needs to be done.  But I
> don't understand how this could work for fchownat, because fchown
> fails with EBADF if its fd argument was opened with O_PATH.  So I
> haven't touched fchownat.

It was never supposed to work that way.  We can make fchownat work
with AT_EMPTY_PATH, but using it on a file opened with O_PATH
contradicts the Linux open(2) man page, afaics:

 O_PATH (since Linux 2.6.39)
  Obtain a file descriptor that can be used for two  purposes:  to
  indicate a location in the filesystem tree and to perform opera=E2=80=90
  tions that act purely at the file descriptor  level.   The  file
  itself  is not opened, and other file operations (e.g., read(2),
  write(2), fchmod(2), fchown(2), fgetxattr(2), ioctl(2), mmap(2))
                       ^^^^^^^^^
  fail with the error EBADF.
  ^^^^^^^^^           ^^^^^

That'd from the current F31 man pages.

> Am I missing something?

Good question.  Let me ask in return, did *I* now miss something?


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4cjIkACgkQ9TYGna5E
T6DS1BAApO+yTOGduKFJxGOM/UFfSw1jk9Ox7CmbgJLlFPtk+fKC7FV0QeMZ3sEm
t480ss1rmcy0YkuuMRy3P/hc4/EHK21uPkzcjHOKYuCG1fQ3+qyD1J44jQTD7VNc
lHI6GEJ/E20RIB7IqdN03IaLQLMXsvILgulifCWYuDXGP9ETnhMulAoqU0Eo3swL
WBpozzQnFJek1itaIpQgt1sfaTWo9L5kYZYZtLoYaLlwMUtT7YMgxpDrNwr80KhS
mqyxyGZjg7dvkM1ybTYuKt6iQl4goPa12TawlBeReR93fuGeqTsE8HTBF+sQaQDo
HXgxnxy695aLtFtRKfobrEnkv9ZZurw/Vpfcl8S7x3QFXvOVVJ+4Db+1LpsH10fs
jfsaYFPAmRv8hghQtPtRQgVZBEVDLfM1B3tkspxfhguj+Z4H9melmGoE4GweCxNL
v9u9J5b4g9CXfN0MtniD0hDI/HfKi6/aiHvomSpvrOb4ehGgU6aRRHWpc8QeOF3d
TZCewFdu1J7MKttpnTm7Yyky0xDH3p3a3vY/PvEB1oU401e3+FNuiM2mfTWKJNvB
xs7LUx1w6gPPQ9n2QRh1OVN0O+9cXlTma4Ta20IZM3qxQ43Z2/p9f7AYAhpROKsF
2eQpPW1wRciGyOiSKjTkm9CXFGjK/BD0nKMYryt5MGxt/SubbtA=
=RvyM
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
