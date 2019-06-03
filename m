Return-Path: <cygwin-patches-return-9428-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49451 invoked by alias); 3 Jun 2019 19:35:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 49442 invoked by uid 89); 3 Jun 2019 19:35:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-102.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:585, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 03 Jun 2019 19:35:23 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MiIhU-1gtqgT3xRu-00fUHe for <cygwin-patches@cygwin.com>; Mon, 03 Jun 2019 21:35:20 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 39CF4A80653; Mon,  3 Jun 2019 21:35:19 +0200 (CEST)
Date: Mon, 03 Jun 2019 19:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Yaakov Selkowitz <yselkowi@redhat.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: expand common_apps list
Message-ID: <20190603193519.GP3437@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Yaakov Selkowitz <yselkowi@redhat.com>,	cygwin-patches@cygwin.com
References: <20190523170532.64113-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="9DptZICXTlJ7FQ09"
Content-Disposition: inline
In-Reply-To: <20190523170532.64113-1-yselkowi@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00135.txt.bz2


--9DptZICXTlJ7FQ09
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 548

Hi Yaakov,

On May 23 13:05, Yaakov Selkowitz wrote:
> An increasing number of tools are being included in Windows which have the
> same names as those included in Cygwin packages.  Indicating which one is
> first in PATH can be helpful in diagnosing behavioural discrepencies
> between them.
>=20
> Also, fix the alphabetization of ssh.

on second thought you don't have to wait for Brian's reply.  Just
push this.  If Brian has some more input, you can easily add another
patch, right?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--9DptZICXTlJ7FQ09
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlz1dncACgkQ9TYGna5E
T6A8MQ/8DOdY+3vYERBDpy7Ny1Q7HnC2PL+Ur4YWMYkbZLMN6RRh5Dp7901OmksY
Uy0GGq8czvPfuq8SeEQgJLzG1O+WnK6dlNH5spUSV6igdSWx5V0BjsdDfI1H/rK0
ORCyU1aRMU6EomEQ9jZJYtPbiagdIL96BXVXV3dylJjzFmDr3CTo++W1qctk1SRY
dKFJhTNu/5op7fOLzpsn8dqCIwlGGu92yC0IpyF6/H9RTnYIlZRA+wA5BvkJy4NX
eg1SMx0Kt7tWA+efR9oNPl23goXU6bWJuhoE/IJJgbhH7iKla9U7tMDZhosoZsS5
oCbRp8iqXMsOn6AEMf7RaVz2wxk2tmDop6GoC4p4YhiWf9JFyJ7lT9Zl4c0xt7x9
eyU+Ay1oghM8+ZOozgWvDXhF2x/0CtAUq7o9GArAvt+FdyQsESYomRe4O/6CAW9V
XbaYYaNDEY5o6pqlnAVVwyGB3xtnCdTqyOXRvPObuQOG7Z9ZuXua9M74oRoE/fMJ
7jpIeypSnyXa3FISdLlJMN5i2q+vbzcrj5L7GaTVpty7G8DcBdaJVMu/By0PvTaz
dK4h8MXjIg3Nz5LWFYAvhjZjJ/2UseXKXvxeMS1+YAvvrkymuALMD4la0EAzJP35
wS3c/s0hTTLH+/TK9foH5zPP2NrvYvS1RGV/hOuz6fCYRZ5vDBQ=
=ywua
-----END PGP SIGNATURE-----

--9DptZICXTlJ7FQ09--
