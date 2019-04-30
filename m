Return-Path: <cygwin-patches-return-9395-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35041 invoked by alias); 30 Apr 2019 16:07:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 34924 invoked by uid 89); 30 Apr 2019 16:07:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:780, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 30 Apr 2019 16:07:29 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MnJUy-1gwJPG2QgW-00jHDZ for <cygwin-patches@cygwin.com>; Tue, 30 Apr 2019 18:07:26 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CCAAEA8078C; Tue, 30 Apr 2019 18:07:25 +0200 (CEST)
Date: Tue, 30 Apr 2019 16:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: fork: Remember child not before success.
Message-ID: <20190430160725.GM3383@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190412175825.GD4248@calimero.vinschen.de> <20190430070750.20436-1-michael.haubenwallner@ssi-schaefer.com> <dab3c580-772a-d18b-ca77-e2b5f646fcae@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <dab3c580-772a-d18b-ca77-e2b5f646fcae@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00102.txt.bz2


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 722

Hi Michael,

On Apr 30 09:09, Michael Haubenwallner wrote:
> Do not remember the child before it was successfully initialized, or we
> would need more sophisticated cleanup on child initialization failure,
> like cleaning up the process table and suppressing SIGCHILD delivery
> with multiple threads ("waitproc") involved.
> ---
>  winsup/cygwin/fork.cc | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> [...]
> +  yield (); /* For child.remember (), to perform async thread startup. */

Is that really necessary?  What's that fixing and what effect does this
have on the performance of the already very slow fork()?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlzIcr0ACgkQ9TYGna5E
T6A0Qg/8DGbk29RehS0xkvefineTwCvOWv6GIVzHmv3am0bsAwZzObXPs2tZdwPL
KO86duPJTjh53EmYG5tXBbdoFSodMW8MNlAx73WNBpdGk8fnvhoF98V2GOsasfS4
Z16g+r6+xfTh6XJus85ZXTJOP49lHVc6nn0kddjCVGR6WmiUY7I89vLLzWEuAKmT
rmuYNTUKNjyOInfiXKKGE/laYJiGula6hzZ/iPxaoGNTJkctKAbwFO3nCuBNsF7t
o1MhzUGVaC0k7NdVlNb7nYsR+SNJ5t8X14dow68w2pQpGfgkswKX5/IvCZpl6S6p
9iNvmdCXEZpYjMcyOleUTr7sC6aZu+FLaP5mUb++rWdzOdEm0iezY1P+TIJ9aqmv
rwFVtW4rICXvho8Bvv3IP8uQhciejtWBTL2C8uL9br2It+R+oLlqqPC+gjRuBpTw
FuyiBVDLh9gZoB75ZGZ+YXvjslVPyCJ9tgpdWR5PsVzKCHRei85K4enQTXGkk/IL
wkqJVqFai3THBg2msk97F9JWdINAJL+fNYKpeB650hqc48b1HMJ170c8bDuPnRvG
1GXS/jC0VmlGn/Dnjj07xDXXz4LMm5Lvr5sjSz11HosbArqoUc5zW9TWy9g/Ndcu
+NGiP17noQO1UVfFkKTMSaHFBY1meV6RFXwcUD27/A5dB+uHWEM=
=SwPZ
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
