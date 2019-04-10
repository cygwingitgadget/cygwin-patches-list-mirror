Return-Path: <cygwin-patches-return-9323-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25167 invoked by alias); 10 Apr 2019 20:50:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25157 invoked by uid 89); 10 Apr 2019 20:50:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-110.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 10 Apr 2019 20:50:26 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M2gt5-1hAkbn1Zy3-004Aeg for <cygwin-patches@cygwin.com>; Wed, 10 Apr 2019 22:50:24 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BE7B1A8044F; Wed, 10 Apr 2019 22:50:23 +0200 (CEST)
Date: Wed, 10 Apr 2019 20:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Improve error handling in /proc/[pid]/ virtual files.
Message-ID: <20190410205023.GM4248@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190410150522.22920-1-erik.m.bray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="I3tAPq1Rm2pUxvsp"
Content-Disposition: inline
In-Reply-To: <20190410150522.22920-1-erik.m.bray@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00030.txt.bz2


--I3tAPq1Rm2pUxvsp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 821

On Apr 10 17:05, Erik M. Bray wrote:
> * Changes error handling to allow /proc/[pid]/ virtual files to be
>   empty in some cases (in this case the file's formatter should return
>   -1 upon error, not 0).
>=20
> * Better error handling of /proc/[pid]/stat for zombie processes:
>   previously trying to open this file on zombie processes resulted
>   in an EINVAL being returned by open().  Now the file can be read,
>   and fields that can no longer be read are just zeroed.
>=20
> * Similarly for /proc/[pid]/statm for zombie processes.
>=20
> * Similarly for /proc/[pid]/maps for zombie processes (in this case the
>   file can be read but is zero-length, which is consistent with observed
>   behavior on Linux.

Pushed.  New snapshots building right now.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--I3tAPq1Rm2pUxvsp
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyuVw8ACgkQ9TYGna5E
T6AEcg/9EEe5v0sg0d2kvQqfHSCOddHNhWJUU8+IuehTNRe24GbXUKF+9NUNVhBU
unEbRlnHxaOi8D5kJoVT6YEMDTPgZqwsvgzNuJGt5Zna59QchesDst+/ywWxJ0/c
s8cq7WER3PonOKfH7fKPWT2bmWh87iYrPG5eDdPWPDs1ZEb90MLpfQcNyqUHGV0f
PHntfYIefWvfVj4SsRWxSBZrRbegIpJhbZ4ZMOIiv/UPrudA/ZpX6UJynZFp2Hz7
XrnjqjvdpstkUIFO0fUQneH2zp6DIQJ4UmviDscTAEKh/Ams4Ve3scPB+x3wPcpb
rex7uKFoVPnHy8yTx/IP86INaiR66hM0Cy3kKiQzZtPnuaTq2jAvcBSmZhYq2oFp
B2eTwg95eiQfuzQdBzoPb2zAJYzl9YLfS0WmSmF4UenqU1BcgRqDWm3mBTIm4SBM
w6oqGBmUtdaZbBjHrKvUxKLIDBUu6yQ525N9TAzYua57K/Z7YSxmsfBpSDChcjhE
5tyxEyPs65UAsqlDj4Y3AqZVXuXAh9I2W7iy5RnCkv94KFfC64wYJw6XpfXWSmjF
NpkRIlbtCFe9MQ6DvhWI8XT67Dow7fTFqxTyOxIkJowD1ZCLb5sKMFIRYheDXsIU
Rm2qeHwQzGvbn+Su3wBzJMcxy++oss8bC+i3I1PMs2A5ymCoXDk=
=Emfp
-----END PGP SIGNATURE-----

--I3tAPq1Rm2pUxvsp--
