Return-Path: <cygwin-patches-return-9300-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 72608 invoked by alias); 3 Apr 2019 12:22:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 72598 invoked by uid 89); 3 Apr 2019 12:22:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 03 Apr 2019 12:22:20 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MWRmF-1hRwYd36Z1-00XpsO; Wed, 03 Apr 2019 14:22:16 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4BE69A8034C; Wed,  3 Apr 2019 14:22:16 +0200 (CEST)
Date: Wed, 03 Apr 2019 12:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190403122216.GX3337@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>,	cygwin-patches@cygwin.com
References: <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com> <20190328095818.GP4096@calimero.vinschen.de> <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com> <20190328203056.GB4096@calimero.vinschen.de> <fe627231-6717-c702-b97b-d66cdc9409a3@ssi-schaefer.com> <20190401145658.GA6331@calimero.vinschen.de> <20190401155636.GN3337@calimero.vinschen.de> <837bc171-eb6f-681e-5167-103f5e9e8523@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Pa4xkLBhPDIhDLv1"
Content-Disposition: inline
In-Reply-To: <837bc171-eb6f-681e-5167-103f5e9e8523@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00007.txt.bz2


--Pa4xkLBhPDIhDLv1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1282

On Apr  3 11:18, Michael Haubenwallner wrote:
> On 4/1/19 5:56 PM, Corinna Vinschen wrote:
> > On Apr  1 16:56, Corinna Vinschen wrote:
> >> On Apr  1 16:28, Michael Haubenwallner wrote:
> >>> On 3/28/19 9:30 PM, Corinna Vinschen wrote:
> >>>> can you please collect the base addresses of all DLLs generated duri=
ng
> >>>> the build, plus their size and make a sorted list?  It would be
> >>>> interesting to know if the hash algorithm in ld is actually as bad
> >>>> as I conjecture.
> >>>
> >>> Please find attached the output of rebase -i for the dlls after boots=
trap
> >>> on Cygwin 3.0.4, each built with ld from binutils-2.31.1.
> >=20
> > Oh, wait.  That's not what I was looking for.  The addresses are ok, but
> > the paths *must* be the ones at the time the DLLs have been created,
> > because that's what ld uses when creating the image base addresses.  The
> > addresses combined with the installation paths don't make sense anymore.
>=20
> So I have intercepted the ld.exe to show 'rebase -i' on any just created =
dll,
> tell about the exact -o argument to ld, and the current directory.
>=20
> This is with binutils-2.31.1
>=20
> Anything else needed?

No, that should be sufficient, thanks for collecting this!


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Pa4xkLBhPDIhDLv1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlykpXgACgkQ9TYGna5E
T6CIRg/8CAKeF5qKdVqVSHFahFX33AcictLQgBVrRfScWQLiVHs7UQWDL1Ddc+Uu
7YGyC5YeeyT2m5R5YOEkIK7LyDkCov3H26Pkw3ikRZ+ZwkV1FNTLQDNcwrB3qXsq
xnnyYiAlNpRNpy+IxiZxGskYRd2T/o9C8kcledH19Hjs8IX78Tr9XbfzRWOVXWnd
12ErjsDsJSp0XnwY7VAPEgBlXGPJr6u4vfPQm+8WZZhG1j/1mXHtA9Gqr6sec0Nf
CYvCS6KLecO8mSUKXjFMVo5QBSYEaGS7SKAa/kogJHMssSmwG5FkwY4ymXTCvEaZ
0uetkRj4xUI7uU7AxkqXE6gjhE0hFF9+IO3rvsiAgcs0BebPiWa3rp9/3a1Ji3lD
7Jv7eOKn7Mzc22Dq4Gx6SE+DLzTfThmu00qF4isVtGG/jmh5+jRH7hxECRx6Q3iJ
kGC8gYxes4YP8M/chdhVRY7J+rFeAhuwKahPIHTLarnzP0rwsrhMJb+XuZy/FghM
08Fvkl7dMUSAfjhuailDrTNjLassu+gN6s00sE1dL2GiGXnnxeePF77E/Fndqrmi
YOq1pvgtiPfWnzo8G7OVnNfaX/qWEveQ88x257m3kmsd/D3aBFKzIglwYc95w1QA
o4Q8gQ5srN0YUzucXlSJPQ1esfITVWDxPTz6OMA4urWXHreHp8s=
=VNun
-----END PGP SIGNATURE-----

--Pa4xkLBhPDIhDLv1--
