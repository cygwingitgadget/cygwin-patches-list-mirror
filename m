Return-Path: <cygwin-patches-return-9959-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2919 invoked by alias); 20 Jan 2020 10:39:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2910 invoked by uid 89); 20 Jan 2020 10:39:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-111.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Jan 2020 10:39:42 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MrPyJ-1jNNZD0YXn-00oVk6 for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2020 11:39:40 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 712E7A80734; Mon, 20 Jan 2020 11:39:39 +0100 (CET)
Date: Mon, 20 Jan 2020 10:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Revise code waiting for forwarding by master_fwd_thread.
Message-ID: <20200120103939.GF20672@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200120025058.1568-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <20200120025058.1568-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00065.txt


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 779

Hi Takashi,

On Jan 20 11:50, Takashi Yano wrote:
> - Though this rarely happens, sometimes the first printing of non-
>   cygwin process does not displayed correctly. To fix this issue,
>   the code for waiting for forwarding by master_fwd_thread is revised.
> ---
> [...]
> +void
> +fhandler_pty_slave::wait_forwarding (void)
> +{
> +  const DWORD time_to_wait =3D 40;
> +  DWORD elasped =3D GetTickCount () - get_ttyp ()->last_fwd_time;
> +  if (elasped < time_to_wait)
> +    Sleep (time_to_wait - elasped);
> +}
> +

Are these 40 ms an experimental value or is that based on knowledge
of implementation details?  The real question is, isn't there any
other, more reliable indicator to see if forwarding will work?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4lg2sACgkQ9TYGna5E
T6D4mg/9HKOiinxXEoQ73GlN39cRbliFdgB5AhNFdvOWZkMsquPdy9rFRMof+a8u
mmSq+9FpP10hOO/xUo0dqGfZeg+/pwoUYCmbOwgsOjxG9qgD5izKIrmDfFbOK2nV
B2CjTxBOMOuolhYawQqylX2Ztcitbipff+IsAY+9PJz1IbaJ0aAliniEjIRFbgPB
qYzLr0OVi4jBtHr0RMrKQwT62TiCR5au4Sycwp6xTlMb2LTCorBwdTX73zUdQgc8
4VuhB0ibHLAS9MEvqnzHPjMk5L8YoUm6b5Lx/DhMmBRnpebG6sbXL3qFMwWkXfrD
KH29Ac13kOHuJ60k/sjbiZ+JnXyRQhGZe+tKpzysyubnChMWGcempA0pA7dKLY96
MYZ+suaEqRGreICV3Z/IjZLaIxm3Mwc8bMKR/cifz5Rdn5nAas3p7ItZW7BK5BA+
b4OBBIge/nuMHkGYGYfWuRVMtYyzcHhIU5Swn53EksvqvtyLh9P4SgWSdqoJr4ld
7qFUQHVXnP6SZpirX03G5Bv+O5IKLH8dBY2Fg0I/gloz/Z1Pk8SantZWUPV6ElCS
+ygyWCzTxnfY6ABkt+SoEBLfLHXhdiGds6V1Z/SNrcAgf0OiZk5+ax9U1XsovDuG
MxeWqtaseOJcxJfzlnK7rgR/wvZuNSGrDcppIfY8glJMnFqiKlI=
=X0Gn
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
