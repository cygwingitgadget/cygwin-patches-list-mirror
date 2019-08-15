Return-Path: <cygwin-patches-return-9571-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4418 invoked by alias); 15 Aug 2019 07:52:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4409 invoked by uid 89); 15 Aug 2019 07:52:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-115.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HCc:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 15 Aug 2019 07:52:55 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MsI4Q-1iIiK11Wkk-00tibl; Thu, 15 Aug 2019 09:52:51 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6CD3EA807B3; Thu, 15 Aug 2019 09:52:50 +0200 (CEST)
Date: Thu, 15 Aug 2019 07:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Cygwin: console: Fix the condition to interrupt select() by SIGWINCH
Message-ID: <20190815075250.GG11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,	cygwin-patches@cygwin.com
References: <20190815050300.6380-1-takashi.yano@nifty.ne.jp> <20190815050300.6380-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="oHs6GRo50UrIH54O"
Content-Disposition: inline
In-Reply-To: <20190815050300.6380-2-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00091.txt.bz2


--oHs6GRo50UrIH54O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1098

On Aug 15 14:03, Takashi Yano wrote:
> - Add code so that select() is not interrupted by SIGWINCH if it is
>   ignored (SIG_IGN or SIG_DFL).
> ---
>  winsup/cygwin/select.cc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index 9cf892801..4e9256b9f 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -1045,7 +1045,9 @@ peek_console (select_record *me, bool)
>        else if (!PeekConsoleInputW (h, &irec, 1, &events_read) || !events=
_read)
>  	break;
>        fh->acquire_input_mutex (INFINITE);
> -      if (fhandler_console::input_winch =3D=3D fh->process_input_message=
 ())
> +      if (fhandler_console::input_winch =3D=3D fh->process_input_message=
 ()
> +	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
> +	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_DFL)
>  	{
>  	  set_sig_errno (EINTR);
>  	  fh->release_input_mutex ();
> --=20
> 2.21.0

Do you think a similar workaround would help for the signalfd
problem?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--oHs6GRo50UrIH54O
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1VD1IACgkQ9TYGna5E
T6ARaQ/9GplC1vCLWUQX/efbdubYQRQ7i+U+QRR45nIT29bnPxK+2YOIEMEdaM3m
T6k55aCYEX4iyW+wOuHlxtO4ucM3zS3eurnVuLqgxS8/Xc4zG7oYnKDfIOLvKbuX
oDqawz0CKgzckqAW8Nardaj//UNjoQeb+DxyxG+Hc6rSB0IXWtj23sbqM6zYBkfd
ntpLJvCghwiFPblDpNpnpu8p/UEu3pDlgyS5J5DQeYlWq+nx4eWMHkRWKn+qLbn6
XjajwR55rhdH5NOWeYEcxF1j37c1tIZE1f1HS8qEc4w2/m0w76Sk7IcHrL/TEoWA
KUXcrOV/eprJieNJ5C5dO0+wLKBFx9pgJt9kQirnJs05pmSl5jCJnaBYKp5j3T34
7EjoODBbeEzBtiMRz6F+S+yN+W+WW8IBrikAR56M2XAIAFFRKpduQotycbcZAyHu
xSUKnahHgKb450l2lt95xHO5M7INa2JKFuuwo5Z2YWr0PKpJuXZXKgDWwd84kQZi
pMI3zPOutLJJUjeOHiIVXD0qhQG/huJJrjEfNEPT7TEaLyXJfrgj69vX32f/g+xU
VxnGaz9FTq2EwuHoL1ZdbkDtLt+4SHrduabZ+eP9UAB+Dlrq8e5gyMfbpjGepKhI
xFLuarKLFmrjK3W6iLFnDWNxK9q5Um1L1qE2Ybyp6f1TmIAk/BE=
=EhX1
-----END PGP SIGNATURE-----

--oHs6GRo50UrIH54O--
