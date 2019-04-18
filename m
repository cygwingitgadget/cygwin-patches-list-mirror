Return-Path: <cygwin-patches-return-9367-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 78613 invoked by alias); 18 Apr 2019 21:19:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78604 invoked by uid 89); 18 Apr 2019 21:19:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, rights
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Apr 2019 21:19:30 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M58SY-1hIKtC1Z6C-001Bej; Thu, 18 Apr 2019 23:18:34 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4219EA80736; Thu, 18 Apr 2019 23:18:30 +0200 (CEST)
Date: Thu, 18 Apr 2019 21:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,	Takashi Yano <takashi.yano@nifty.ne.jp>,	Mark Geisert <mark@maxrnd.com>
Subject: Re: Cygwin patches (was Re: [PATCH 00/14] FIFO bug fixes and code simplifications)
Message-ID: <20190418211830.GK3599@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,	Takashi Yano <takashi.yano@nifty.ne.jp>,	Mark Geisert <mark@maxrnd.com>
References: <20190414191543.3218-1-kbrown@cornell.edu> <20190416112243.GR3599@calimero.vinschen.de> <87o95435qo.fsf@Rainer.invalid> <f477bb3d-1918-3b25-9682-a3b187a12dc2@cornell.edu> <87h8awa278.fsf@Rainer.invalid> <0e2c6674-af17-a6e9-54e3-1ec374712832@cornell.edu> <87bm13dv5a.fsf@Rainer.invalid> <20190418190402.GI3599@calimero.vinschen.de> <09dc74df-bda9-4dba-bb3e-f508afa31851@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="EsfvRFssnM00t552"
Content-Disposition: inline
In-Reply-To: <09dc74df-bda9-4dba-bb3e-f508afa31851@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00074.txt.bz2


--EsfvRFssnM00t552
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 723

On Apr 18 21:00, Ken Brown wrote:
> On 4/18/2019 3:04 PM, Corinna Vinschen wrote:
> > Ken, you have an account on sware and check-in rights to the cygwin repo
> > anyway, so you don't really need me to push patches.
> >=20
> > If you feel up to the task, you can also go ahead and review and
> > ultimately push patches from others.  This also applies to Takashi's
> > ConPTY patch as soon as he wants to go mainline,
>=20
> I can do that.
>=20
> > as well as Mark's
> > sched_[gs]etaffinity patches, after review.
>=20
> I'm not sure I'm qualified to review these, but maybe he won't wait until=
 May :)

I'm pretty sure you are, but it's your call =F0=9F=96=96


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--EsfvRFssnM00t552
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAly46aYACgkQ9TYGna5E
T6A70w/+J5+Nyb3TMwcMAkTAJ3cXg5HBaiyfaGzSWJ13hduJ08N8HFUKKVydhCYl
BXBTCiDkIEAKDINwEL3uOehLjlpNR049pOELhEdAfyO3x22yk2MHKulWCTDTIs5g
uYxCjexpLBU4K+f2/CmmXLEnqru2yCxOctrU7cF12zWzwOzz2unegkK0KA2uZR5K
Ob8P9HnAvCHrWV7NWTKgqbrdJpK+/EktaypiNsBMbVlsOUJcgYgp+uDe4Hxerobk
oeZozX6BHMxV01H8PB6EjW4axz66ncD3Pv6zF+xWtbJ0/GmvGDjjM2PxholegQZr
niIQBh+Q1y475u9ccypuUyVU9ob0o5tYdjBF3usXuQJ18ol2IbIEPMBG65fLeghL
d922ugeVy/sYCHl5ZireBfLombQKRnE6cO062gdIn11zKdB7iDHN7I5yO3yMDMbP
jAThuqaajDLEaPd27GQoqPIzxpAq+ux2xYcDawUKnkETXBjZv7WuTpxH9O41eagW
RqaE0XCLzyMWq47smGpdj+Q/MeJFrHKbeCPvBWP//vJVLdfeps4XG4+kgTwtUalP
O3xg5HZ4Abq1DAfHAX7Egk2PyKBen0MGouCF2CVHksg6U5BmzNIM2RR4tzIYUDoA
6Wh6kV385EQKsAP3Btrt6vpCcOIOiYCde9Hgnjp4LNJeUUdMW9o=
=9MrE
-----END PGP SIGNATURE-----

--EsfvRFssnM00t552--
