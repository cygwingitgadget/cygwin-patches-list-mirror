Return-Path: <cygwin-patches-return-9999-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38715 invoked by alias); 24 Jan 2020 10:29:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 38702 invoked by uid 89); 24 Jan 2020 10:29:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-112.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=act, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 24 Jan 2020 10:29:16 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MCsgS-1imAlm0ONk-008tAF for <cygwin-patches@cygwin.com>; Fri, 24 Jan 2020 11:29:14 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C1C7CA80722; Fri, 24 Jan 2020 11:29:13 +0100 (CET)
Date: Fri, 24 Jan 2020 10:29:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Fix the O_PATH support for FIFOs
Message-ID: <20200124102913.GF263143@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200123163015.12354-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <20200123163015.12354-1-kbrown@cornell.edu>
X-SW-Source: 2020-q1/txt/msg00105.txt


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2076

On Jan 23 16:31, Ken Brown wrote:
> Commit aa55d22c, "Cygwin: honor the O_PATH flag when opening a FIFO",
> fixed a hang but otherwise didn't accomplish the purpose of the O_PATH
> flag as stated in the Linux man page for open(2):
>=20
>     Obtain a file descriptor that can be used for two purposes: to
>     indicate a location in the filesystem tree and to perform
>     operations that act purely at the file descriptor level.  The
>     file itself is not opened, and other file operations (e.g.,
>     read(2), write(2), fchmod(2), fchown(2), fgetxattr(2),
>     ioctl(2), mmap(2)) fail with the error EBADF.
>=20
>     [The man page goes on to describe operations that *can* be
>     performed: close(2), fchdir(2), fstat(2),....]
>=20
>     Opening a file or directory with the O_PATH flag requires no
>     permissions on the object itself (but does require execute
>     permission on the directories in the path prefix).
>=20
> The first problem in the current implementation is that if open(2) is
> called on a FIFO, fhandler_base::device_access_denied is called and
> tries to open the FIFO with read access, which isn't supposed to be
> required.  This is fixed by the first patch in this series.
>=20
> The second patch makes fhandler_fifo::open call fhandler_base::open_fs
> if O_PATH is set, so that we actually obtain a handle that can be used
> for the purposes stated above.
>=20
> The third page tweaks fhandler_fifo::fcntl and fhandler_fifo::dup so
> that they work with O_PATH.
>=20
> In a followup email I'll provide the program I used to test this
> implementation.
>=20
> Ken Brown (3):
>   Cygwin: device_access_denied: return false if O_PATH is set
>   Cygwin: re-implement fhandler_fifo::open with O_PATH
>   Cygwin: FIFO: tweak fcntl and dup when O_PATH is set
>=20
>  winsup/cygwin/fhandler.cc      |  3 +++
>  winsup/cygwin/fhandler_fifo.cc | 15 ++++++---------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>=20
> --=20
> 2.21.0

Pushed.  I'll create new developer snapshots.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4qxvkACgkQ9TYGna5E
T6Bemw//TWc0wOl6axwQNxBkIujBAuibA9OdmZtEtBvuEtbO0VWPr1gqbfd1ojtD
HJ7zFYupp4+KgQYgJxQdYsvGaUsSsT2sV0Vy8ci1m/czCCAthiodUG1gun/t/hik
rV5ZU+US1GlZx8yCyxx9HI0cedUyf6bzTtaTNs4Rxu873Tl1imc1no+Nzc9LTWLO
uZyfyoTDb74z0AD5JkpkoUjk6+hR8AB1VtcY8oSNiCWou+jPBIN3uAiVgE16OUDB
AKytQkx+VXkI7l0/aAT/hq+H9bLyM6crZYff/hQXdAVVVzV6Wbq0FC0YrHpd40zG
8EjGAa50YjkHc4Rb0p4xtD6bC68VYhXLkeNdHJM8w4nOHveR7anRrTbu+3tiTGIL
VDyzz0aEvoIB8v/zhxlT+rGyZtTPfmRvejSzKy0RBEPPZeGNLGD7xRSl3nTexzsv
2wWTK+NaRtgIEtt4VKRJf162SagZKxZtos34gXTHjfRjBzUImHkGk7AMK/BbUjaH
MGuk/lleoyBOpk3/WqmXccOLkz+YXOgKDzzGKvF5hLvfMuTzwSdFvW31g64aUVza
DmcqAsotc9nGtUjCZQZpK7cA2tPbHoeEixY4OigWusLD73YLPSRr1lTTAH7TjG3i
q/XkHpLFtTcLQAFyb8g6zI7J3ZTQPpbdmRW9Kr6kgRw5hXm3bJo=
=Wb2W
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
