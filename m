Return-Path: <cygwin-patches-return-9971-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67267 invoked by alias); 22 Jan 2020 10:06:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67257 invoked by uid 89); 22 Jan 2020 10:06:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-108.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, para
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 22 Jan 2020 10:06:54 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mr9Jw-1jQnpC0vzC-00oHxL for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2020 11:06:52 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3A60FA80B77; Wed, 22 Jan 2020 11:06:51 +0100 (CET)
Date: Wed, 22 Jan 2020 10:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Introduce disable_pcon in environment CYGWIN.
Message-ID: <20200122100651.GT20672@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200121222329.69f71c847e97da78955735a7@nifty.ne.jp> <20200121132513.3654-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Content-Disposition: inline
In-Reply-To: <20200121132513.3654-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00077.txt


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 340

On Jan 21 22:25, Takashi Yano wrote:
> - For programs which does not work properly with pseudo console,
>   disable_pcon in environment CYGWIN is introduced. If disable_pcon
>   is set, pseudo console support is disabled.

Pushed.  I just fixed a missing </para> in the doc text.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4oHrsACgkQ9TYGna5E
T6BGtQ//QRUEKZPkl1p0Qk0AT3nhwgnjXdjlquvuiZbpoq4DISc7ToSJ4nvHLqcf
qfcFl3v4TIdb2KJKL6Mc1lb3QO+KpJEwobkuLekwwHZXHr3cV+psIxfDXPZ8blVA
5ogln4HwFpc4rZn2GNxiuacuqTIAGH0Cmyczgc6buSy83uDpfWdiBaEDdex8k2yt
s5693cBzIkPDDnOONF2/9Hp+EPikHSz5RHYDjMnhVsKordYMOwOl0rTpOtb4lUvS
lAKZ4yzNCH6wNseuEmKhFwPKaoEvz6lzWq9piXRB+MXjZ4st6vAwPtl3eiqufq3B
+96yv8UgRKfaZHcic3If3skITkNZy49x73lxSWvDopanZwxjvGbVoMxHEdVR6Xt3
tcQZoNq++biUfuNCOkkpx1o5MLfBYmIrbaO9njRI9grc6FBPvJzDRTQAPpCnU8BQ
5JfMON1BxOe98iOqDZbdBhgXtLElTKMCgzuSin1g1yp/bjjWQMFLZBJbLYgO6RSx
68BHrjEliFaEv/USTYrUr1fqMddTLdocLSV1RMizuyL3c9rx8vOMLL3lggr6X7gR
vhxRHK9A2rr3nKd7qWRXNjp4tzO6PkX01ZNrnpGt+O968L5nycpVMTfKn3LeoFVE
iocZYu8XMYZhRkFO1IXNs5pNqLcNasR72HFCt0rddmUjFMyUhJ4=
=2rpv
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
