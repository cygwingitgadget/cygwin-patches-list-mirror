Return-Path: <cygwin-patches-return-9333-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6824 invoked by alias); 12 Apr 2019 18:03:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6813 invoked by uid 89); 12 Apr 2019 18:03:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:273, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 12 Apr 2019 18:03:05 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mnqfc-1gVFJE3jju-00pNbo for <cygwin-patches@cygwin.com>; Fri, 12 Apr 2019 20:03:02 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 85C89A806BD; Fri, 12 Apr 2019 20:03:02 +0200 (CEST)
Date: Fri, 12 Apr 2019 18:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [rebase PATCH] Introduce --no-rebase flag
Message-ID: <20190412180302.GF4248@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <990610f4-8ba8-92a1-0ece-5b22c275945a@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="YolNsh7G+K7zsfIR"
Content-Disposition: inline
In-Reply-To: <990610f4-8ba8-92a1-0ece-5b22c275945a@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00040.txt.bz2


--YolNsh7G+K7zsfIR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 230

On Apr 12 15:52, Michael Haubenwallner wrote:
> The --no-rebase flag is to update the database for new files, without

Wouldn't something like --merge-files be more descriptive?


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--YolNsh7G+K7zsfIR
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyw0tYACgkQ9TYGna5E
T6B+oA//Yf4uXkP+tsz0IY8k3O/H0/NSUxDgNgL+ZQHa9cFnCkl++g2jn9D1FgBu
0/GKtyiWmW+dEfxiDTRkaBE0Zc5rZ92guPDe6cDRSfsjS/jk+uA7htB1sJUaJsqk
7Dsx4Sitf43eNbfgCnVhMmPnqbOqOD7/RxNKIP+L7+60U3YFfKUqmHubADujiSMW
HoshtU3QmrjquTqNNQxDe0rne0i5Zf2+t2Q5xTIY2hWetKeThnzCtFlh+jPkJtkR
BRyLmfLtAXn3MxgETaSnSkeNqXqzuNKpB95kGcdIoezzCjFWnh/FWMNbhSTvQsfh
b2sRc0vTIM/VLsogOrsADWabyFxSutyqE5rr9JGUOPPzyqJrX/RaKeRPr/3vezQs
K789VwcKti4VAAKlsD5nxoVJNtxesxd3G9G8bDHCjhzqMIH1/u9Ie8TTBjD1ezMj
g8Oa7KfGQVPMWfaccTfYqEBIE50YGdHqGbrzoMxV/l+MjoxyHSz+KrG8RD2uWCg+
2VrL5e0PgWeLGSpxAvcOMmk4odxmteDPWXTXTnD30gUBs/VouDniy7MVLsM3qBts
OoWmHIAYtuDaIJx/oFcvCPrn5tM110tAczkCz9E9tu/N/15L7mGKzI0pguClO0vg
gwF0dcGEcFzdt3OPsUUGg1BfO9GViF4+Hq/sKSupU2udsz7N8j0=
=Chx0
-----END PGP SIGNATURE-----

--YolNsh7G+K7zsfIR--
