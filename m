Return-Path: <cygwin-patches-return-10057-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123009 invoked by alias); 10 Feb 2020 10:07:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 122996 invoked by uid 89); 10 Feb 2020 10:07:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.1 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=identifying, willing, para
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Feb 2020 10:07:14 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N5W4y-1jYp1B2Qdm-0170Ax for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2020 11:07:11 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AEAA0A80CE3; Mon, 10 Feb 2020 11:07:10 +0100 (CET)
Date: Mon, 10 Feb 2020 10:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Introduce disable_pcon in environment CYGWIN.
Message-ID: <20200210100710.GD4442@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200121222329.69f71c847e97da78955735a7@nifty.ne.jp> <20200121132513.3654-1-takashi.yano@nifty.ne.jp> <20200122100651.GT20672@calimero.vinschen.de> <a5724cea-edda-6ab9-fc7c-cbf3ad3091cc@towo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <a5724cea-edda-6ab9-fc7c-cbf3ad3091cc@towo.net>
X-SW-Source: 2020-q1/txt/msg00163.txt


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1334

On Feb  8 18:13, Thomas Wolff wrote:
> On 22.01.2020 11:06, Corinna Vinschen wrote:
> > On Jan 21 22:25, Takashi Yano wrote:
> > > - For programs which does not work properly with pseudo console,
> > >    disable_pcon in environment CYGWIN is introduced. If disable_pcon
> > >    is set, pseudo console support is disabled.
> > Pushed.  I just fixed a missing </para> in the doc text.
> >=20
> Sorry I didn't notice this before. I think rather than having to decide a=
nd
> unconditionally switch on or off, a better approach would be to
> automatically enable pseudo console when forking a non-cygwin program onl=
y,
> or have that as a third option. (I think I had suggested this before.)
> It's good we had pseudo console in unconditionally now for a while, as th=
at
> apparently helped identifying a bunch of issues, but targetting it to whe=
re
> it's really needed would further help to avoid future trouble, including =
any
> performance issues as recently reported.
> I'm willing to prepare a patch if desired, as I had implemented that
> condition already for my earlier "winpty injection" proposal.
> Thomas

Interesting idea, but given that all the Pseudo Console code in
Cygwin is from Takashi, he should decide how to go forward.

Takashi?  What do you think?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5BK04ACgkQ9TYGna5E
T6DhHg/+P/IumBr2ZLCdD/TLj3kQ1OYK7SeSfwjWx6t3FWq3hdu2jWh9A9dK6NwL
izkahbSC6dxKgwU4HFPW96ET/OfZfD8UStdMAMCiuZ4EZ1BgjsrM337e3cjwEE0M
wI2D40FWNtGn0FDSRpeIO6YjJ3g7iH6gq3vEkk252sOXMii6ECaiKlZZ9OKoKQ9+
CMmUoHxhlEn2fO9GDDe/cInIa8OQW15Ruie3v9Fp7USdGp9SfNwb1ubaCJOYo58M
vekEU0/QQaIKiFtVz8RIqyp/UGNQFsU1NzikhLH1AT1vKhr0Vo4+d8Efx2K598or
n+yaaNJTXL6DK7OUGKxWGJSAmwI38/tCMvXycXVaVLMHmkcpZI6Rd4j9Vl/Xp8WC
pXjA8Jf0nONj0Rd16+DnIoRUkzon+5qfkzPPodvvclfGd7/ZhHJtcrDwwJ/Au2aI
ONfQF1POeXanXPfjD+IVs4vNoQ+AuG0rcln11wmide+dskQzb4qkK3CEWuOnzg1W
g8uUpY36I+PO3EEzobuGLrp6ZbiBgP39AreFdp5QLTlMTE8NPJ7hTP54RBBS766w
eFhCBMgbeF3DN/OWu8HP/6JZTFf+wS5X4U+j2dOB5U9uDR4Nm+KNXfnR3NT872VZ
CZ1OtTX2KiYTAH6wFTMRAD4d9y+QelsSMeWd9PpVfLGdZBrU1P4=
=9mFo
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
