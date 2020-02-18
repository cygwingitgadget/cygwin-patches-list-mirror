Return-Path: <cygwin-patches-return-10084-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 89014 invoked by alias); 18 Feb 2020 10:42:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89003 invoked by uid 89); 18 Feb 2020 10:42:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 18 Feb 2020 10:42:23 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mi27T-1jhAdg1GUL-00e3nF for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2020 11:42:21 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C89E0A80734; Tue, 18 Feb 2020 11:42:20 +0100 (CET)
Date: Tue, 18 Feb 2020 10:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix ioctl() FIONREAD.
Message-ID: <20200218104220.GH4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200218040507.377-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
In-Reply-To: <20200218040507.377-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00190.txt


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 392

On Feb 18 13:05, Takashi Yano wrote:
> - ioctl() FIONREAD for console does not return correct value since
>   commit cfb517f39a8bcf2d995a732d250563917600408a. This patch fixes
>   the issue.
> ---
>  winsup/cygwin/fhandler_console.cc | 37 +++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5Lv4wACgkQ9TYGna5E
T6CMlw/9F5UvkIOji7m+LPd97Cpyiw90wNcKoXLq4kB8/kEnVuuTVyUJj0axKpTk
BZWwWdw2zT2qpODFz5wpyVvMtUnFid8CYJaftwV8GiQmfwLyEahYO1992QDcJoP/
BxhoqLB2i09XPcxOS6pWmRRPifJdRFNgdPFbJJdl7Fc54HvtYQ5aArPC7qnAWy8B
k9chd/5oxILmFc206CAI/psQ/SzkrIxSaQfSEE3YMVVUVLi/iCjK2iaYDI+W3LSN
s51EnY0UseIqNd9xjz8eSg4ftgI8+EXibVTUZkWkIv/YkeLiEimxBkVSj4XzpvNw
QksuwgIJd8iRBTofJ2Z5MZivzLDKjjdAdCEf0NRw2Nso0q03eavIS0zIP6+qhUMn
GVlYMb7BJ8+z/jFvOqWxWH3KVgFnt8yGXNR0mhdl1bBApHpaPXjvgC8htVUludf/
nUXQj8ZujLh8WloUcZluiLx3JTAH752uGCLrDeXjlCyOl0AiVlX/kbBoOzZ8lxah
xm9oXBuNRgsUd1UpjCLoA9SnXWiIbCzfw2kUf6xbHpaQwS5WTbQ2OHlONr+H0hhK
whmXFEclrFaFAzz/X0IvaeioOBae2aquXhP2PYt2O9xv/Ef9ZTCHGfApXxDrzsyn
SOS8vJi9DHlZHf/5MS3+DTBQ3c6OsE4E7SYOlRNC6tc92aq0mgM=
=NWIn
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
