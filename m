Return-Path: <cygwin-patches-return-9573-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 41060 invoked by alias); 15 Aug 2019 07:59:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 41045 invoked by uid 89); 15 Aug 2019 07:59:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 15 Aug 2019 07:59:27 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M6EOc-1hvxjd0YAa-006hRB; Thu, 15 Aug 2019 09:59:21 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 91746A8071F; Thu, 15 Aug 2019 09:59:18 +0200 (CEST)
Date: Thu, 15 Aug 2019 07:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Cygwin: console: Fix the condition to interrupt select() by SIGWINCH
Message-ID: <20190815075918.GI11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,	cygwin-patches@cygwin.com
References: <20190815050300.6380-1-takashi.yano@nifty.ne.jp> <20190815050300.6380-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="0W6CLHPDK0Qrxw1x"
Content-Disposition: inline
In-Reply-To: <20190815050300.6380-2-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00093.txt.bz2


--0W6CLHPDK0Qrxw1x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1035

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

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--0W6CLHPDK0Qrxw1x
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1VENYACgkQ9TYGna5E
T6A+og//QIIwTqUQDk+yrXREFtj4115l3E6bnuMXj4oXNyd6NwPVFPTFb22rdDgF
UmRmMDelfjYkM3h77q7n8PDE6d1GqQJP/lZyO8SJiu5U+gemJbWED/T6h+OH7kif
po42Gdj+oLWh5Xudtv7lXe+iZ4f8qGXXPgXb/cTL2gy0mpLZ7ybfZitwMHcJKlSe
p5Yajbt4lh8cNNwLaaItIsVTC4TrmdM9/fQUQptN8DHr5d6KJZTQBAqC4H+z78ZY
ZPjH+9KfMUZSq15tsmzqRs7y8re0C6jmiXkMoqyUEZV2CzeCvILZa7HQuQKBNeBb
OoQKaB/Ed7XsfJGHm3FJKir02C1KYbJmmxccM/BfnzkU69NJeA50bvzhIVGeNO11
CLDLa1hUiLdR4km7wBB/nEMGIf0D0ggOhuYvZgS9Tr//NmjBc2av70IeZ1n7A176
PtH4Vxp7sYxC6hsHEFvoBdLtLK6pQvbF48Nn21gnbt1lwY7I8cXI1dTkYVbiJIBR
dpo86HjhPo46pdCKEEptKfxC42dlqizP+IEWySGYw5E8aCf1KQOvetyj8TJiGleN
w1ar3Dc8Tx5Q/HbtfOYU8PJkQ73LHfImlCoRp9eUHkxNkPStH1U99EEAlfz7mzTo
qS92gns00Wa87P/vegacK0RL9Ws3lliJY7aCrhVsWsXRxsOp5qU=
=PITs
-----END PGP SIGNATURE-----

--0W6CLHPDK0Qrxw1x--
