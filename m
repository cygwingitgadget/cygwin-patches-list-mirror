Return-Path: <cygwin-patches-return-9556-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100167 invoked by alias); 8 Aug 2019 16:27:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100149 invoked by uid 89); 8 Aug 2019 16:27:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.1 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:803, PS, P.S, UD:P.S
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 08 Aug 2019 16:27:12 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MGyl3-1i9q153XFb-00E5h2; Thu, 08 Aug 2019 18:27:04 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EE39CA80718; Thu,  8 Aug 2019 18:27:03 +0200 (CEST)
Date: Thu, 08 Aug 2019 16:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,	Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: Re: [PATCH] Cygwin: shmat: use mmap allocator strategy on 64 bit
Message-ID: <20190808162703.GP11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,	Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
References: <20190808085527.29002-1-corinna-cygwin@cygwin.com> <b5b5bbaf-2bbe-b500-5c4b-9afca3eaf093@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="xwCJTF497Cudft2o"
Content-Disposition: inline
In-Reply-To: <b5b5bbaf-2bbe-b500-5c4b-9afca3eaf093@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00076.txt.bz2


--xwCJTF497Cudft2o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 761

On Aug  8 16:06, Ken Brown wrote:
> On 8/8/2019 4:55 AM, corinna-cygwin@cygwin.com wrote:
> > From: Corinna Vinschen <corinna-cygwin@cygwin.com>
> >=20
> > This avoids collisions of shmat maps with Windows own datastructures
> > when allocating top-down.
> >=20
> > This patch moves the mmap_allocator class definition into its
> > own files and just uses it from mmap and shmat.
>=20
> This makes sense to me, and it fixes the hexchat fork problem.  Thanks!
>=20
> Ken

Thanks, Ken & Michael!

> P.S. I got a whitespace warning from git when I applied the patch.  There=
's a=20
> blank line at the end of mmap_alloc.cc.

Thanks, I dropped the empty line and fixed an unintended reordering in
mmap_alloc.cc.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--xwCJTF497Cudft2o
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1MTVcACgkQ9TYGna5E
T6C2hg//WkLdwqneAIMi0GMvFkzmj0H04nGdXXu13iq8la+TA+1DH9CxzQxhjeRM
qU1mhMx02TXonmTteKOWWKrAXz1JFIJPW+akXGxBmULCd0Sdxm6pcqwYlr9ho7mU
XUpSbWKJNIAtUkSdCy0BvIOTw45Oi+l5dV12KMvUviIg6uRyjwsfn8GdVuWx+Flt
iNnYE+mdC9FhVRph8tInl9qIgq6pOHlRrQcDLxs53Rxtk8RLjjTGCaZox0xtSt03
L/lKp8lwAg893N5YvosevwUl+deT3BqgHMwxeWQnbSmeRkiH1Wb4Zaq+Cr9jilbP
PTQydpervhxbSHvK/pis7FK+AW/XY2kWnIRAPWzoTIZztj7VLyV4hPe8/NVDbTFh
1P+57se4f+yuFvfzptQQ6Z2PN/QKKTK/tiQvZdpCT2YwDxk7NvoeptpyE6LbktAw
6GRfIjN454rusoRGnkXNRS9o4wxHTNCpSjj4bP3BwBlFQdt8Eek6on3UkX9nZaUJ
aMncNDnoutlqZ36FbRddsJAP9KnAisSONW4vIDnVNz4z9zp9/lnTPUVWa3gFBVFY
Bs2FIRI6yj077FdbTtNHBESSUs2MSSRkhAqoiKDBz57zj1OO/UEyIf8ZGYSOwQbc
vfJJY5fHW31xGoGiXnz4Y7MWXoEt5I37+naRH+CNsM+ZgqngvHg=
=e+y+
-----END PGP SIGNATURE-----

--xwCJTF497Cudft2o--
