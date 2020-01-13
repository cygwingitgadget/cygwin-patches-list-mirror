Return-Path: <cygwin-patches-return-9918-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 110692 invoked by alias); 13 Jan 2020 16:27:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 110682 invoked by uid 89); 13 Jan 2020 16:27:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-123.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:934
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 16:27:10 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MkpvV-1jWSFo2ZkF-00mJeT for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 17:27:07 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EEBB3A80393; Mon, 13 Jan 2020 17:27:06 +0100 (CET)
Date: Mon, 13 Jan 2020 16:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Make suspending process work properly.
Message-ID: <20200113162706.GP5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200105132555.925-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="oY1uq2ONqt5kuovO"
Content-Disposition: inline
In-Reply-To: <20200105132555.925-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00024.txt


--oY1uq2ONqt5kuovO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 931

On Jan  5 22:25, Takashi Yano wrote:
> - After commit f4b47827cf87f055687a0c52a3485d42b3e2b941, suspending
>   process by Ctrl-Z does not work in console and results in hang up.
>   This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_console.cc | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_c=
onsole.cc
> index 78f42999c..33ff8371f 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -853,7 +853,9 @@ fhandler_console::process_input_message (void)
>        if (toadd)
>  	{
>  	  ssize_t ret;
> +	  release_input_mutex ();
>  	  line_edit_status res =3D line_edit (toadd, nread, *ti, &ret);
> +	  acquire_input_mutex (INFINITE);
>  	  if (res =3D=3D line_edit_signalled)
>  	    {
>  	      stat =3D input_signalled;
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--oY1uq2ONqt5kuovO
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4cmloACgkQ9TYGna5E
T6CKDhAAk+5OymKA1ACJzQMdNn8mOFVtc1T+CUNBZ8DuGa8euqPAw3QBybK5MJBI
EtQ7UL0DpSXDJ92UH6pvA+rBZK5S0z+l1XHJ3PW4Kc/wo7mQ9BHvS0JHHzEVHfcX
PPGkZCHm4n/Nf13jMw3pA7P7iU9/WQ3HWPUZDyf10FCHCe9NGGjTDOA3Wvay4Er8
lYHOVJHktATNcXp2K/Zpnws1kbOzZaSGlltxSruyNq8z0iI9PbRBRyLod2L+y23n
hdxLjsURVHmP/9Bbj+cwCLoDaQu9SYrEP+udvnujLJz4YU0WbmCCG5r6YZSjxU4y
mZTWbuFMEjCsn8VBP+sz4ESHKYiP8Qi8f77X3jjNKPNt4nAGWyX8FrVCC3L+AroY
/+sL3vAOlM3jlAPfPGpXd+IblOa5pnnf3/eEHTwUGvgn3EQZrEKUFKD7DFFrRmg5
xbE5cx9t/w46C3oJMVbo/yqJsrHiu8byBVwKmJ5D1YngbWyudd0yuyqIyDEvXcos
ZSqU75fdIELxiF0EEFTmGoZhyI222KAxF4sUHXO/qILYGYN1Hcs8455eZrj7skJC
YqMExAAXN1qF8hPaM4L0efC3n8m6C1Zkfr3ihZfWskLbjZ63ExtN8Kai8zpqCkb0
hkshVKoi2Kv8IcibD687fjg4HUvBBdfsI437m1BVskYuGbQwYGc=
=jFUZ
-----END PGP SIGNATURE-----

--oY1uq2ONqt5kuovO--
