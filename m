Return-Path: <cygwin-patches-return-8437-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79211 invoked by alias); 20 Mar 2016 11:28:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79190 invoked by uid 89); 20 Mar 2016 11:28:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:1008, H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Mar 2016 11:28:39 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1B074A805AC; Sun, 20 Mar 2016 12:28:37 +0100 (CET)
Date: Sun, 20 Mar 2016 11:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 09/11] Add c++14 sized deallocation operator
Message-ID: <20160320112837.GO25241@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-9-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="enLffk0M6cffIOOh"
Content-Disposition: inline
In-Reply-To: <1458409557-13156-9-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00143.txt.bz2


--enLffk0M6cffIOOh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1020

On Mar 19 13:45, Peter Foley wrote:
> When compiling with -std=3Dc++14 (the default for gcc 6.0+), the sized
> deallocation operator must be defined to prevent undefined symbols when
> linking.
>=20
> winsup/cygwin/ChangeLog:
> cxx.cc (operator delete(void *p, size_t)): Define.
>=20
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> ---
>  winsup/cygwin/cxx.cc | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/winsup/cygwin/cxx.cc b/winsup/cygwin/cxx.cc
> index 0faeaf7..df7491b 100644
> --- a/winsup/cygwin/cxx.cc
> +++ b/winsup/cygwin/cxx.cc
> @@ -29,6 +29,11 @@ operator delete (void *p)
>  {
>    free (p);
>  }
> +void
> +operator delete (void *p, size_t)
> +{
> +  ::operator delete(p);
> +}
>=20=20
>  void *
>  operator new[] (std::size_t s)
> --=20
> 2.7.4

This looks incomplete to me.  Don't we have to export the symbol?


Thanks,
Corinna


--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--enLffk0M6cffIOOh
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7olkAAoJEPU2Bp2uRE+gLzkQAKUUCTgc5RmXOCOUF4WSjlmi
sPCk8hKwR1vfEmCJZuV/chFliDwbtngOAWFEYYkwEpEXMR3Hw2D2nP8/7KiRXn1A
gWMPHLGOEYxfsq8FiDgNUxLrCsoCLAOcf8Alz+Qoq1SIwx5e+6v8t3TDpc7stmaf
HOYWXntvEZ2xsZuJf4J1P8UOzrv3R+eB7XoQ/i71hxj8qJ0t6GtrUcSknqH5bqtn
h5vthy7YvN0zZTp06TJtjBwFGBvzd82laGXNm8I+7bkYyibEP58WvDeVMJqS8mgA
barC9avcAWytEEoJ/hbyNeYwdwqXCq/x1QMTXSNsSXK+vI5z/tpbsMpHhyt5x5Xd
r7Lu4j0EyjE4OIjAorkPWs7lXYDFCYIN1BFALBT2AzNy+hR+wtCE2ohmabCHlFYd
qPRiiD8vwhJOyr4NqDqgvL91teMfzGlrR7Nsry8lGZiCx9G2lPQHHWGEzhrdUBpM
6+Pucl7Vaewd83bUZR3SVuRJqNMEHdoi53R2mU1ZhZ5STItUletcdDV6PApAWbjh
7m+uEeJ318Aqaar8PzZ45LXLCtCHenqNKOwuIzk+qiadKnxXZJfEizmgIhSkO6TK
8EzW5/x2bDMKftIX6Ptp1zPFRNMYfgVq7jwCdrKYcFcE8dpqmYQNl25uWp+50jeq
eyhZ49OP0/nS21BfNpu9
=epps
-----END PGP SIGNATURE-----

--enLffk0M6cffIOOh--
