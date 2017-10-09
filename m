Return-Path: <cygwin-patches-return-8875-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 93329 invoked by alias); 9 Oct 2017 16:59:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 93300 invoked by uid 89); 9 Oct 2017 16:59:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:2051
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Oct 2017 16:59:39 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id DC42D70F8FC0D	for <cygwin-patches@cygwin.com>; Mon,  9 Oct 2017 18:59:35 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 2254E5E01D9	for <cygwin-patches@cygwin.com>; Mon,  9 Oct 2017 18:59:35 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 15935A80665; Mon,  9 Oct 2017 18:59:35 +0200 (CEST)
Date: Mon, 09 Oct 2017 16:59:00 -0000
From: Corinna Vinschen <corinna@vinschen.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] initialize variable for RtlLookupFunctionEntry
Message-ID: <20171009165935.GA30630@calimero.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <e7a6c229-229d-47a5-e645-fe8ea312deca@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <e7a6c229-229d-47a5-e645-fe8ea312deca@ssi-schaefer.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00005.txt.bz2


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2080

On Oct  9 18:15, Michael Haubenwallner wrote:
> Hi,
>=20
> for the records: The (random) situation leading to attached patch:
>=20
> Reproducibly encountered the binutils-nm process falling into an
> endless loop during some build process - but the reproducibility
> depended on the length and/or the number of elements in the PATH
> environment variable. Attaching with gdb shows endless wait for
> tls::stacklock in _sigbe. More debugging outlines that nm first
> received the expected SIGPIPE, but subsequently received SIGSEGV
> while in the RtlLookupFunctionEntry windows function, causing no
> signal handler to be finally executed, but returning to _sigbe.
>=20
> The command in question (with longer PATH environment variable) was:
> $ x86_64-pc-cygwin-nm -f posix -A /lib/libcygwin.a | sed 1q
> It was important to locate nm via PATH, not with /path/to/nm.
>=20
> Thanks!
> /haubi/

> >From b029e683e2a03879c3c1cee06bf6cd2af86b67d9 Mon Sep 17 00:00:00 2001
> From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
> Date: Mon, 9 Oct 2017 17:37:40 +0200
> Subject: [PATCH] cygwin: initialize variable for stack unwinding
>=20
> The third argument of RtlLookupFunctionEntry actually is documented as
> _Inout_opt_ for both x64 and ARM, although generic doc says _Out_ only.
>=20
> * exceptions.cc (__unwind_single_frame): Initialize hist variable.
> ---
>  winsup/cygwin/exceptions.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index 743c73200..a3ee5cf71 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -280,7 +280,7 @@ __unwind_single_frame (PCONTEXT ctx)
>  {
>    PRUNTIME_FUNCTION f;
>    ULONG64 imagebase;
> -  UNWIND_HISTORY_TABLE hist;
> +  UNWIND_HISTORY_TABLE hist =3D {0};
>    DWORD64 establisher;
>    PVOID hdl;
>=20=20
> --=20
> 2.14.2
>=20

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ26r2AAoJEPU2Bp2uRE+gUc8P/0Ko2bqF5DMJlyzWxBTqHRQm
CKYCZGXpZ0Pr7LMvnPXZkXv8c6s+EqOHbDS/N6gF8TQ5d2QmMakJd6BBqc+3bse/
mzKo3ogbiqspJFis58sLZWlshmqAyiTox9s4mILDa+phOpTTI8Od2Kwqgk7Objel
Sq+430IAnJeeD386hDh3aMw0A6/JSwOGKGQDMs8P1yQvTVCF9fR0uLX8hm1d6AVC
txDaLyr9hLSty+UkQ8fIkZ3Wt69x/SXHWmR4QR6COMkXpVygyIYuyyIyA9hKqCNE
fVTJ2Nq4K7ajn986GH+g9k4oJ9GwON1/diieuorwYgkt7GPE+VrTUCJPtg+wYItN
Ocwq4eGRTbOmEYn9TH5QpWQSNkVf72ulLR2OPKrLuINDcfki+8+gn3HDrOl8mV0i
1wX5WaivZozmGDKFbWTNe1cEF4Ljrw1VX2IGGIa9Ra0yuW85eyOqjBqtnwG3mUh2
AF2PB4rLjF7/hJlJIZIoLtff6eroChKhQETdQUuSzZUzjPjaqoIUQfeWGBZZbmYg
OfYLmRO2Go7DbP5DQD7b70Gm9Vj9ud2aOzNIQ0+4xvogP0FgoNjUEE4oxO/nBJdV
MI9MD7U62AD5trOjeJmB/XWqU3MZGNpKFRxfBj/N86AF77zQKP+jo5DYBbkXkRsq
rr+VIs8xWd9S90jp/OOG
=9Eph
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
