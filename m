Return-Path: <cygwin-patches-return-8022-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19527 invoked by alias); 9 Oct 2014 18:00:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19514 invoked by uid 89); 9 Oct 2014 17:59:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 09 Oct 2014 17:59:58 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 653F08E0A26; Thu,  9 Oct 2014 19:59:56 +0200 (CEST)
Date: Thu, 09 Oct 2014 18:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Disable AF_UNIX handshake with setsockopt(..., SO_PEERCRED, ...)
Message-ID: <20141009175956.GF2681@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <54240D45.6080104@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <54240D45.6080104@t-online.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00001.txt.bz2


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1229

Hi Christian,

On Sep 25 14:40, Christian Franke wrote:
> This is a workaround for this problem which blocks ITP postfix:
> https://cygwin.com/ml/cygwin/2014-08/msg00420.html
>=20
> With the patch, this disables the secret+cred handshakes of the AF_UNIX
> emulation:
>=20
> int sd =3D socket(AF_UNIX, SOCK_STREAM, 0);
>=20
> setsockopt(sd, SOL_SOCKET, SO_PEERCRED, NULL, 0);
>=20
> Postfix works if socket() calls are replaced by the above.
>=20
> Calls of getsockopt(..., SO_PEERCRED, ...) and getpeereid() would fail wi=
th ENOTSUP then. These are not used by postfix.
>=20
> Christian
>=20
Patch looks good.  I'm just going to move the no_getpeereid flag into
the status block.  Also:

> +int
> +fhandler_socket::af_local_set_no_getpeereid ()
> +{
> +  if (get_addr_family () !=3D AF_LOCAL || get_socket_type () !=3D SOCK_S=
TREAM)
> +    {
> +      set_errno (EINVAL);
> +      return -1;
> +    }
> +  if (connect_state () !=3D unconnected)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'

Wouldn't it make sense to allow this call in the "listener" state as well?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUNs0cAAoJEPU2Bp2uRE+g6wMP/jTeP7spS049s6Hzq86jPbCp
90OFyhCI1c0DUZVxMfN7LG38ui1+LLEIcQ+CegcRMJT6WeWemsN8IpvuqiL/Hx7v
RMlOsHNX3Yb8exqogkH1p0EB+CxZuFRtESomAtfagcrL9J9U8Aos/5YyQ9WpKF1z
6PjjsSGmIDdE/AviMWmF0ABe2MUNaS7i8bikBpjqgRGsj6ydDtr0sbMtE0f+Gjlw
sSrLaQfTpWYpebG0q7b89hC3RPNEFZB1RBMpSSO4wr+InbEigYryEuaLdQq4SUND
hXDkAL0VJVDbiDsZ8GdHvdA2+vCORT/M4SzfLGzzInTwyqryHU0Rb+ozt39HO070
xMILIuv8G9ez89eyWhuGLbdd4HJQyxSNCU7/CEVeluxrfEPfISBy17XxglWwrcZJ
/90cFwc08zlkLmIM2H7r/9MFlnZGSnVgywshcsG5Tb0NXuiT7uCID4Eeyy16LKEy
RIcdtmDBfvThTIBtokV7HuTW0Mb3L2feMiwuTpp+ZHrVj1gH8LgPv9tZRiF9c79Y
6Wotygk/8yLmZx0z617UE442rM2keQoTxuik4TPAaRtiLH34xmSu5jTzcf+zsiBy
lzrRiSs6X0KQNL3GbEwJf5onMNxuw5TI9adR+sd4RLDJVDCYMZXlneylm785thE/
Lq4pMvSWnKcXfpnaaKXS
=T9Q7
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
