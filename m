Return-Path: <cygwin-patches-return-9983-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112469 invoked by alias); 23 Jan 2020 12:48:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112420 invoked by uid 89); 23 Jan 2020 12:48:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-108.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 12:48:18 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M8yPu-1j0dWC0QJK-0069gj for <cygwin-patches@cygwin.com>; Thu, 23 Jan 2020 13:48:14 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B8B83A80BA7; Thu, 23 Jan 2020 13:48:13 +0100 (CET)
Date: Thu, 23 Jan 2020 12:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add missing console API hooks.
Message-ID: <20200123124813.GC263143@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200123043312.529-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20200123043312.529-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00089.txt


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 547

On Jan 23 13:33, Takashi Yano wrote:
> - Following console APIs are additionally hooked for cygwin programs
>   which directly call them.
>   * FillConsoleOutputAttribute()
>   * FillConsoleOutputCharacterA()
>   * FillConsoleOutputCharacterW()
>   * ScrollConsoleScreenBufferA()
>   * ScrollConsoleScreenBufferW()

Which Cygwin programs are doing that?  They wouldn't work correctly in
ptys anyway, isn't it?  Does it really make sense to make them happy
rather than requesting to change them?


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4plg0ACgkQ9TYGna5E
T6Bi1A/+Nz+jVdTTZm5O4PE433bd+BlO+utVOayRq8/gNT8KC1a2atn7opQv+eql
RVo65uOUYKJ7AVcz/VKwhmPa/KhphzYrAogXqKcfduZ1o1gmuLKjLJgjIqA+PFND
JjYP5Hw5thGxTrGA8BgurVln7itP4oNr06GAcbbO0vd9UJNbREuYZjRTOjJ4F0B/
W0HdcSrSJziNJN7+dqOtjuGTLFOx1HKnkCHbEFJhWdNmJx0DSZMA5Pq2Ehr2rT5v
ReSIhwI30KoRVwBKUKNhFPhjTL8wvYB7VOK57PXpqoMM1eporDLjiRhbS2+MEn+f
ZguMVMnvlDpg4V1fUXEL6/CnziIis6CJEs9CayRYZvR/z5pCvROBDyzAm+Hl8qA2
5c3HvwhUFVoOlROu/s4mMimTx/X22431MxcXQf8O+KkqyW9Ubv0THx8ionNm+UcB
Nj/R02vJVq+c5iG6nGtDFlOwKWJoSEYzMjtgKP+72MUJhmwTFDbSYowfIiNNnOFo
tAiHxhp8LJ9JlMt+qKZ+ojFEG0b4DryH2ceAYfI0OgOZcFkpGdc5iF8lG7SXIwsy
JQSKl8gPM9Lxp4Q6IkrNrYwXydnOkd5ffdMcm+WAjKjW1L/qYchmqhBa5V+G+yVS
Vwgkez4dVDwqbQS2cp07UjrgZLgFqNy71X/m5RiwThhN839X8/Q=
=0iAV
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
