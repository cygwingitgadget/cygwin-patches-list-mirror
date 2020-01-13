Return-Path: <cygwin-patches-return-9914-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 103188 invoked by alias); 13 Jan 2020 16:01:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 102779 invoked by uid 89); 13 Jan 2020 16:01:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-112.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 16:01:01 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M42X0-1ir29C4608-0005x2 for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 17:00:59 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4C4FEA806B2; Mon, 13 Jan 2020 17:00:58 +0100 (CET)
Date: Mon, 13 Jan 2020 16:01:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Revise the code for setting code page of pseudo console.
Message-ID: <20200113160058.GL5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200101065036.8850-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="nOM8ykUjac0mNN89"
Content-Disposition: inline
In-Reply-To: <20200101065036.8850-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00020.txt


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 242

On Jan  1 15:50, Takashi Yano wrote:
> - Fix the problem which overrides the code page setting, reported
>   in https://www.cygwin.com/ml/cygwin/2019-12/msg00292.html.
> ---

Pushed.

Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--nOM8ykUjac0mNN89
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4clDoACgkQ9TYGna5E
T6Cefg//Z4pfgQeQnyStuEW0c6Qi6SQn94C14hIkRXsj1Bus4znucV109dIHwj0n
gluqFTlvP/rF8ivJAU6gWqUQkjZ25RtQFIbBeS9XzOLHvXJvn4SePONJNWAGwvVa
jt9ZfN28Kq+50kpInVdiNMAxdhHu3XzB0zY6E1bvDp6gnjbvDtc1gaXhQfovRvl9
TmUQMuy44Bg5MfVaZtz4L4u6u8vjwReT3klUCjENACTLmUQGtP0tLJoPF3zHwOng
o9jFOijRzeBFcXgQ3X+oTF80rMrT4pdOcSra8Br6VjAmf7PyJ44SuuFnpRzg5lP7
ylj6Erbkx9GD7END9KLE7L77QkTmVB3UNIH7Mqp8R79YLBrxKCxd14lkGEh+yWtC
8y/Y7cKjGnzZT/p7n39k2R+m/8IwAnO3pFOP/tbr7oTjmIQPDyeorWq68lYLoz5H
3kWCMX88NP/uP+dcaILD1rUP5NXkcBARFFRfrdQ3v/rnyMnTEH5gYkG254Bw2tu4
SUKW5rJtliVnvyqz5Rb0c6xskfecFav/W4qOo4uHPSZyOXMT2oYooGod7xmdKrhb
D4VpSzUFG5TrYlIv/TbjpJrJJPFdY5dmlyzmahz/E7f/PEZ2WInNulRVezJ1Kpl4
42lyZkosLLOVvRB31DGCi8Udd9R4JbbvBL82bbkvZOLBjoaKbus=
=V/DR
-----END PGP SIGNATURE-----

--nOM8ykUjac0mNN89--
