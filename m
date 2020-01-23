Return-Path: <cygwin-patches-return-9984-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115434 invoked by alias); 23 Jan 2020 12:51:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 115425 invoked by uid 89); 23 Jan 2020 12:51:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 12:51:57 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MtO06-1jkn4e3q8c-00uqYJ for <cygwin-patches@cygwin.com>; Thu, 23 Jan 2020 13:51:54 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 71091A80BA7; Thu, 23 Jan 2020 13:51:54 +0100 (CET)
Date: Thu, 23 Jan 2020 12:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding again.
Message-ID: <20200123125154.GD263143@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200122160755.867-1-takashi.yano@nifty.ne.jp> <20200123043007.1364-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <20200123043007.1364-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00090.txt


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 479

On Jan 23 13:30, Takashi Yano wrote:
> - After commit 6cc299f0e20e4b76f7dbab5ea8c296ffa4859b62, outputs of
>   cygwin programs which call both printf() and WriteConsole() are
>   frequently distorted. This patch reverts waiting function to dumb
>   Sleep().

I understand the need for this change, but isn't there any other
way to detect if the pseudo console being ready?  E. g., something
in the HPCON_INTERNAL struct or so?


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4pluoACgkQ9TYGna5E
T6CP0RAAlLHn3m4NCWcUqxPgI4/SzaRVrjb+nJ1ACDaBBd53Rxyw7jBiaBPUC8ih
285HDBSrk+K3sDV0Iagojhs01wzISOdc9hxHUSVfdhEP9SM8FkBu6OrHMQBOBoIb
013oAuuISiYy+Cn47To3dDV/h1jekkVVTcqmVRh0Jc0g044uYeUrG+rSAaIfxHfK
5DxOUKQw3le6ZzESF1o/4oNk0N8pLIa2cuZFcNAhcWIGSAO7ClAwOc/fHzEgZQA5
XDEDMzN0/zshpBL8rGkSybAGn+9ciyj4D27OIFhYdvWvVkD4+uJIhN0Z6i4N88Uq
KMkgBej3PiFv7U3YIbSMxq+8GF+F+kfNVdO9ETuDgNCZwpxiTr5jnieardPdQM2q
yR4zdMPJrhfXo8/zQa9j0ngIy1/YhMGKIoz63YgFvZXcZXMAqDdKE9TK6tpfH9OQ
1dydygEhKRJ4eSzgYIDlbwqc007svmst0Q53evx0Aq7yG9Tqrs8mZRp2Yd1ybDfW
uFu8PrpsuEZtFjMYbRai47Ngb155JT5jYqDvjO9Anig9/bSolvWS7Rm36CmUXySd
eQBNqlhgw0aWO9PR97C5aOtazDlFuFgjf/UBXateJslBFGIwXXMMo4iyVfOQ0NPJ
eLe0rUo0uxR1a7WWcLSSiZ0w61/xP7rDT3NJRXjyRnLM97SMIk4=
=miOJ
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
