Return-Path: <cygwin-patches-return-9795-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 45265 invoked by alias); 24 Oct 2019 13:33:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 45253 invoked by uid 89); 24 Oct 2019 13:33:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 24 Oct 2019 13:33:08 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MXYEr-1iVeo91L95-00YwTX for <cygwin-patches@cygwin.com>; Thu, 24 Oct 2019 15:33:06 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 82853A8045C; Thu, 24 Oct 2019 15:33:05 +0200 (CEST)
Date: Thu, 24 Oct 2019 13:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-ID: <20191024133305.GF16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191022065506.GL16240@calimero.vinschen.de> <20191022162316.54c3bc2ff19dbc7ae1bdedf2@nifty.ne.jp> <20191022080242.GN16240@calimero.vinschen.de> <20191022182405.0ce3d7c17b0e7d924430b89c@nifty.ne.jp> <20191022134048.GP16240@calimero.vinschen.de> <20191023122717.66d241bd0a7814b7216d78f5@nifty.ne.jp> <20191023120542.GA16240@calimero.vinschen.de> <20191024100130.4c7f6e4ac55c10143e3c86f6@nifty.ne.jp> <20191024093817.GD16240@calimero.vinschen.de> <20191024191724.f44a44745f16f78595ae1b43@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="rd/3IrB17klb+Ksj"
Content-Disposition: inline
In-Reply-To: <20191024191724.f44a44745f16f78595ae1b43@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00066.txt.bz2


--rd/3IrB17klb+Ksj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1109

On Oct 24 19:17, Takashi Yano wrote:
> On Thu, 24 Oct 2019 11:38:17 +0200
> Corinna Vinschen wrote:
> > Well, what I see when starting cmd.exe with this patch is a short
> > flicker in the existing output in mintty, but the cursor position
> > stays the same. and cmd.exe output is where you'd expect it.
>=20
> I mean:
> 1) start mintty
> 2) ps
> 3) script
> 4) cmd
>=20
> In my environment, output of ps command disappears.

In mine, too.  This does not occur w/o running script.

> > If it's running as Local System (actually SYSTEM), it should have
> > the user SID S-1-5-18.  You can just check this with
> >=20
> >   cygheap->user.saved_sid () =3D=3D well_known_system_sid
>=20
> Thanks for the advice. Now I have confirmed the following code
> works as expected.
>=20
> inline static bool
> is_running_as_service (void)
> {
>   return check_token_membership (well_known_service_sid)
>     || RtlEqualSid (well_known_system_sid, cygheap->user.saved_sid ());

Why don't you use operator cygpsid::=3D=3D as outlined above?  That's what
it's made for :)


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--rd/3IrB17klb+Ksj
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2xqBEACgkQ9TYGna5E
T6BA5g/8C2sEVID7O02Jg3y1iJ+rNfhRrV5Jcbg2WeTOrHafY9LleXlE3OsNUXCk
7FlIVzz1mUM5VsOa7SuSdsLtq0LiLLU75VqYjVBoYujSiGn3nCdR0ri9Otxtr3tA
Jx3RPYc78jiyjdipYKYvbUAtmfZBvYGl6nejNuH2LOaVh0lz0o6yFLd8BBtPW6f9
a7HKvkHiHwxKLPoU+aAv0b4LfRSAvNQTQvQkB1U7jHlopHmZd0lFEv5m/Cym/uoB
LorA3HaAqSDUsOL3VaK5S+y63fRVE/AJTcKnFTI5ychvPKWDdzJzCVLb7AwLaV2g
lkrAhe9HM7T/FtK1SDe3pMBZ96EjHpG1t3Ey3sa1qk3vOvqpJtUUtbU1WC/z1pjk
JnPkxje99e7KGGhOwT8gG3pvu9tcJuaBiY+m5y3N4rmowqrj17Zj/NRkckyAk/Su
wlCDpe2ODYLqW5tlQi/bNKHUSXu/oy6w3PKTssfvFk3+UcLXr8qVoZd9Jf8glGll
APpKaWkpM4/iAsdR89FhQxsJaxhA2A05DRczHA+WMkv2xx6jbHrX07ZlJSWhHd1I
TGkGZExasqCLPnKenDZ+U/vTddh/6bslYpodnExYMTVE/6Me5pnDsXbn64OP8U6m
YNY3eaP5IfXCPTDemW2YmAXgYWVZXtnqZK4eLARE+TEm4P5oPLc=
=qaGj
-----END PGP SIGNATURE-----

--rd/3IrB17klb+Ksj--
