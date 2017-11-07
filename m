Return-Path: <cygwin-patches-return-8906-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61932 invoked by alias); 7 Nov 2017 15:11:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61918 invoked by uid 89); 7 Nov 2017 15:11:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-125.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=bray, Hx-languages-length:1923, H*Ad:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Nov 2017 15:11:47 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id A7E60721E280C	for <cygwin-patches@cygwin.com>; Tue,  7 Nov 2017 16:11:35 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 6A9A75E038E	for <cygwin-patches@cygwin.com>; Tue,  7 Nov 2017 16:11:34 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5933FA80567; Tue,  7 Nov 2017 16:11:34 +0100 (CET)
Date: Tue, 07 Nov 2017 15:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix two bugs in the limit of large numbers of sockets:
Message-ID: <20171107151134.GC14762@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171107134449.11532-1-erik.m.bray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <20171107134449.11532-1-erik.m.bray@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00036.txt.bz2


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2042

On Nov  7 14:44, Erik M. Bray wrote:
> * Fix the maximum number of sockets allowed in the session to 2048,
>   instead of making it relative to sizeof(wsa_event).
>=20
>   The original choice of 2048 was in order to fit the wsa_events array
>   in the .cygwin_dll_common shared section, but there is still enough
>   room to grow there to have 2048 sockets on 64-bit as well.
>=20
> * Return an error and set errno=3DENOBUF if a socket can't be created
>   due to this limit being reached.
> ---
>  winsup/cygwin/fhandler_socket.cc | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_so=
cket.cc
> index 7a6dbdc..b8eda57 100644
> --- a/winsup/cygwin/fhandler_socket.cc
> +++ b/winsup/cygwin/fhandler_socket.cc
> @@ -496,7 +496,7 @@ fhandler_socket::af_local_set_secret (char *buf)
>  /* Maximum number of concurrently opened sockets from all Cygwin process=
es
>     per session.  Note that shared sockets (through dup/fork/exec) are
>     counted as one socket. */
> -#define NUM_SOCKS       (32768 / sizeof (wsa_event))
> +#define NUM_SOCKS       ((unsigned int) 2048)
>=20=20
>  #define LOCK_EVENTS	\
>    if (wsock_mtx && \
> @@ -623,7 +623,14 @@ fhandler_socket::init_events ()
>        NtClose (wsock_mtx);
>        return false;
>      }
> -  wsock_events =3D search_wsa_event_slot (new_serial_number);
> +  if (!(wsock_events =3D search_wsa_event_slot (new_serial_number)));
> +    {
> +      set_errno (ENOBUFS);
> +      NtClose (wsock_evt);
> +      NtClose (wsock_mtx);
> +      return false;
> +    }
> +
>    /* sock type not yet set here. */
>    if (pc.dev =3D=3D FH_UDP || pc.dev =3D=3D FH_DGRAM)
>      wsock_events->events =3D FD_WRITE;
> --=20
> 2.8.3

Pushed.  I just changed

  #define NUM_SOCKS       ((unsigned int) 2048)

to

  #define NUM_SOCKS       2048U


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaAc0mAAoJEPU2Bp2uRE+ggkMP/130rsOTleoADretB5rhlLuJ
seeKeY8zxi18IEmM2rGyqSxsUEIAir07aqSE4MVVoVwflFz/ExDLmTSyJt98zCef
Ou8xniw7/fRHvJM3kwJufopvUSugC/L89H/Ur2PKltvs23k6+fOUCwAD0uqNhijq
sj+HiDUyFqt+V143GCnNa9OukGqzwRs2EQv6p3Wqnh5QaGzruUJWAkZ+khjr0ypf
PJjiD8v/C9CmHa/IGubWiV+u3sHONVPdUNKIf2iuAN4DlMr/KhDDVDaRTHkixvUF
gv3urYU7AIcWao4cA2gNZPIXgq+z36q770HyZSQCIeAWKZ2VN2fkSyn55buJD+di
yOT7G58E1GXW9ptyO3R61lfZS3aEFW1mREzWZKUYh6/4fVLJqYffyaytaCtz+Z0h
iSrRHIwbdAV6eZH3SZfXTyVyYOgQXtfogQc31JBZMjb3jnFyChFMW37FghI89Wfn
JAbmbuZNDaFK49AdFhwvfYG46pG1yjDs5438skIZhXirfOr7iCNteUe1/HhUDrbe
hzMtlyaOGdLZDsVKseVk7qcKt/owgmv4x9fii41vq2vQEK0btNmF56+lwFfRs7W0
uPeHPM7Ojw5h8d2FtDuWdYiQxwn6V6x8I/1GYNle8Q4830RVYCROvUMXdn9ReseP
sEYyoTLZ2N6+CAgxvy6y
=px3P
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
