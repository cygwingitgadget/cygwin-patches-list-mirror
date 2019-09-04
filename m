Return-Path: <cygwin-patches-return-9623-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 89289 invoked by alias); 4 Sep 2019 14:04:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89280 invoked by uid 89); 4 Sep 2019 14:04:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_SBL autolearn=ham version=3.3.1 spammy=
X-HELO: mout-xforward.kundenserver.de
Received: from mout-xforward.kundenserver.de (HELO mout-xforward.kundenserver.de) (82.165.159.39) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 14:04:30 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MGi6m-1i0cLB1y9S-00Dqkn for <cygwin-patches@cygwin.com>; Wed, 04 Sep 2019 16:04:27 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EABA5A8035C; Wed,  4 Sep 2019 16:04:26 +0200 (CEST)
Date: Wed, 04 Sep 2019 14:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/1] Cygwin: pty: Add a workaround for ^C handling.
Message-ID: <20190904140426.GU4164@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190904134742.1799-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ShzQXCswyqjgWi6k"
Content-Disposition: inline
In-Reply-To: <20190904134742.1799-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00143.txt.bz2


--ShzQXCswyqjgWi6k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 676

On Sep  4 22:47, Takashi Yano wrote:
> - Pseudo console support introduced by commit
>   169d65a5774acc76ce3f3feeedcbae7405aa9b57 sometimes cause random
>   crash or freeze by pressing ^C while cygwin and non-cygwin
>   processes are executed simultaneously in the same pty. This
>   patch is a workaround for this issue.
>=20
> v2:
> Make the behaviour of pty and console identical.
>=20
> Takashi Yano (1):
>   Cygwin: pty: Add a workaround for ^C handling.
>=20
>  winsup/cygwin/fork.cc  | 1 -
>  winsup/cygwin/spawn.cc | 6 ++++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--ShzQXCswyqjgWi6k
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1vxGoACgkQ9TYGna5E
T6DVbA//YUiRnNmsE/TqrT44YVMHTzBQgZOAJLmv+eMAn1w1K3V574DT7QAb3cqX
cHjifrtyqVGVGlGf/epL37AMOUIv6qfkuF3gjLf3BhgmAmjdJn/vKrE130oYXwPF
viqpL0Qdtubi8ek1DDWzA3cVRa7kPyrAuBAXDdLSDCyDyKViJHSBLl/m/oz++3+4
ZgiG9aPRZ6UkYi3VdhAtqket87zJbwedPXrfa71zkISVPHzWCoDo5jQDWFH0Fyy1
LhklWiPpilj7+5KnBPPALDCeklaeOCQYUuzY/ItfYMnlrNgoG6nWqiXFtsWpIZCK
j92JpQ1qtK5DEJcRunDGWp+Ug+w9qxkNs33FBt1B1OQ3bn6LTt2WWdKrnFwQq2mG
10BKlA/ugiuC1Zh0VVXMyiig9fK0Nora+G49lxxgsBgDeRqeapjXtJlYJIuBZz2j
toOPZIFW2mtmUTeJQLGpJnQ4RotrAJa76c7S2Bp9vhGFXhFRPhqg1sa85It1hdYH
uFjDjvQLbGG0mQC/0gBsS1WNfr9efQvIfPOlpCSwxDprUXB0vclZ9GxMFGFI4ybZ
jmoBtztQKs1Au7BrujO2Kb0FYvQ3V1oKmVwv0ysiRGF5asMjoIcoEe3pHughYibn
eg9Xh2Kdhjv+ArJP5iMEsicC0jzRMBJHscxQT14MeXhFxZ63YRc=
=najU
-----END PGP SIGNATURE-----

--ShzQXCswyqjgWi6k--
