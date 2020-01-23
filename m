Return-Path: <cygwin-patches-return-9981-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104903 invoked by alias); 23 Jan 2020 12:42:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104894 invoked by uid 89); 23 Jan 2020 12:42:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-120.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 12:42:49 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MpDRp-1jOT8a0uK7-00qlZH for <cygwin-patches@cygwin.com>; Thu, 23 Jan 2020 13:42:47 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7D06EA80BA7; Thu, 23 Jan 2020 13:42:46 +0100 (CET)
Date: Thu, 23 Jan 2020 12:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Remove close() call just before reopening slave.
Message-ID: <20200123124246.GA263143@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200123113425.1967-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20200123113425.1967-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00087.txt


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 929

On Jan 23 20:34, Takashi Yano wrote:
> - After commit da4ee7d60b9ff0bcdc081609a4467adb428d58e6, the issue
>   reported in https://www.cygwin.com/ml/cygwin/2020-01/msg00209.html
>   occurs. This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 73aeff37f..35a48338f 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1326,7 +1326,6 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (cons=
t char *ptr, size_t len)
>      {
>        termios_printf ("GetConsoleMode failed, %E");
>        /* Re-open handles */
> -      this->close ();
>        this->open (0, 0);
>        /* Fix pseudo console window size */
>        this->ioctl (TIOCSWINSZ, &get_ttyp ()->winsize);
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4plMYACgkQ9TYGna5E
T6C4ww/+MyxIVuWvy2/vaSSKNtXTfPR5x8dDhwmNLFkDf90Ci6hto92exfpgreqW
K+H3HLPgk9BYqtVfUHn4qJ0F3dpaG/a7ugUR+Adn1bb85RfGXk9WFpA1Gz097ubs
zmb4fVVdyA43G+ZvUAp8GYwf+nwZczDiTwemW6AIZm4W/Y29JCDx/QX20AFkB/Qs
r1J33n2pzmGI7eYCzFNmRk6sI4gkT+eGBkoy9uzSZ40Y4HRKUobO+4DPbiELt97n
Xae7CTSmGmFTVWpMMZAfRJYxi1jB5UHKM97AqpBe+t1RFjvMb+/7/15g+x8WwdIj
F5X9fINJrtOqKuVBxmPBhP+Z+9UhdfqXkdxFzYC7dtZZz6/WpfGZf5/eIBeV8onM
Zq3aucSDY2qW96PBq50GVThZsGx4PJF2iZxpO90WpwDyB/1zd8S6uoF8MMOr4vhr
+ZKXz03T6eDFgpHEhgAZLEEoZTvLubral+pfdSq5HvBbpUX+A6bTP1PATdM8nKzk
z7dbjZVvgczuuxkJ7L2pZ86uZifQ3yJ4vsQLy/SjbTCaPt57eYKHrOYXtCD72d2j
6jd6CD0qJ5tA5s8N7oJERlas5VcZAitiRZHOMVgK0Y+rztAvJiRbvl9TTogtJn6x
AU3LGmC7bCd65q8jKZxQNrf9C2aukF8Iu1/TN+65SeVZWT3rUTk=
=FuvF
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
