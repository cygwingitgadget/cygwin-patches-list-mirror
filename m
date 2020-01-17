Return-Path: <cygwin-patches-return-9945-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50349 invoked by alias); 17 Jan 2020 09:48:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50318 invoked by uid 89); 17 Jan 2020 09:48:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-113.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Jan 2020 09:48:30 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MkHIV-1jKcRG3JpR-00kjrO for <cygwin-patches@cygwin.com>; Fri, 17 Jan 2020 10:48:27 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DD024A80670; Fri, 17 Jan 2020 10:48:26 +0100 (CET)
Date: Fri, 17 Jan 2020 09:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: allow opening an AF_LOCAL/AF_UNIX socket with O_PATH
Message-ID: <20200117094826.GC5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200116183355.1177-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="XMM+kVNHGkMezEqK"
Content-Disposition: inline
In-Reply-To: <20200116183355.1177-1-kbrown@cornell.edu>
X-SW-Source: 2020-q1/txt/msg00051.txt


--XMM+kVNHGkMezEqK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 941

On Jan 16 18:34, Ken Brown wrote:
> If that flag is not set, or if an attempt is made to open a different
> type of socket, the errno is now EOPNOTSUPP instead of ENXIO.  This is
> consistent with POSIX, starting with the 2016 edition.  Earlier
> editions were silent on this issue.
> ---
>  winsup/cygwin/fhandler.h               |  2 ++
>  winsup/cygwin/fhandler_socket.cc       |  2 +-
>  winsup/cygwin/fhandler_socket_local.cc | 16 ++++++++++++++++
>  winsup/cygwin/fhandler_socket_unix.cc  | 16 ++++++++++++++++
>  winsup/cygwin/release/3.1.3            |  7 +++++++
>  winsup/doc/new-features.xml            |  6 ++++++
>  6 files changed, 48 insertions(+), 1 deletion(-)

I'm a bit concerned here that some function calls might succeed
accidentally or even crash, given that the original socket code doesn't
cope with the nohandle flag.  Did you perform some basic testing?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--XMM+kVNHGkMezEqK
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4hguoACgkQ9TYGna5E
T6AvzQ/+PFBIkyaPZSuydXc+GA752zJN4alyLTBnqY+h2jRKolLLCm+P/P1l/0tu
TDqfGV0MH4b7dIpLfqp73VhnLTjS/10Csifjh8Kx+HTglDhu/HShU1o/vFs8p2nY
vxvIwG3PeNiBnEPsrHTSWj+C8Qlf9EEgCcoEURkNq5KiZ+q9+luWrd9IK2DsQwod
Nd2vTnT1ZWh1TwHOilL6IRCeFd/lse2UIHhrq2ddy/fw+ADfnVZBDBJneAQ4KxFK
Dkc0nNfGV4j6kfMVwLC4EXEqJBm7a6cznVIY4r8xEXrnJ05JBTdrcIFMFZsWAvAv
JX/QOjl8ppMjRBN3UbdfGuY+XnmwMAVgd354d0wLT4TH2paMlOG6/6MzKMQHrTR5
weDSEuJN2DPqJXPuxTZINmYL3jqJruNQkgRpUZ4/b5BKxYBU4C54n+bGYNGPmMv+
vSuyJ6ywCfd4osGscUHvULAVCkH+3drg4iMU0kpT3GKuOvtQ1/bIBAhy8ct30PIG
PEeAB7LbqM/xLOBco6hRwzdPKHmLaofin7GViqI1RFuS01GozUULAkdVX0Fadx6+
6XLJ4f67QQV9U4gBUaTszpwQ/d9x8rFw2w6pdS+WPdKZDY9of+ypGExMzak9OhrJ
usXWKdjVFc3CsltjGqTQX6nqvaI7DaBwb/AZYt3KpJlMare78Ww=
=URoZ
-----END PGP SIGNATURE-----

--XMM+kVNHGkMezEqK--
