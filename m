Return-Path: <cygwin-patches-return-9958-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126817 invoked by alias); 20 Jan 2020 10:07:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126808 invoked by uid 89); 20 Jan 2020 10:07:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-108.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*MI:sk:2020012
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Jan 2020 10:06:49 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MsZif-1jmoIe1yix-00u2su for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2020 11:06:47 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BF8FCA80734; Mon, 20 Jan 2020 11:06:46 +0100 (CET)
Date: Mon, 20 Jan 2020 10:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Introduce disable_pcon in environment CYGWIN.
Message-ID: <20200120100646.GE20672@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200120025015.1520-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20200120025015.1520-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00064.txt


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 412

On Jan 20 11:50, Takashi Yano wrote:
> - For programs which does not work properly with pseudo console,
>   disable_pcon in environment CYGWIN is introduced. If disable_pcon
>   is set, pseudo console support is disabled.

Oh well, do we really need that?  Anyway, this patch also requires
an addition to the documentation in winsup/doc/cygwinenv.xml.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4le7YACgkQ9TYGna5E
T6Cr0A//Ym9nkRiQl+Vo7uYKQt6KQ0iXYIL3ugN0l1QUV9BIDgu/eBabwPEu8+cW
h1n0LSu1B6SDfTkZhyLCROmk75dXileHBGvddwwwaPUcu8HvZCRmSlqkT8TpgUoT
CMEwJ8L1S07ZlMb0YZ4HbTCC2Eqow7Pc6sP8zlA9y3nRnxLCau7WjpkljLFc8E7N
Rp6gheVAHK70wgYEsjopbQgl9uuZHREc7pU5OQaBdqK1qvHQPRKNjSzMNkCw58DE
qkQiXSFAykSmXtUb9v/6clDfKjyQr4eoj1iHD/GnFreVSt1tSA20Own9wh69QDbr
AZDPEjyag8yOxF6hg2z8j6zchB9FVuNaNEc/jpC2Pn9HVmICU8XlZf0r6UaY401R
wHErtL5gSHmM6qaKiUIdcb62bKj6Q9d9r2WrVDrh8SMEWohvBzI4lxweZaI+GO6I
FDEOZLG/ChJAw00jFR54uiKaUjDw7HXpuOvpHkLt4jy9gB+gvygk5NpeI1q9cdXe
uarJcXrQBGg4tBP5EWo8BSN7PT/LDuuClNgdph4xvZ4Ya6gyE4TlXR2xTlSSVNOM
YZXQY2ErmHolL8655g5Ymwi/TIgbjrOGmMo5jCvDJE/44j2YDf/ImN+3BVSorxkB
q/S27ULyeHK5GxiDRLumjNKdMnHmKl7g6NAv5hbMdHVm/Ysta3g=
=wh2S
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
