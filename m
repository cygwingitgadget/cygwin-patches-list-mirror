Return-Path: <cygwin-patches-return-8449-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22386 invoked by alias); 21 Mar 2016 17:13:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22329 invoked by uid 89); 21 Mar 2016 17:13:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.1 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,URI_NOVOWEL autolearn=ham version=3.3.2 spammy=outlines, claims, H*R:D*cygwin.com, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 17:13:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 559A7A803F7; Mon, 21 Mar 2016 18:13:14 +0100 (CET)
Date: Mon, 21 Mar 2016 17:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 09/11] Add c++14 sized deallocation operator
Message-ID: <20160321171314.GA14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-9-git-send-email-pefoley2@pefoley.com> <20160320112837.GO25241@calimero.vinschen.de> <CAOFdcFPP79BaO=KTpF5oB3ewdYCh6GmfaxoJr03kKY7dSOjrKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <CAOFdcFPP79BaO=KTpF5oB3ewdYCh6GmfaxoJr03kKY7dSOjrKw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00155.txt.bz2


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1345

On Mar 21 12:35, Peter Foley wrote:
> On Sun, Mar 20, 2016 at 7:28 AM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > This looks incomplete to me.  Don't we have to export the symbol?
>=20
> I don't believe so.
> As I understand it, if you're overriding the standard c++ delete
> implementation, starting with c++14, you also need to provide an
> implementation of the sized deallocation operator, which is designed
> to increase performance of deallocation if the size of the object to
> be deallocated is known.
> See http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2013/n3663.html
> However, the sized deallocation operator can simply be defined as an
> call to the original delete operator, which simply preserves the
> current behavior.

But we export these functions as fallback functions to the applications.
See libstdcxx_wrapper.cc and the end of cxx.cc.  While the comment in
cxx.cc claims that this should "not be used in practice", there might be
c++14 code ending up with undefined references to the new delete
operator, isn't it?

https://cygwin.com/ml/cygwin-patches/2009-q3/msg00010.html outlines
why these exports were necessary in the first place.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8CuqAAoJEPU2Bp2uRE+g+9EP/1lSDXXPp1tdpqKRc2D1zxJu
Q6RZPqAZ9A1XY5TVNx/Dub6gSylRND7IBBWpTfD/iS902vQD1QXG+touiV+tsOWI
XS3z9CIeMRyI+hEj48P133wkvS2M7pR7qIn9qnDDyW43o4vNyGBUsrhusXnsf1Gh
oh2h0U3xbKC4lweMO9n3VLHiNj8lSwisDy7tjj/6wAKkzvZnrgoONMXhwSKui5r0
G/W2qctn4iA1K8rT9TpALyucn1VP0jm35SSKihbfw8HMuIBLWqzcUGW+w0mH0tlQ
ZBQnVFib0Wlfhd6/N68dkI5zw/SVrpYlocTDMQoDBhKeAU9qj6XnmApSh468Kwi6
3ydqAeig9qwreeJY920ZlNWlUFOv11PCWL7iHYeB++Fu+gNOB3juN5oj/8v1Y4cH
3yGsXIn1BlKBAsfT3tDSj1V5Ia+/GtysIRBArvyfgk1O9CuK03uxU1VtEyanTXEc
xOkHbCfTUzVVdBsW3C+u1uL7uJ8b508LPsz7ZOjSi51QE63FuHg3I/QPYTKduEqG
gy7ihbZLkHmptBdxckZ4rU412S2ewsqwQn6oWc9zuYhfAAwbjCpDVeC/GBP7IPZX
RpPw16b19TytDntclh5doLiO8s3vMItQSsNWIBJFxM5dfdKV9+duthBykCYQx2LK
i7yGXzyOlsypeylshCqr
=rzt4
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
