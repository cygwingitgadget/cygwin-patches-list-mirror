Return-Path: <cygwin-patches-return-9425-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107232 invoked by alias); 3 Jun 2019 16:47:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107223 invoked by uid 89); 3 Jun 2019 16:47:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-102.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:588, cancel, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 03 Jun 2019 16:47:01 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MTiDV-1h8Dap0thd-00U6F1; Mon, 03 Jun 2019 18:46:58 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 95348A80653; Mon,  3 Jun 2019 18:46:57 +0200 (CEST)
Date: Mon, 03 Jun 2019 16:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: fork: Always pause child after fixups.
Message-ID: <20190603164657.GN3437@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>,	cygwin-patches@cygwin.com
References: <20190412175825.GD4248@calimero.vinschen.de> <dfd73eac-c2ad-8d5a-557f-23dbff3db67a@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="dzI2QqkSBOAresgT"
Content-Disposition: inline
In-Reply-To: <dfd73eac-c2ad-8d5a-557f-23dbff3db67a@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00132.txt.bz2


--dzI2QqkSBOAresgT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 531

On Apr 30 09:09, Michael Haubenwallner wrote:
> Pause the child process after performing fork fixups even if there were
> no dynamically loaded dlls with extra data/bss transfers to wait for.
> This allows the parent process to cancel the current fork call even if
> the child process was successfully initialized already.
>=20
> This is a preparation for when the parent does remember the child no
> earlier than after successful child initialization.

Patchset pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--dzI2QqkSBOAresgT
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlz1TwEACgkQ9TYGna5E
T6BihRAAgRToKaF2cTWcpOcgq0m7p8W7w3ik/GCij4hqxUVFvAzkLiWgvFlumgwU
PE2WLbZj/gPhqHebrmxZRO48iZoyOnLLPiO4R2rWs6FFyd77XEY6k9Obh8uws7mL
5srSpNqIu62W/nLW45gDg7CLjPwz4nhFhIXLi/Fk2DrzUR1KRcfOF8pAXkBjUUET
AMCbx4XWt/kt+srapqZPGv0kTUz9g5oR9YYHQvouyjA6WmxYZxlvPGCNpTbRpNbU
DDdvqALSG+Pr0h9cqkAcgcbPDUGU6hfEfxTIg5bKTcWHo4MizVyQ2NP8E2WabvoS
FiDZ2YqQpcu4KQ6tyl1UM+NwlAmZAb23N6zLDgdfvESmndqcx5Zv6FcR0fQ/7jIh
BKJ3nTgxgKgn2wONnGiAfORnpPmqVyf163NbwPYjr806ncntXHxUFabosEasdh5e
VQ+4mSou+XWRDssjFrxJ0548MjzMlLqL3HNp0xH2qYiPFBf2qj9ej6oiLZ1N1WRO
0cOFARnTne5UrkHRdZ9ROurO2nqDYb5ip6qGgXn1shoYt0Xql5d8H3oXYvXQFqSW
R+TXRWncD258gg33B5ISjm7jJn+U3THLT9oKtUGYctUxv2zY5O51x+bvgOkhZUx8
Si8cSdmslFfMPjzHs1vfE70vI3ue0gboe5kmKjGKKkb1TgmcUvY=
=s6MB
-----END PGP SIGNATURE-----

--dzI2QqkSBOAresgT--
