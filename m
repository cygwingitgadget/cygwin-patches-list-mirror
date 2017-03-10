Return-Path: <cygwin-patches-return-8712-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3689 invoked by alias); 10 Mar 2017 20:24:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3562 invoked by uid 89); 10 Mar 2017 20:24:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, planning
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 10 Mar 2017 20:24:15 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id C4B67721E281C	for <cygwin-patches@cygwin.com>; Fri, 10 Mar 2017 21:24:13 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 3772E5E019B	for <cygwin-patches@cygwin.com>; Fri, 10 Mar 2017 21:24:13 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1D937A80388; Fri, 10 Mar 2017 21:24:13 +0100 (CET)
Date: Fri, 10 Mar 2017 20:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] forkables: hardlink without WRITE_ATTRIBUTES first
Message-ID: <20170310202413.GA22238@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170310103254.5513-1-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20170310103254.5513-1-michael.haubenwallner@ssi-schaefer.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00053.txt.bz2


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1026

On Mar 10 11:32, Michael Haubenwallner wrote:
> When the current process has renamed (to bin) a readonly dll, we get
> STATUS_TRANSACTION_NOT_ACTIVE for unknown reason when subsequently
> creating the forkable hardlink. A workaround is to open the original
> file with FILE_WRITE_ATTRIBUTES access, but that fails with permission
> denied for users not owning the original file.
>=20
> * forkable.cc (dll::create_forkable): Retry hardlink creation using the
> original file's handle opened with FILE_WRITE_ATTRIBUTES access when the
> first attempt fails with STATUS_TRANSACTION_NOT_ACTIVE.

Patch applied to topic/forkables (which I rebased so pull -f).

I'm planning to make a 2.8.0 release and then pull over the forkables
stuff to master for the next release.  Maybe we should bump the DLL
version to 3.0 then.  It's a pretty big functionality extension...


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwwtsAAoJEPU2Bp2uRE+gRtsP/0ZsqPmc/lPbTbfWkUkwKoOv
FvAS5moRAPEq1k5mbH3DHGuu+eRTHiCWPBuMoib9IBs+dq+5l/7mzK54/AG4hKCu
G/dt4eYbL1aNebXL8CDMWvXnySEiNoh+3LlaG09GWEoQTnDk9obhWVaA0BW3aGwl
rXnYv0QXfIrbVuWTyTkqWpq8aPBclJlLECoTotG7zAL1D8OCm7ExZCwlS+CzyOcK
ua+w2t1NH4TfMubwxRt1C8hlepmt71dYr9XqfF7JrB5VtD2+T1j3r7JjlM6KbjNp
oeTiPcmoOb7Iyr16BaYW7Mnr/GxamdQYcEchfhf6+E784WdpKYwH7iuaGA/7VQcS
u5sp9vpL0BPpr3QOWwsEtFr8Ri7Rb4a7UP3lZYQg2h42w9rbkbLN4l3gqoaKXq9i
FCNrvracI5FZyPi6/MnYNhJk9BihvPZjaifuev/Dl+AobnJgJZKDnq8R0uS9D6rL
ZGFlbL4mqiG9ZF1i3H3QAZNbW8QVdromYmc3c+YJoQR2fyJZVhkQ3xqbBymhWAO4
HToU0cy/TuAHiNFfGNiN6S89TwWAhfEtVRNyEoLAsko4nABtaFCbWOjbMYBD+KOC
6A6vpM54h6K9cuo2+nz4h3NYvxfFD1MDg1m8elGjhDvtTg7zqYYmsxc9G6PXgftT
j+fgyf4dML6xSUJZjnEI
=ZRXz
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
