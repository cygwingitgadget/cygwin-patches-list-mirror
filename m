Return-Path: <cygwin-patches-return-9474-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70360 invoked by alias); 27 Jun 2019 07:11:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 70352 invoked by uid 89); 27 Jun 2019 07:11:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:292, H*F:D*cygwin.com, honor
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 27 Jun 2019 07:11:00 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MD9Kj-1hpR7A3AP3-0097R9 for <cygwin-patches@cygwin.com>; Thu, 27 Jun 2019 09:10:57 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4DA5FA807A4; Thu, 27 Jun 2019 09:10:57 +0200 (CEST)
Date: Thu, 27 Jun 2019 07:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: honor the O_PATH flag when opening a FIFO
Message-ID: <20190627071057.GA5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190627011018.35924-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Lh1tzOZp3jg2TtWy"
Content-Disposition: inline
In-Reply-To: <20190627011018.35924-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00181.txt.bz2


--Lh1tzOZp3jg2TtWy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 234

On Jun 27 01:10, Ken Brown wrote:
> Previously fhandler_fifo::open would treat the FIFO as a reader and
> would block, waiting for a writer.

Yup, thanks for catching.  Please push.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Lh1tzOZp3jg2TtWy
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0UbAEACgkQ9TYGna5E
T6BU+w//XYJ+j17x0Nenpv0INPdpc/8AfSw7mR4C/LKDunE4d/Sdd3MBM30CRcb2
IUOTV6br47LrGX3tmjQLFVD7dyvnXI85Ol4W10YxJ/De9FD5+fMWdpf4Mj7Y/XqT
4mR0z6Qa3gjQoFz4r9MLugSXBeDUwwolke/WxzrKaJBMGv2myC5l9bXcSHmT8EiJ
cS0iK7bAFW0tuN8EC3et2FUlES7fp9rT5Kn+mNp5BwRhhVDMDZToxa4A9o6tkhBV
VzQtGigB/cuj6UptQbCMsBJ4RGpg9mtYg7Rg+FM2jcThKtlPDlvOKV+05fmj96MQ
AXn3UCqKfIEOGuq0d/XWFSSxVnaIxj7+r4ki/+US3oP3Z/KFoG2o0S8qO5KhBr1v
2tzC1UtGWoaxmJiPcs7A9oXviD8EBLCEvxoUS0b44jZnqMSWbDV6Vb7dpCMriBCR
qj452McLByjojcYK7TirDWGCpgdqXNtzjtqqaHC6qf+V+t6PEl2ynRcT29Kppa+C
lN+qbImw0OmLdbqgrPEbs5fpKNlVqMFzYbRRWhkAufwrWSVyzXaNeBp197/i1lw9
XALMvncRqYolrD7DRhlUFw4cx5z0sy0dM40bY8IX2qI0HYbMh1CTF53YxXKV+M0j
Eugi4rVO+Zp0XJy3bcTz6BLKrXCxxl1m4OR7jHL7kMmq+aO9Hh4=
=cGhd
-----END PGP SIGNATURE-----

--Lh1tzOZp3jg2TtWy--
