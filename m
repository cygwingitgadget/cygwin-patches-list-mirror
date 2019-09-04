Return-Path: <cygwin-patches-return-9610-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68710 invoked by alias); 4 Sep 2019 10:42:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68699 invoked by uid 89); 4 Sep 2019 10:42:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 10:42:27 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MI4gb-1hz9Ue22Pn-00FBsm for <cygwin-patches@cygwin.com>; Wed, 04 Sep 2019 12:42:23 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C56B8A80659; Wed,  4 Sep 2019 12:42:22 +0200 (CEST)
Date: Wed, 04 Sep 2019 10:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: pty: Add a workaround for ^C handling.
Message-ID: <20190904104222.GO4164@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp> <20190904014618.1372-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="S66JdqtemGhvbcZP"
Content-Disposition: inline
In-Reply-To: <20190904014618.1372-2-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00130.txt.bz2


--S66JdqtemGhvbcZP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 515

On Sep  4 10:46, Takashi Yano wrote:
> - Pseudo console support introduced by commit
>   169d65a5774acc76ce3f3feeedcbae7405aa9b57 sometimes cause random
>   crash or freeze by pressing ^C while cygwin and non-cygwin
>   processes are executed simultaneously in the same pty. This
>   patch is a workaround for this issue.

If this workaround works, what about making it the standard behaviour,
rather than pseudo-console only?  Would there be a downside?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--S66JdqtemGhvbcZP
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1vlQ4ACgkQ9TYGna5E
T6DCjw//epdrr6I25VFOUQFsfMP4YRIIoBUkINObWo22BZ2iJ8BVB5lFr0sbOVif
opeGttUKDKtJjrPRvnT5tuhxKrcS2Rm26Rex5ONmYt/UO4G8D0+VH85pAmWRdP5f
46QBWNAQaI4znFUIuuBGtKCGBKzk+GU8hC0v6uJjnOLqE1aeLxxx+HtFTVr06YLv
f/hGYt6R7WtiHcAHgUwDo1EYF3yJS6Cq9qjdM4xuKUV1JfBg9QzPkAi9y/2sjF7H
6YKuXiIw6+bNt+yO3dN9kld+jscIiDR8Zfd/SXRVvgcgdJU+J25Qac/mnitA6ZB6
oDvDbjKuO3rUYzQ1rxJtuDBJbVCuPJDduL4i89zQVFUcJcPnlXz+po3P/LiKS0Gx
jwD17zS9UWGxSorQfGE0lRm+dfcHq7ZzFRbXrcTk2O5CKAFUBu9f1VMRyqv5OUAM
AAkeOZT9teT7etQYBnrhVVQC2IGjmeYv6TVlDFvGRx9/lfpTN4x3MbOcnNX0ADnf
rWvOm+Bb8oaYPK82OPqStJ+F4N6sEcCBlVjsbSvxli/iS0NA7x2hq2PEN1+cPokr
GSZiQdBdrhv8N7tc1M5f8Tp9mXFoec8WkMRV0nEFZiyf0Rw7jZtwRR3zjp3v1G3A
vEr7al+y7TT22xcQ0sASpDh7TlCC3Sh0DdUbVyIpk0vtwn/0hro=
=DiJV
-----END PGP SIGNATURE-----

--S66JdqtemGhvbcZP--
