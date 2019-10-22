Return-Path: <cygwin-patches-return-9780-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 57513 invoked by alias); 22 Oct 2019 08:02:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 57496 invoked by uid 89); 22 Oct 2019 08:02:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 22 Oct 2019 08:02:52 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MulZl-1i4sTB0jT9-00ro81 for <cygwin-patches@cygwin.com>; Tue, 22 Oct 2019 10:02:50 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 15488A80773; Tue, 22 Oct 2019 10:02:42 +0200 (CEST)
Date: Tue, 22 Oct 2019 08:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-ID: <20191022080242.GN16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp> <20191018143306.GG16240@calimero.vinschen.de> <20191019085051.4d2cc80811854d21b193fed6@nifty.ne.jp> <20191021094356.GI16240@calimero.vinschen.de> <20191022090930.b312514dcf8495c1db4bb461@nifty.ne.jp> <20191022065506.GL16240@calimero.vinschen.de> <20191022162316.54c3bc2ff19dbc7ae1bdedf2@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="lildS9pRFgpM/xzO"
Content-Disposition: inline
In-Reply-To: <20191022162316.54c3bc2ff19dbc7ae1bdedf2@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00051.txt.bz2


--lildS9pRFgpM/xzO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 786

On Oct 22 16:23, Takashi Yano wrote:
> On Tue, 22 Oct 2019 08:55:06 +0200
> Corinna Vinschen wrote:
> > On Oct 22 09:09, Takashi Yano wrote:
> > > I confirmed the dwSize has right screen size and dwCursorPosition
> > > is (0,0) just after creating pty even though the cursor position
> > > in real screen is not at top left.
> > >=20
> > > Clearing screen fixes this mismatch.
> >=20
> > And calling SetConsoleCursorPosition instead does not?
>=20
> For SetConsoleCursorPosition, it is necessary to know the cursor
> position of course. I cannot come up with any other way than
> using ANSI escape sequence "ESC[6n". Do you think this is
> feasible?

Hmm, interesting point.  I think that should be ok for a start.
assuming it works.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--lildS9pRFgpM/xzO
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2ut6EACgkQ9TYGna5E
T6AnohAAmFIM26ID/+pfojiPKbGZLOwA2PuROSLfbcDuuapHE+LPPPmsUchXbah2
f0PPXL79kIyn56GlfuGUHfY3YNFxQaphXen5Q9g+c2ZEpUxxtnAL8lYxNYGrkH8r
KRaHwj7bDUFPnp38Hv9u35JKNaAevsQZiM0EtMFqKfIclSMP/dNtmrM80LXu+87f
hJ3TbuDMPOph+RaFtRGrfhtmWTx1Mh5mM8it4277Fcl0zKjkbmwoakBWm2EAOb0j
niCDyCu6XgShvs87mNuFMSmttnO1WA6/ISXffmGBgafejv/Y7JHMo6zThxsCoimd
STvdgKER8cxqRyS+n/zIHreu+q72UV8dms1OI+JG+NYYfaLsAMCY0lwxUzRK3r7B
qMek/zXfXlHDe3+TTvZbHIuc4FRJVWCayYHuXrltjMN5ArHIP0cGcvzyjX7OD/5/
0kRZFk9pQ3Yjk3I3YHr93HwF5jGT/x9MJORvpZt9kSlcko+VeQkrjXI1CvDcSj9A
Gyglxive7I0xeeu++gEaGbuwkCTZFiWPv9opsmXyO6ITA3UwRSCdLUTRtMokmlbC
ZRCWHEKa0v/j2Z7prjby8UrMqypYFQ9gq3w6KKMPO/T8W83KsE77oVZLHt3/TjyQ
c/NAO4Ge1h6hG2+CwisEedceH2e4SHEsPk2GDi4OpPqlOF1MLg8=
=H07b
-----END PGP SIGNATURE-----

--lildS9pRFgpM/xzO--
