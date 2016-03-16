Return-Path: <cygwin-patches-return-8412-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22476 invoked by alias); 16 Mar 2016 09:28:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22459 invoked by uid 89); 16 Mar 2016 09:28:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-87.4 required=5.0 tests=BAYES_50,GARBLED_SUBJECT,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=separated, sk:fhandle, Wolff, wolff
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 16 Mar 2016 09:28:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2BFEFA80685; Wed, 16 Mar 2016 10:28:16 +0100 (CET)
Date: Wed, 16 Mar 2016 09:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Console requested =?utf-8?Q?reports_?= =?utf-8?B?4oCT?= Re: [ANNOUNCEMENT] TEST RELEASE: Cygwin 2.5.0-0.6
Message-ID: <20160316092816.GB28452@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <announce.20160312232737.GA25791@calimero.vinschen.de> <56E80B4B.5040106@towo.net> <20160315134655.GC4177@calimero.vinschen.de> <56E88137.9020307@towo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <56E88137.9020307@towo.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00118.txt.bz2


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1493

On Mar 15 22:40, Thomas Wolff wrote:
> Hi Corinna,
> here is my updated patch.
> >Changelog (old format):
> >Just drop this line from the comment, please.  If you send the mail
> >via git format-patch/git send-email I can simply apply it with git am
> >including the entire text in the git log.
> I hope the comment format is OK now, I cannot currently use git format-pa=
tch
> due to missing setup.
>=20
> Make requested console reports work, cf https://cygwin.com/ml/cygwin-patc=
hes/2012-q3/msg00019.html
>=20
> This enables the following ESC sequences:
> ESC[c sends primary device attributes
> ESC[>c sends secondary device attributes
> ESC[6n sends cursor position report
>=20
>     * fhandler.h (class dev_console): Add console read-ahead buffer.
>     (class fhandler_console): Add peek function for it (for select).
>     * fhandler_console.cc (fhandler_console::setup): Init buffer.
>     (fhandler_console::read): Check console read-aheader buffer.
>     (fhandler_console::char_command): Put responses to terminal
>     requests (device status and cursor position reports) into
>     common console buffer (shared between CONOUT/CONIN)
>     instead of fhandler buffer (separated).
>     * select.cc (peek_console): Check console read-ahead buffer.

Patch applied.  Do you have a short text for the release message?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW6ScwAAoJEPU2Bp2uRE+gLpYQAIhcBAwm196K+pe5M/BrVMm4
4/6BKBy3nPbd9pXn14nQJ6pxO2eUJCGu0vd3fyJfy/M933Bpv3xwlPTjowW4zBAN
wItHRTJsYTNbijmy802NoNjVTt8weWz9Z3yOyNBiYMv4VE8aJ/gt9Mz7XvQ37c9+
pKOhJDieGlw09MSxnfg2Eh2fdciwylEx3WQiMUK3bPwh8AWBS6jCtZuk58h6pNnD
BRbjK6RIyJ1YGBvkTRI0ZDIy1y6XXXw5CH9JgdZgxLJVRLHv4OC6Yf4i+zz7o6ky
6K4K5SPVYeL3Y6IOKpNbp0caH/tTZn1g32KPu7PJzco70UicaZ5XpaSIXXzAq2n4
lz+fBD26t1lrjmtH/tmx9xtqDb8u2lrxTQBkd49qp6QSBGTqI+eu6ho8560WjHOA
2VSukRW5jfjV6QPfGjqMEULuCspztc078C6US5Brzv+FXUDV1+Rm4LZ8LMAGjAk6
FxWguLBj1jEjPOXp45vrTNS0cus9+ZEwyVHJ8jgwx1pl+mCio65aOG9jD1bN4qZ6
9+L4vH05qIFB9l2F4kS2SOFILhoKhz5QZhjk/NKYDfOXM041bFDWh9IeJEicswTw
0kgQxlvpew6zSNIiSPgk+61xEm6aph0Ni7l3OKIpYVEb1eqvCubIavjaIfSETtza
krPAxg91NNMlTvM/zFIM
=nNst
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
