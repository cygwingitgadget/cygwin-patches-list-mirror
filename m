Return-Path: <cygwin-patches-return-7928-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9364 invoked by alias); 7 Jan 2014 15:06:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9353 invoked by uid 89); 7 Jan 2014 15:06:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.3 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Jan 2014 15:06:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 737631A0C27; Tue,  7 Jan 2014 16:06:07 +0100 (CET)
Date: Tue, 07 Jan 2014 15:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix some debug string format specifiers.
Message-ID: <20140107150607.GG2440@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAOYw7dvX5CUc_zKyy4R8CxEe2=3fqCFUCpAnAvHZOzRU5o9Bdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <CAOYw7dvX5CUc_zKyy4R8CxEe2=3fqCFUCpAnAvHZOzRU5o9Bdg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2014-q1/txt/msg00001.txt.bz2


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 829

On Dec 22 00:39, Ray Donnelly wrote:
> I hope patches generated with git are OK?

In theory, yes, but please attach them inline to the mail, otherwise
they won't show up in the reply with some mailers, so it's a hassle
to discuss them.

As for this patch, did you actually test it?

-	len =3D sprintf(dbuf, "[mcleanup1] kcount 0x%x ssiz %d\n",
+	len =3D sprintf(dbuf, "[mcleanup1] kcount 0x%p ssiz %zd\n",

%p implies printing the 0x prefix, so this results in twice the prefix.

-                       "[mcleanup2] frompc 0x%x selfpc 0x%x count %d\n" ,
+                       "[mcleanup2] frompc 0x%zd selfpc 0x%zd count %zd\n"=
 ,

0x prefix and 'd' format specifier?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJSzBffAAoJEPU2Bp2uRE+gv14QAJR1JTQUIQV+8/MT/zb6wGiK
ed3cWOl9/MWtaN7mNHoBOeNUmXiQfpFX0VWQWe8aJudVKe2N71DX8TRH1VCDXxKn
N6xrpfpJa9PSvaByTBryivRHZbawQLLnkLVYIo02g1DBgQQC0lAXM6DWfQsX7bCY
Ru1ufWatRCEDclY2sKvzvfvwTNomaYimeiDteaGahkIzRnjg+lBOJMlESKtlnkoO
KThPkft/yaAZwhmQF5gsceMUprQO65lCvwzQAHzhlAbyvVkKfiV2eChyUio/bkYK
xZJ6Q2JVrwLKXXOQlU9IvxgWH/vcsgYG2ju9Yx3ovJoVoZ/pZNwneK7t7zqzhdIm
aoiCvybZZWGdsu/Dcix9CKAcOYetP1nH0gUyR9vwHbMU1k5ZbQTrD/zAxHpiqfwF
/qVNZjN3xgy2FCTAkstsuwg7hu5x/AnNl9/Jh0ZM6Zppgqvn7PXwgQS0cVHHTlsY
2RwEWGdmZ93jf/bJGAR6/pOEVORJIK48+LiKbmaZBomme3P/mXykOuzMYYPCfvRn
t3fFn0+atiK7IYQmyubwkK1373LOXrYRCGVG50xFGpxc1BdWBQKtYIM/FzcDds+A
H2cr0ypF7OurqIdQWZUZjDppmlSAUK5kEQr/iSiJnYcfeVSiB1STUpfFAHcZN8dG
+Qe7XvoZY+wciGXkUUT2
=s2KC
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
