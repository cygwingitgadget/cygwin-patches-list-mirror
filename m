Return-Path: <cygwin-patches-return-9946-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64821 invoked by alias); 17 Jan 2020 09:51:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64812 invoked by uid 89); 17 Jan 2020 09:51:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-113.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Jan 2020 09:51:07 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MZCSn-1j5R0409Dd-00VCYD for <cygwin-patches@cygwin.com>; Fri, 17 Jan 2020 10:51:05 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 78079A80670; Fri, 17 Jan 2020 10:51:04 +0100 (CET)
Date: Fri, 17 Jan 2020 09:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: allow opening an AF_LOCAL/AF_UNIX socket with O_PATH
Message-ID: <20200117095104.GD5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200116183355.1177-1-kbrown@cornell.edu> <20200117094826.GC5858@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="PLOb/g6AMdJ1vPHZ"
Content-Disposition: inline
In-Reply-To: <20200117094826.GC5858@calimero.vinschen.de>
X-SW-Source: 2020-q1/txt/msg00052.txt


--PLOb/g6AMdJ1vPHZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1127

On Jan 17 10:48, Corinna Vinschen wrote:
> On Jan 16 18:34, Ken Brown wrote:
> > If that flag is not set, or if an attempt is made to open a different
> > type of socket, the errno is now EOPNOTSUPP instead of ENXIO.  This is
> > consistent with POSIX, starting with the 2016 edition.  Earlier
> > editions were silent on this issue.
> > ---
> >  winsup/cygwin/fhandler.h               |  2 ++
> >  winsup/cygwin/fhandler_socket.cc       |  2 +-
> >  winsup/cygwin/fhandler_socket_local.cc | 16 ++++++++++++++++
> >  winsup/cygwin/fhandler_socket_unix.cc  | 16 ++++++++++++++++
> >  winsup/cygwin/release/3.1.3            |  7 +++++++
> >  winsup/doc/new-features.xml            |  6 ++++++
> >  6 files changed, 48 insertions(+), 1 deletion(-)
>=20
> I'm a bit concerned here that some function calls might succeed
> accidentally or even crash, given that the original socket code doesn't
> cope with the nohandle flag.  Did you perform some basic testing?

Iow, do the usual socket calls on a fhandler_socket_local return EBADF
now?  Ignoring fhandler_socket_unix for now.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--PLOb/g6AMdJ1vPHZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4hg4gACgkQ9TYGna5E
T6Al/g/+J6KmCwjS/RodzoAgqkpi4J0rywpnG2oMPN1lrNgrWVK767bI+fBVnpbX
lcI7JFvH2nXwNO1smTr1edToTh9WIAFiOTkTXtiaMrjIqh19qKWXiussbg35Fnuu
ZqOJHMqbN86FGxAVrkq52nytgNCuSejPYphpCos1GcHvnDl73TTJRpcIBD66e8uE
s1YgKaDJFrAF8clEJhh2pifRsOVt1ejCCsJbW1ffDGqFmrK9xf0UZl1R4xo7OleH
kNwpwdnIoMuPxl0D3P9ZcJE3tOeoSW9iUfFOYiMahI7f9yNN+hQi9NoYVD9RDG6F
qbdIkn9wr7fuJGGCazEGionkCbp7TMZwTto+lMZIgFzwcW3bG7mbnrw64N7/q2N1
eC/bEXOqbE1vi7UKDexETRF+1EWYEABbxm4gBlDRU1AaTQ5ism/+Gw1ABnDHKzps
akPRBpsUPzruXgnRjvGUIWT6WgHYvXuEknSx/ht5J+lzCHBVVoCThFpFbS25xmsw
uBwIfY5WtnStayW4P/w81xzxJdCZt+cqKhXgAjyT0zYzLiqndH+ScNGhzPiErhSj
jnX/2KPNceN7lZk3dxG63r6LpzcOjd48Mo0CaNljmDUmDJhyKTqXV0kwZVcECUh7
rOkbEnblj4JuZTES+9uI8gGZEYwD7tMGpgVZaBsS/W5xY5RXf/E=
=5Ww9
-----END PGP SIGNATURE-----

--PLOb/g6AMdJ1vPHZ--
