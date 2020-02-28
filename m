Return-Path: <cygwin-patches-return-10145-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123959 invoked by alias); 28 Feb 2020 19:11:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123944 invoked by uid 89); 28 Feb 2020 19:11:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Feb 2020 19:11:33 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MzyAy-1jMgp73ex4-00x1q2; Fri, 28 Feb 2020 20:11:27 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 40266A819D3; Fri, 28 Feb 2020 20:11:25 +0100 (CET)
Date: Fri, 28 Feb 2020 19:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com,	Hans-Bernhard =?utf-8?Q?Br=C3=B6ker?= <HBBroeker@t-online.de>
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
Message-ID: <20200228191125.GM4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,	cygwin-patches@cygwin.com,	Hans-Bernhard =?utf-8?Q?Br=C3=B6ker?= <HBBroeker@t-online.de>
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp> <20200226153302.584-2-takashi.yano@nifty.ne.jp> <05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk> <20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp> <20200228133122.GG4045@calimero.vinschen.de> <20200228144459.GI4045@calimero.vinschen.de> <20200228144905.GK4045@calimero.vinschen.de> <20200229020604.6e1e7f204349b4b84e813dae@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="mlvFMpb4NrD3AMcD"
Content-Disposition: inline
In-Reply-To: <20200229020604.6e1e7f204349b4b84e813dae@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00251.txt


--mlvFMpb4NrD3AMcD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 449

On Feb 29 02:06, Takashi Yano wrote:
> On Fri, 28 Feb 2020 15:49:05 +0100
> Corinna Vinschen wrote:
> > Also, on second thought, given wpbuf is global inside this file, doesn't
> > this require guarding against multi-threaded access?
>=20
> wpbuf_put() is used in write(), and almost whole of write()
> code is guarded by output_mutex. So, I think it is already
> thread-safe.

Ah, right, thanks.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--mlvFMpb4NrD3AMcD
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5ZZd0ACgkQ9TYGna5E
T6C+LQ/+KKJIuOjP4/YOq3WBm0XSuLYJCSzKE4AxYUz875wh/ijmv1D6N89V4Ayh
v4HAUlAYz2szuNccSyhmvc6uS1fsBuwWXE1MVBMb8vj4vHUnPfASwoXqH6eVPSPH
NdbPnU6l6eWmo9cATofzv1HahoGLJH+RaHVpOu3X5wDq4V92cdrUxhnoBj0KbMga
KhipA6yvxc7oFx7EPg4jslrzoWtBJ83/TzyGq0fNnoKCxENVHMsAMVauVB2gM/0q
77Ik4hAKwzknUPIQkPGAGwQFoV/DBuL//4UjIrOa5KKUpyTHccWcF2j6qzt9mroZ
PxConKxu9+34nZJoZ4ZnFmFaCEy07unia0ujEvr08ByOMklQosX7fdlAWdTaHlTr
9v7MDTIjmLumLYaWeVNbZxgJrmvcuUwq6lemedaqe2TWMjghWXQo7rlvuPRqVH8s
CJooBElgqmlDVWl+IeuQyx0Ic551gbSZoi5cNiTzkZm7TwFRQ1EVKgAY2sNeorFa
DuiAqVmloUYw+vkg/DfutpV1idznevYkBj7c0SgEF8W/1UTX8/Bg/bj3RdrLimUl
FERx+4WIaf7+8IwaPgSPkJng3ApQEFazhJ/h4rIvzwvp7WAfeLBxgkABJ2pO5NhI
ohVKGo7AnI9YM0hSYtOhregtAaTgz5MBPVVmg/hsXcZ7psIbZHk=
=EXZb
-----END PGP SIGNATURE-----

--mlvFMpb4NrD3AMcD--
