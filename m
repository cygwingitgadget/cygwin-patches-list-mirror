Return-Path: <cygwin-patches-return-8754-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 96734 invoked by alias); 22 Apr 2017 12:29:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 96714 invoked by uid 89); 22 Apr 2017 12:29:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-106.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_1,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=rights, business, advised, reserved
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 22 Apr 2017 12:29:20 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id B9F78721E280D	for <cygwin-patches@cygwin.com>; Sat, 22 Apr 2017 14:29:18 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 1CDDE5E01E3	for <cygwin-patches@cygwin.com>; Sat, 22 Apr 2017 14:29:18 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 003C1A80C20; Sat, 22 Apr 2017 14:29:17 +0200 (CEST)
Date: Sat, 22 Apr 2017 12:29:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin-doc html/ missing docbook.css and index dups cygwin-{api,ug-net}
Message-ID: <20170422122917.GB26402@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <970c5445-007e-1817-3006-973e8e26b77a@SystematicSw.ab.ca> <20170419105814.GB19304@calimero.vinschen.de> <4d562b86-271a-9774-efd5-f1d1eecb1b93@SystematicSw.ab.ca> <0cb50b7b-1fc8-0af0-973a-205356825076@dronecode.org.uk> <dab8f805-5790-839f-25df-4b0574dd3ec8@SystematicSw.ab.ca> <20170422085909.GA31226@calimero.vinschen.de> <4b57d3a5-34bd-95f4-9a5c-a9ccebe10628@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <4b57d3a5-34bd-95f4-9a5c-a9ccebe10628@SystematicSw.ab.ca>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00025.txt.bz2


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2150

On Apr 22 03:30, Brian Inglis wrote:
> On 2017-04-22 02:59, Corinna Vinschen wrote:
> > But this is going to become part of the Cygwin repo (the cygwin-docs=20
> > package is created from there), so I need a BSD copyright waiver
> > from you. See https://cygwin.com/contrib.html and the CONTRIBUTORS
> > file in the Cygwin repo:
> > https://cygwin.com/git/?p=3Dnewlib-cygwin.git;f=3Dwinsup/CONTRIBUTORS;h=
b=3DHEAD
>=20
> All my previous and subsequent contributions to Cygwin and related projec=
ts=20
> are provided subject to the the 2-clause BSD licence as below:
>=20
> Copyright (c) <YEAR>, <OWNER>
> All rights reserved.
>=20
> Redistribution and use in source and binary forms, with or without
> modification, are permitted provided that the following conditions are
> met:
>=20
> 1. Redistributions of source code must retain the above copyright
>    notice, this list of conditions and the following disclaimer.
>=20
> 2. Redistributions in binary form must reproduce the above copyright
>    notice, this list of conditions and the following disclaimer in the
>    documentation and/or other materials provided with the distribution.
>=20
> THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS I=
S"
> AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
> LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE
> ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF SUCH DAMAGE.

Thanks.  I applied your patch with a matching Makefile change.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY+0ydAAoJEPU2Bp2uRE+gDjUQAJgpvWGeYl6jFs266BPACHOG
DG5SMeZ2JcIRyk3V1yuD0Mvr0UgtOBvGHP8ObSCQMCCxdUNPzHtt1LI/u/ufietm
r7Hgw0c+PSj4/s60B2KZ3ztwrpNzDt5aZ+yuJwjSuKQEC6NsdJUqSYSLS/zBwIOc
Qm90Pbu5QFJt364jT3nWPKvD9VymxhnDTQ+ix25XFUwJWGf+8pYgIg9w/SiioX/l
WmJk4KMV7iebTkAX5yOxDZwdtVN9sYqC4dJW2Sz39ZtqnUKxqzzDSISacYqBdXAj
LaHi/JohfkbOw4mmYXfpTwjFyoc8JXbSb1RbZMcY8LVSoW7dz0S+6WWmpaB7BfFO
3sjp/+UM0G7K4sgi9Dp+dS9x72pRllYfX6/aXxEZ3cJbRoljRP6rFwmIU06pDJRy
pfs1TdEfe6HzGRpyA16nhmDNvJYKtgEBjJMuSRLWxUO2cV2YsTj6wTxhhOG10nfW
SSv0dbg88NCQRKpVCFmCldXeY1eW4KE5PBCs5vLthtrymdVbNi4C+3TElzua5u/p
o9QOMJPc9SCIjZaWNJazUqfyPTHFPV4QGAFfpkTbwdlzizGdcpGlgtnbly/QI37u
Rnc1wrjO4z0pvV01i7uXQ3kF+azzQkpRl4rLad9L6/PxIleCbnggUKbYB7O+XS7W
JOyV26Q3RY7ihuj2IyQc
=79Og
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
