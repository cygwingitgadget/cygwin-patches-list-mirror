Return-Path: <cygwin-patches-return-8042-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6836 invoked by alias); 18 Dec 2014 16:49:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6812 invoked by uid 89); 18 Dec 2014 16:49:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Dec 2014 16:49:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EC47F8E12DF; Thu, 18 Dec 2014 17:49:41 +0100 (CET)
Date: Thu, 18 Dec 2014 16:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Export new stdio and stdio_ext functions
Message-ID: <20141218164941.GE10824@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5492FD19.6030407@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="Fw8vdPO5iEPGjqL+"
Content-Disposition: inline
In-Reply-To: <5492FD19.6030407@cygwin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00021.txt.bz2


--Fw8vdPO5iEPGjqL+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1535

On Dec 18 10:13, Yaakov Selkowitz wrote:
> These patches export the BSD, GNU, and Solaris stdio extensions (27 in
> total) recently added to newlib.
>=20
> --
> Yaakov

> 2014-12-18  Yaakov Selkowitz  <yselkowitz@...>
>=20
> 	* common.din (__fbufsize, __flbf, __fpending, __freadable, __freading,
> 	__fsetlocking, __fwritable, __fwriting, clearerr_unlocked,
> 	feof_unlocked, ferror_unlocked, fflush_unlocked, fgetc_unlocked,
> 	fgets_unlocked, fgetwc_unlocked, fgetws_unlocked, fileno_unlocked,
> 	fputc_unlocked, fputs_unlocked, fputwc_unlocked, fputws_unlocked,
> 	fread_unlocked, fwrite_unlocked, getwc_unlocked, getwchar_unlocked,
> 	putwc_unlocked, putwchar_unlocked): Export.
> 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Looks good, please apply.  Also, please add

> +<listitem><para>
> +New APIs: __fbufsize, __flbf, __fpending, __freadable, __freading,
> +__fsetlocking, __fwritable, __fwriting.
> +</para></listitem>
> +
> +<listitem><para>
> +New APIs: clearerr_unlocked, feof_unlocked, ferror_unlocked, fflush_unlo=
cked,
> +fgetc_unlocked, fgets_unlocked, fgetwc_unlocked, fgetws_unlocked,
> +fileno_unlocked, fputc_unlocked, fputs_unlocked, fputwc_unlocked,
> +fputws_unlocked, fread_unlocked, fwrite_unlocked, getwc_unlocked,
> +getwchar_unlocked, putwc_unlocked, putwchar_unlocked.
> +</para></listitem>

to release/1.7.34 as well.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Fw8vdPO5iEPGjqL+
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUkwWlAAoJEPU2Bp2uRE+g8tAP/0KRuPhV8MXlIs58rkWH4xCI
vCOgHvVR6YhQ1V72QXyq7YmAxxGRzxXHJkp+tm7bVr2kfSB3FcnVoIFSmKYLBSQm
jdInaN7zdPIokr3/LV2OeDxNZLY2jRd4GbnNen+xNQX6fZLqjujR7iqRIJOiI9Kv
qRxJ79SOety6HT9rwxE8qMNdftEBqM4S70M2pLVjw4ah3khDK6iyBvu1BRQ5nBdI
nt8uYl+pyovoy2pvXGXhMzu2GbZRuDoENsAUWndhUbQeqdliayc1mcNdOlp4gyga
y4ITlBwnCiu29JrkB0hLNsFdMpbx6/YbV0JIzjAcug48nS1xfkwAaW7Abec/DtJd
rTQ1wb0zz9um68n+FQ1/8CLTSTDVO9R+3I6ad1qteAZv+mQCl9rXFgZd6DxRP70u
nj88Jmf/HKf+SfAGkiKiRKY/DeXGHEhyqVCfxfOlrOYdt+mE4p0zwl6SAjCSgxEc
0p8/736j9aeN1TYRtOWz+gVczIhSIWHB/8wKbMk/Bb9FkXLNBp0JijQjuurIRGLo
dsH5qdZvawkVEaG4GsacDRqcdiAZEoFqFRJRhDem46Su8xFI7j1cOmpBGwuQAx3V
jFcEAMp1xDRT1s8NV5vEh7QIMyHeuy5MhRoHUkacvz0Aq3y6mWeE1zqmWNS6qxsm
oFGC/rMuOvhsC7hy0HbS
=l6+a
-----END PGP SIGNATURE-----

--Fw8vdPO5iEPGjqL+--
