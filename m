Return-Path: <cygwin-patches-return-9363-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 57731 invoked by alias); 18 Apr 2019 19:05:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 57714 invoked by uid 89); 18 Apr 2019 19:05:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:883, H*Ad:D*ne.jp, checkin, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Apr 2019 19:05:01 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M1HmG-1hFXMy09rG-002lnS; Thu, 18 Apr 2019 21:04:06 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 94882A80756; Thu, 18 Apr 2019 21:04:02 +0200 (CEST)
Date: Thu, 18 Apr 2019 19:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>
Cc: cygwin-patches@cygwin.com, Takashi Yano <takashi.yano@nifty.ne.jp>,	Mark Geisert <mark@maxrnd.com>
Subject: Cygwin patches (was Re: [PATCH 00/14] FIFO bug fixes and code simplifications)
Message-ID: <20190418190402.GI3599@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>, cygwin-patches@cygwin.com,	Takashi Yano <takashi.yano@nifty.ne.jp>,	Mark Geisert <mark@maxrnd.com>
References: <20190414191543.3218-1-kbrown@cornell.edu> <20190416112243.GR3599@calimero.vinschen.de> <87o95435qo.fsf@Rainer.invalid> <f477bb3d-1918-3b25-9682-a3b187a12dc2@cornell.edu> <87h8awa278.fsf@Rainer.invalid> <0e2c6674-af17-a6e9-54e3-1ec374712832@cornell.edu> <87bm13dv5a.fsf@Rainer.invalid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="o6aug3O60clXg2rj"
Content-Disposition: inline
In-Reply-To: <87bm13dv5a.fsf@Rainer.invalid>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00070.txt.bz2


--o6aug3O60clXg2rj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 817

On Apr 18 20:29, Achim Gratz wrote:
> Ken Brown writes:
> >> Take your time and thanks for working in that area.
> >
> > I've just sent an attempted fix.  There may still be more changes neede=
d; I just=20
> > made a minimal change to make my STC succeed.
>=20
> No testing will be possible for me in the next two weeks, sorry.

I'll be afk all of March, too.

Ken, you have an account on sware and check-in rights to the cygwin repo
anyway, so you don't really need me to push patches.

If you feel up to the task, you can also go ahead and review and
ultimately push patches from others.  This also applies to Takashi's
ConPTY patch as soon as he wants to go mainline, as well as Mark's
sched_[gs]etaffinity patches, after review.

You know the drill :)


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--o6aug3O60clXg2rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAly4yiIACgkQ9TYGna5E
T6AJNhAAiWzVmglZI93Bilit0lZEg9IXs94HvUStsWDysoWuhNG9H92rCOaBGd5F
uNQSJJtPdhoQknW1K4Ozu7d46GI9Jr4OmlI8xQH9KyPAMmqJBQlzntueQiLPVX5F
Cm7EFhH0D8gKJHG0kpk8hjxYuqXnW8xYNZMduI3ThlV24PHNN/h0ICcje85cU1o0
0dSpXsle6H8bODpMN4QpKDF/4mqvEQv53l7eS4JJ0P4Ciuawi3d1bi/kT9Q+Jr/0
dv+MGLzVlLCLD+vQUxDxrZoGEgo/4fajxmfh+8NBL6kTBew3u7vKzKVugbPffxV9
p5HxV1B9ljQBXCm/PFat3NKyxZIBfMm/w2OtiavAY9IGxtnutyNGhWZa37cjp401
e1HNCmWpyCXYAEaAWKzWfZqqB81mhbjCg77P0cPX2ddNlw8kmT6t/lG7c+zNp0Us
OG2HEiEzkatKeEkJiX9VxYi0r1GmlAVPD6p6J2Ra+FSZxWuwRH9NSjgHsRamQSpj
HX+0Ax15coT0aOCUyDBVYboV01G6/F36uGm+AZV7caK8+spSJsRuKrEFbhj9SutG
qYySeMyW8KqZVdWNC0J6tocgP1xjKdLfbVwtkqr69r1EEuTG9v+6LL3sJbfOFT3o
K510zDQhsCdl+8W7ADQTlDxyPxo3VCLk2DATojg6En9bqbQEr+8=
=N47D
-----END PGP SIGNATURE-----

--o6aug3O60clXg2rj--
