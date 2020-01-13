Return-Path: <cygwin-patches-return-9919-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124434 invoked by alias); 13 Jan 2020 16:33:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124394 invoked by uid 89); 13 Jan 2020 16:33:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-111.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Speed
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 16:33:20 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N2SXX-1jo7Wc1hx1-013rfA for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 17:33:17 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DCFBCA805B9; Mon, 13 Jan 2020 17:33:16 +0100 (CET)
Date: Mon, 13 Jan 2020 16:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: select: Speed up select() call for pty, pipe and fifo.
Message-ID: <20200113163316.GQ5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200106143834.1994-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="XlS4q8O07AKt4+K1"
Content-Disposition: inline
In-Reply-To: <20200106143834.1994-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00025.txt


--XlS4q8O07AKt4+K1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 718

On Jan  6 23:38, Takashi Yano wrote:
> - The slowing down issue of X11 forwarding using ssh -Y, reported
>   in https://www.cygwin.com/ml/cygwin/2019-12/msg00295.html,
>   is due to the change of select() code for pty in the commit
>   915fcd0ae8d83546ce135131cd25bf6795d97966. cygthread::detach()
>   takes at most about 10msec because Sleep() is used in the thread.
>   For this issue, this patch uses cygwait() instead of Sleep() and
>   introduces an event to abort the wait. For not only pty, but pipe
>   and fifo also have the same problem potentially, so this patch
>   applies same strategy to them as well.

Pushed.  And thanks for testing, Marco!


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--XlS4q8O07AKt4+K1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4cm8wACgkQ9TYGna5E
T6BMlg//SN9bE0Q4TE9LqChx9o2NOMOvxX622jJiNhZCx60H3sc6l5W7PKP0pzYG
w0cflT1O+PXewssxPz2OWQhZ6gYwIK2QBwtuA8ltP9k6fYRPpi4P2hOMND4Yq1Me
RyVKDBFZhEFzEZo84UkuZSrMZDfiuyzrQEGeuq4QFSM9hr4E3gXJPsOW7PqYThWm
GanHXA5tYQn+IzfdTxj9h0qSEiZFkorIdVfhA4ZNRlDNvSG6LpGc6KvpUlVEnDmV
Uj47ccTOLRTjRWYD7CX+b8AEg4htArXks4H9hjsq9LbeEHZeaF2Vd8hrIw1DuFmk
9ZbsuWBCItp+QJqHN5Ryz6WFUxonTmf2qUozWkEvR3CAby3Z3VYuOFp/svobCHUM
pI2P4rbMQhNAdW6rL3Ii25t/3g3OrCFxmVN4z9ThbcaK8mD2L+JNHSXrx0RrrBKi
HM3wkorEOZWLvR7rXu27rt47SQrhokBukg/1j9D2Oc0Y4MNwx2ECYQz6uEpoMqLS
/3LX+TDimm6gZ/VI3oGJf6QNURXM5I9c4nf062Dc/jgv+t1vcFCkAZXRWuS9Jp0S
1jAERHU9HvNDm4EThelGdpehua8/uAfNQqXq1xCLslJHj9TDToQSRejYG2UhCovJ
wfSU4NDA6ngnc+PnBbo55lPYdi02YfxdSapfB/wuZJ1SRNvi9HE=
=fluz
-----END PGP SIGNATURE-----

--XlS4q8O07AKt4+K1--
