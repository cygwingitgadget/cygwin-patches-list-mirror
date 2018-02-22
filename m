Return-Path: <cygwin-patches-return-9034-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38097 invoked by alias); 22 Feb 2018 13:18:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 37742 invoked by uid 89); 22 Feb 2018 13:18:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Been, MTA, mta, mua
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 22 Feb 2018 13:18:03 +0000
Received: from perth.hirmke.de (aquarius.franken.de [193.175.24.89])	by mail-n.franken.de (Postfix) with ESMTP id ED33A721E280D	for <cygwin-patches@cygwin.com>; Thu, 22 Feb 2018 14:18:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perth.hirmke.de (Postfix) with ESMTP id D0F3D862108	for <cygwin-patches@cygwin.com>; Thu, 22 Feb 2018 14:18:00 +0100 (CET)
X-Spam-Score: -2.9
Received: from perth.hirmke.de ([127.0.0.1])	by localhost (perth.hirmke.de [127.0.0.1]) (amavisd-new, port 10024)	with LMTP id 8vwgiMQReTae for <cygwin-patches@cygwin.com>;	Thu, 22 Feb 2018 14:18:00 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by perth.hirmke.de (Postfix) with ESMTP id 713DB860EDA	for <cygwin-patches@cygwin.com>; Thu, 22 Feb 2018 14:18:00 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 62660A806E3; Thu, 22 Feb 2018 14:18:00 +0100 (CET)
Date: Thu, 22 Feb 2018 13:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] doc/ntsec.xml: Fix typo
Message-ID: <20180222131800.GB10740@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <f1047ae4-4edf-6343-2929-c193e6cee77c@gmail.com> <20180221210534.GA7576@calimero.vinschen.de> <9501f8b9-f84a-ea43-93da-c0eeb8ca9d35@SystematicSw.ab.ca> <20180221213714.GB7576@calimero.vinschen.de> <1403214d-ca26-02ad-5d59-eea94b7039bb@gmail.com> <Pine.BSF.4.63.1802220257200.76751@m0.truegem.net> <b84a4d06-ab31-8f65-5497-3ef9990802ce@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <b84a4d06-ab31-8f65-5497-3ef9990802ce@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q1/txt/msg00042.txt.bz2


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 949

On Feb 22 13:36, David Macek wrote:
> On 22. 2. 2018 12:04, Mark Geisert wrote:
> > Been there, done that, even the "I'll have to try something else".=C2=
=A0 It's astounding how SeaMonkey, Pine, and probably gmane bork up the for=
matting of something that looks so benignly laid out to begin with.
> >=20
> > After much experience putting up with these and other MUAs from us, Cor=
inna really does know *the* solution that just works.=C2=A0 'git format-pat=
ch' followed by ''.
>=20
> Then I'll have to finally try `git send-email`.  Any important tips?

Only that you need a local MTA or direct access to a remote MTA for that.
Alternativaly, if you can skip the random decoding of spaces to =3D20 or
*attach* the result of `git format-patch' to a mail, that should work
with any MUA.


Corinna=20

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlqOwwgACgkQ9TYGna5E
T6BFcw/+MdmrbSWVQQHe3Wv87uDGk6XFf1so07MuBt2p5bfe6x8o1HvpDoKQ8O24
gL9f5zDNIbWPsGt9ZfgFbvJaL8oTSE39larHeyhth6IIfC/k1nKykr9t5ktawrwv
bQ2t8tWwTaQdIjjZeFVSzWXGtxJiDvpHjJYDGKttUvtfpIT6at4xx33tBZTLDVXT
dWUKYXV98R6ng+ZPqiCyFzwbDeyfQGym2+92N6zOV0UWfsnfnrFa/OeTUOWImyq1
xKQjgQYlpIrVhcH4X9tOb/pipDpsxj7b7G/AZ4KTcckTcubOCYTl1b/eJ9oXxGE1
huBVap76sv1O9bxY92SXEw2j89JkILqsaZXRZ9ZoqVqZJXK9n5zhcjUtKJJiqwXM
OaEk/O6E8qlnPH9Jc1SO1A2ALtw5Nf0/6whOAPTTvZzRLGfTxWSp6edhi9CiUeak
uirQ4dnFnlAMDSYuPSJktv5SSaPySIcZ7ZPrhdzL+B6Do6zhHHpC/WcNlD4e4Zk/
Yznarc6I/FXuPijyyQxr/Z2Tz9UKoCzf9Rzb1eikZ65UBDzCp4dLqnh3FWW/ZDx2
nnKJ0nde325XfSrb6lH/8CudFBjR4pNhnKLM6RjfP7M+vlB+chrf7X30TSlmCwxP
XEDINev9uN7sJ6lZscNTYJqrcgljepXgZXuipWK1xhfwNR/3Iu0=
=cC5x
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
