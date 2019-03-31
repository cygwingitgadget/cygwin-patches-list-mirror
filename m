Return-Path: <cygwin-patches-return-9286-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87232 invoked by alias); 31 Mar 2019 14:36:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86766 invoked by uid 89); 31 Mar 2019 14:36:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:368, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 31 Mar 2019 14:36:36 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MdeKd-1gbXw71KDJ-00Zik8; Sun, 31 Mar 2019 16:36:30 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E5F2EA8059A; Sun, 31 Mar 2019 16:36:28 +0200 (CEST)
Date: Sun, 31 Mar 2019 14:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/3] Reworks for console code
Message-ID: <20190331143628.GE3337@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,	cygwin-patches@cygwin.com
References: <20190331094731.GC3337@calimero.vinschen.de> <20190331134718.1407-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <20190331134718.1407-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00096.txt.bz2


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 331

Hi Takashi,

On Mar 31 22:47, Takashi Yano wrote:
> Hi Corinna,
>=20
> I have revised the patches according to your advice.
> Could you please have a look?

Thanks for sending this in git `send-email' style :)))

I have a few comments on patch 1 only.  Please see there.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyg0GwACgkQ9TYGna5E
T6CRNQ//fOnnzVNKZrlyaE2URmvFgb7U+tWdnE/jGwAG9vigGrKk5vrW6U0hC7VE
8dA3IWkOwcVq1VLTY4iTjGOIP5LhIRj3L6UC13q3T/sDQ3Fe3IKvmD/g8Vk9JVQL
ZuYRFSZvBMcuxf35rfI0KPWRw0gAf0mYCE4LEI+qvMm326Paje2AfUhFgQ5JRysf
0sBZFKGBJ9MvDnrS178VURp0N1PfrJeiuB/+uNm1xKgFTPJRUZXT/5nSLF9B8RhN
pT4XROsqkquj07rwElCQX7iQHr1W9FTnTkwDmF/a9dru03sqLSh81HoT8ce2MuYO
i/UmZ5rogC0NIF7eqKK7oETzYb46+ou+efcQIKAWD6yIEJlOOcfIuWB1S3aHQq+l
cdsZVTlzKSI5t867yutir4aIAQ+WNyfAOiMbP4X7go+SxN3KZLNG9rSV2gB9gzDK
wfzYe7rV0sn6ZkvG/Ftipq4BegNegBmQXrsod68sLX6/QBgVfAzzP7Jqz8UWJ5JF
3USRhhA75N+9wdcw39qkemPjiDpThMOdzmaR061vz4kEXIzGmyhE1x0x1zf0EmYT
ll1j0ID3pjJcqZpWJpH0tSTMr19Lry3pUqJbiKxegVqi1+tvXq1Tg0DUWDeq+W0T
0Luci/czN3yopyOI1Phmz8w1pFKemBs8qHliP1tU1JxVNos7oUg=
=+gVq
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
