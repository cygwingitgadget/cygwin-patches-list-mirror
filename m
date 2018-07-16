Return-Path: <cygwin-patches-return-9120-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 41340 invoked by alias); 16 Jul 2018 14:27:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 41313 invoked by uid 89); 16 Jul 2018 14:27:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=personal
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 16 Jul 2018 14:27:37 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MU9x3-1fWa0t2PXF-00QnrM for <cygwin-patches@cygwin.com>; Mon, 16 Jul 2018 16:27:34 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D7A9EA80576; Mon, 16 Jul 2018 16:27:33 +0200 (CEST)
Date: Mon, 16 Jul 2018 14:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/3] POSIX Asynchronous I/O support: fhandler files
Message-ID: <20180716142733.GA27673@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180715082025.4920-1-mark@maxrnd.com> <20180715082025.4920-3-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="OrT4iOlIQZp3kw4S"
Content-Disposition: inline
In-Reply-To: <20180715082025.4920-3-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00015.txt.bz2


--OrT4iOlIQZp3kw4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1448

On Jul 15 01:20, Mark Geisert wrote:
> +      if (aio)
> +	status =3D NtReadFile (prw_handle, aiocb->aio_win_event, NULL, NULL,
> +			     &aiocb->aio_win_iosb, buf, count, &off, NULL);
> +      else
> +	status =3D NtReadFile (prw_handle, NULL, NULL, NULL, &io, buf, count,
> +			     &off, NULL);

Ok, this is a very personal style issue, but I don't like to see the same
function called just with slightly different parameters in an if/else.
Would you mind terribly to rewrite this kind of like

  HANDLE evt =3D aio ? aiocb->aio_win_event : NULL;
  PIO_STATUS_BLOCK pio =3D aio ? &aiocb->aio_win_iosb : NULL;

  [...]

  status =3D NtReadFile (prw_handle, evt, NULL, NULL, pio, buf, count,
		       &off, NULL);

?


> +		  if (aio)
> +		    status =3D NtReadFile (prw_handle, aiocb->aio_win_event,
> +					 NULL, NULL, &aiocb->aio_win_iosb,
> +					 buf, count, &off, NULL);
> +		  else
> +		    status =3D NtReadFile (prw_handle, NULL, NULL, NULL, &io,
> +					 buf, count, &off, NULL);

Ditto.

> +      if (aio)
> +	status =3D NtWriteFile (prw_handle, aiocb->aio_win_event, NULL, NULL,
> +			      &aiocb->aio_win_iosb, buf, count, &off, NULL);
> +      else
> +        status =3D NtWriteFile (prw_handle, NULL, NULL, NULL, &io, buf, =
count,
> +			      &off, NULL);

Ditto.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--OrT4iOlIQZp3kw4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltMq1UACgkQ9TYGna5E
T6B0Zw//U5XN7vGM3kLqj39oH4kt9OBssuLBxO1I+pIUhaA+/t3M4BSKVJXXGH6e
hUFWccdo/7tl/1lqC58Q82VQAN2g4EhCYbO98DicxBUY62mlYOH66WxtCTrLqNHu
nP2vpxtBfvquu4rSg6iqd9ki42IAMdcv90N6cNoVigAMkAp5WDn0rFY24YEKULOy
mSxDiCfM7L8viovJdjlB+pr4HBsfFWYxmDCYt1c/DDGzGaTY0ybwb5Uk3jYyxIeO
gVXJwbsIbVIrN4ccQRyxcZp/OT6tVznY+T1oxzY+ZdrmJDQOUurAMb6r+f7BEWfJ
AMZJVqTIHQ0QN2ldTBVFfNvEYFkQFGhOuVRUmYK+x333iAowj0ECAvRLKnFsvk76
CEB3RwO3RoyK6e0rhSrOtFnI+aTi3Nygr3AZmwomXXShGNTM2A2dr+Y4GhKyGydF
kk/BouT1YEEiU3TQVBNaqcuN6afdyW9L2/jJJ9MGS7nSUIgoZAV/3sRICMbO4spM
87vU+TFbXZAwgYGCW1xROqifEC2C64iWJnZ/oitVXmZKEFD1amGCEeAdyW3KfOgN
Ethy8+KSWh1reExR3jEthcz/6B1pcpnRHiBsA+3MkJ0oUNRIbaGP9UWYmlnxe2N6
nwkerQknYGloz9LT6+k96tvtEuXH9vCbGftGFV2ugBxlNWNmJys=
=aVV5
-----END PGP SIGNATURE-----

--OrT4iOlIQZp3kw4S--
