Return-Path: <cygwin-patches-return-9850-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 37954 invoked by alias); 14 Nov 2019 09:49:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 37938 invoked by uid 89); 14 Nov 2019 09:49:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 14 Nov 2019 09:49:15 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MvKL3-1heK520xO5-00rGdg for <cygwin-patches@cygwin.com>; Thu, 14 Nov 2019 10:49:13 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 641BAA80A39; Thu, 14 Nov 2019 10:49:12 +0100 (CET)
Date: Thu, 14 Nov 2019 09:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Trigger redraw screen if ESC[?3h or ESC[?3l is sent.
Message-ID: <20191114094912.GT3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191113104929.748-1-takashi.yano@nifty.ne.jp> <20191114093541.GS3372@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="czsrKamv0OtYjSMr"
Content-Disposition: inline
In-Reply-To: <20191114093541.GS3372@calimero.vinschen.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00121.txt.bz2


--czsrKamv0OtYjSMr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1317

On Nov 14 10:35, Corinna Vinschen wrote:
> Hi Takashi,
>=20
> On Nov 13 19:49, Takashi Yano wrote:
> > - Pseudo console clears console screen buffer if ESC[?3h or ESC[?3l
> >   is sent. However, xterm/vt100 does not clear screen. This cause

Btw., this is not pseudo console behaviour per se, but the standard
behaviour of the new Windows console with VT ESC sequences turned on.
You can try this in a normal console under Cygwin.  It will clear the
screen after ESC[?3h, but it won't actually resize the console to switch
into 132 column mode.

This probably won't matter much for the problem at hand, I'm just
writing this so this is mentioned somewhere searchable.


Corinna


>=20
> This is only correct if xterm hasn't been started with the c132 widget
> resource set to 'true'.  This resource specifies whether the ESC[?3h
> and ESC[?3l ESC sequences are honored or not.  The default is 'false'.
>=20
> However, if you specify the c132 resource, or if you start xterm
> with the commandline option -132, it will resize when these sequences
> are sent.  And here's the joke: The resize also clears the screen
> in xterm.
>=20
> My question now is, does this change anything in terms of the below
> code, or is it still valid as is?
>=20
>=20
> Thanks,
> Corinna
> [...]

--=20
Corinna Vinschen
Cygwin Maintainer

--czsrKamv0OtYjSMr
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3NIxgACgkQ9TYGna5E
T6CLOBAAoY3LRBJjX7paUzYVPOBvT6FaAgtTL1MsQtFU7uPCHUSMYImWoE/WkE1b
RyKVry6EEaBZe7oFTeaIHJRG78tDInhmczUtfWHkDkEN4mpkL/rN1GrOo1PJCBHJ
g9aZZRrxASu4vLKAl4XrC+HRBdEB1TfTt/G1bBL2J06uVG7tEidAY0MJJ6pPv6fJ
GmaTIoJ5x6Gnks7IXtWVW+MoD1NIx4AzUi1m+PQMBTwuLLUuY5ZypcSl3d3+HvYN
krNJy964wRwGtEhC9yjUgGDQFCNssz3d/JgiHNmrIibwZew4ra76PYngjdhIEwxE
gZTJgJBI0ppPUkfxMpsGl7Qc4aMRyUSEeMydJg4fiA/W4fkXu6n3FtiHch83NE1c
KWxiOwECW0AGesKi1eezS/V1yVGO09meO889MIiUGQz3oMrO8gc9iC9en7jkkatr
bM7Fos0SPZgR+VtDOW50Mnp/pPNcDWsj5CnM41KQuNp4wanLGx01/lbpTXy/dmdy
C6j2SgJw0dwaARJnJpbid8Hj3vfac24+CSXJsH/89OUpUZnXISgMizXkNfbxVnQ8
EAhv/07xYFQipbI7Eb4RKJF9hktyfMvSMR34bp+bVuGFZnuiVwsgGkJL3fiSfqCz
FrQnd/Yh/dQydrIq3zEtfCrhqCBWRztDwGyuBporhiz6olxTMFM=
=hswm
-----END PGP SIGNATURE-----

--czsrKamv0OtYjSMr--
