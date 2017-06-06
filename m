Return-Path: <cygwin-patches-return-8769-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 831 invoked by alias); 6 Jun 2017 14:23:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 799 invoked by uid 89); 6 Jun 2017 14:23:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Erik, erik, H*c:application, H*Ad:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 06 Jun 2017 14:23:11 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 4BFEB721E280C	for <cygwin-patches@cygwin.com>; Tue,  6 Jun 2017 16:23:12 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 94DEB5E0389	for <cygwin-patches@cygwin.com>; Tue,  6 Jun 2017 16:23:11 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 799E8A8068C; Tue,  6 Jun 2017 16:23:11 +0200 (CEST)
Date: Tue, 06 Jun 2017 14:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure that a blocking send() on a socket returns (with success) if a signal is handled mid-transition and SA_RESTART is not set.
Message-ID: <20170606142311.GA23208@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170511140534.26860-1-erik.m.bray@gmail.com> <20170511140534.26860-2-erik.m.bray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20170511140534.26860-2-erik.m.bray@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00040.txt.bz2


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1363

Hi Erik,

[vacation-induced late reply]


On May 11 16:05, Erik M. Bray wrote:
> ---
>  winsup/cygwin/fhandler_socket.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_so=
cket.cc
> index f3d1d69..c7ed681 100644
> --- a/winsup/cygwin/fhandler_socket.cc
> +++ b/winsup/cygwin/fhandler_socket.cc
> @@ -1851,7 +1851,7 @@ fhandler_socket::send_internal (struct _WSAMSG *wsa=
msg, int flags)
>  	  if (get_socket_type () !=3D SOCK_STREAM || ret < out_len)
>  	    break;
>  	}
> -      else if (is_nonblocking () || err !=3D WSAEWOULDBLOCK)
> +      else if (is_nonblocking () || WSAGetLastError() !=3D WSAEWOULDBLOC=
K)
>  	break;
>      }

Thanks for catching!  Given that the loop isn't guaranteed to set `err'
correctly all the time, I wonder if we shouldn't get rid of `err'
completely.  Checking WSAGetLastError is plain user-space memory access
anyway, and there's no reason the compiler can't optimize this by
itself.

Also, I would prefer to have a shorter subject (<=3D72 chars or so) and
to describe this in the log message a bit more detailed.

Would you like to provide another patch along these lines?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJZNrrPAAoJEPU2Bp2uRE+guXkP+NbI9c0ZE3LbjmEvMwBeaZfo
0o3BcSguXEmjJxEal8oJyhBhIPj6UHDbvPTMhjKwkNi1BUbezzr4yUMp73L9nxc4
cRaPWUsJAjCUV+thd3+wGHr6VAZ42/zQ/s6UbRf0CqmWA3e+0khfFjsHaUME+O6S
vW2DqYtYXU6VENrlVj2idLxy4T0FOnU28UjOpxnrRW4W6fIZuw/LQHQkJdE2bfV3
kUxhVnJAk+8pMSFO3LyQU+K0ki32/RBbamLTqMoSRN9eFwVDSnzUj1LoCjgSsVn0
ZVx9jS/INOT+5vQftb27Hb9+pObs1Ny1L68sTUArI71iX1dbUq5B21ekHKkbulgZ
XQr70WksUb/w5FCJ9fuCiXObVXLHbv1/4irC8IlWY1hX6J++DW/Nqk8iejL4xDyM
7OPmnS7UgjfNVF31v5rRqUSyEReLw+fXs1Py2zvlJGRVDM8/t/3x+JUXMHwFhOty
ic0flwMftVXVLNSG9oQhrcCXNyYiZMJ9kX7IwcA2AbCGOhgYzn2WoZDIURL5tteE
3Nd0Vz9kCudF8FAGse+u6CnQHk2dwCyslO4Dpqnst5h8P8JEyqeim/yAzwVDajoD
G5ZwZ+sBJ9HOZtLx//tcX/rBqKxqNqDARCAqfSexq7fz/P3XadV7MED+evgl2Y9Q
csaiefJ8nqsf5gllu2M=
=JJIL
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
