Return-Path: <cygwin-patches-return-9998-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29251 invoked by alias); 24 Jan 2020 10:26:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29239 invoked by uid 89); 24 Jan 2020 10:26:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 24 Jan 2020 10:26:30 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1McHQA-1jSu0l3hOe-00cjC8 for <cygwin-patches@cygwin.com>; Fri, 24 Jan 2020 11:26:27 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 55337A80BB0; Fri, 24 Jan 2020 11:26:27 +0100 (CET)
Date: Fri, 24 Jan 2020 10:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add missing console API hooks.
Message-ID: <20200124102627.GE263143@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200123043312.529-1-takashi.yano@nifty.ne.jp> <20200123124813.GC263143@calimero.vinschen.de> <20200123220531.d6dcf35ce81f4fa17b0788a6@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <20200123220531.d6dcf35ce81f4fa17b0788a6@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00104.txt


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 994

Hi Takashi,

On Jan 23 22:05, Takashi Yano wrote:
> On Thu, 23 Jan 2020 13:48:13 +0100
> Corinna Vinschen wrote:
> > On Jan 23 13:33, Takashi Yano wrote:
> > > - Following console APIs are additionally hooked for cygwin programs
> > >   which directly call them.
> > >   * FillConsoleOutputAttribute()
> > >   * FillConsoleOutputCharacterA()
> > >   * FillConsoleOutputCharacterW()
> > >   * ScrollConsoleScreenBufferA()
> > >   * ScrollConsoleScreenBufferW()
> >=20
> > Which Cygwin programs are doing that?  They wouldn't work correctly in
> > ptys anyway, isn't it?  Does it really make sense to make them happy
> > rather than requesting to change them?
>=20
> Just a possibility. There is no specific example.

In that case I'd prefer not to apply this patch.  Using native Windows
console functions in a Cygwin application just doesn't make sense, and
we shouldn't support that beyond what's necessary for older, existing
applications.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4qxlMACgkQ9TYGna5E
T6CjOxAAil+QtdbAi94zaKyLEplIi7pApp7aBKsOc/gDved5SpLV0ZI0zaTMGAu7
3gh7HWUwc2UtiIN18FIgmcLOfgUTQAZek8JCRSmgcQX9LyaoNiXx0c4ms3yG1IpD
lfbF/xHurHpBVbWEhvINaZPEvQU7mZnMdJFm4qvd0NIIUnHqsg9gdtMKrgII0vXM
Dpz74h+8a5XwRZC/UJwGYq3go3ER4SpBxXWnQML7BAcGlFnPQ6kabq9pnITMdrPe
DOFj6loGWfhJbAghsSoIwmsyz5pNFh3UyqdyxnCgrXe9P9juaQD0eh4lvkkJKkHW
sb5X2R+artywwXvMijoCLZ/YbQcS2eP/2tz2EzyZOZt9h59hj0RYYw0xROayyzDi
Y/rswgDSQHoZP96EdoC5AneEBI9VzfD919qS92jYQcGzm1EzgVSkKH9ou9yfM/vR
YpjKS0qPepbBWJ5SrHU5r4Bc5xploYzssohyC7I/pAEqPeionSjlz+W7MUGta0Dl
Gifo7Qt03AXUvcP31jV1282XmJTpSPxdCWEXuqR1oPgZy/OB/2v5tYgxkljRUgMw
+5N3tMO/5CLvit1l/57HYqHMLJk0XVLo+RNX1iVzUH+u65PWAZDAx6qL87mlWXL+
Cz114f089CJ5JX+IOz0jDY5V2SJ4Wpg9n5emaR/Js6twTZNKUqc=
=JdmA
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
