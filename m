Return-Path: <cygwin-patches-return-9853-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 99201 invoked by alias); 15 Nov 2019 12:09:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 99192 invoked by uid 89); 15 Nov 2019 12:09:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 15 Nov 2019 12:09:05 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MOi1H-1iErvl2o6p-00QAOm for <cygwin-patches@cygwin.com>; Fri, 15 Nov 2019 13:09:02 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1D6C4A80A3D; Fri, 15 Nov 2019 13:09:02 +0100 (CET)
Date: Fri, 15 Nov 2019 12:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Trigger redraw screen if ESC[?3h or ESC[?3l is sent.
Message-ID: <20191115120902.GV3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191113104929.748-1-takashi.yano@nifty.ne.jp> <20191114093541.GS3372@calimero.vinschen.de> <20191114205148.4a3c138ab38085f023e677c3@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="faJ0ivz08JzDjTH2"
Content-Disposition: inline
In-Reply-To: <20191114205148.4a3c138ab38085f023e677c3@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00124.txt.bz2


--faJ0ivz08JzDjTH2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1145

On Nov 14 20:51, Takashi Yano wrote:
> Hi Corinna,
>=20
> On Thu, 14 Nov 2019 10:35:41 +0100
> Corinna Vinschen wrote:
> > This is only correct if xterm hasn't been started with the c132 widget
> > resource set to 'true'.  This resource specifies whether the ESC[?3h
> > and ESC[?3l ESC sequences are honored or not.  The default is 'false'.
> >=20
> > However, if you specify the c132 resource, or if you start xterm
> > with the commandline option -132, it will resize when these sequences
> > are sent.  And here's the joke: The resize also clears the screen
> > in xterm.
>=20
> Thanks for the information.
>=20
> > My question now is, does this change anything in terms of the below
> > code, or is it still valid as is?
>=20
> It still valid as is. Bacause, if -132 option is specified and the
> real sreen is cleared by ESC[?3h and ESC[?3l, mismatch does not occur.
> In this case, this patch tries to synchronize the real screen with
> the console screen buffer in spite that they are already synchronized,
> but there should be no side effects.

Great, thanks.  Patch pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--faJ0ivz08JzDjTH2
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3OlV0ACgkQ9TYGna5E
T6AtfA//ZAdJzgkF/xkWnbs4tcUXsXV9tEImPZDio4QqUl45J8aM8iALyE9yhqNF
dJDt5HrNDCX2OcVk+Map2ROWD9vJSftrMiNalsZ4xwWhCiVDBI2mIKzZUMUBmKAQ
hdVghUTee8Fj153B2MXLOsjhd9Ki+fuJgdDpisSuevABGx2Y/rr7czBk+NG2gAIr
gwHXi5O2jee/hRCJw06PSX5RKvCRl7pCKNmyw3XJXTtYBg1wlnf4aq0h0MXYHJ1Y
o0RyYi/P9GrxRYGhISl9bSb+WxmCQMUWY38eSKdwZf6/KvCs7VMgtAEtS52n753A
t6YZqGAfImuGRDdYxqdVV+0BsMGiIoVU3ROxSR46blpBCVpXOFkYqaedK+unRh1r
WPo/2bNAR7tDdnFmeFJbE0VdIsMjVTZinbBxDqKuBoFySn8pdcEOh/TvkAjBv6e3
SXH6x4VadsNc5uoiP5dwFCL7GaRL2qZHp4umhKUyXtR5mCXma+ProeKz8Wvt9w9B
8lEGTQkR1Z8K5QSc/GkcylXL2vZ1E+Vbo88qgYk9EpKbrUO1YXBCVfKjT6+XklmU
Nb0eYuvGOcayEMpT+pzObcdi66H8vTIEr9IQO8SDDwiw23aePM2RwOQJpKHHS6QJ
qGbvdzN0+iih23nph8FcX1Zh5jmDwGdN+vkOH98QrCBBjNh7sEY=
=Ak8P
-----END PGP SIGNATURE-----

--faJ0ivz08JzDjTH2--
