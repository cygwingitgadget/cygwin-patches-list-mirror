Return-Path: <cygwin-patches-return-9009-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65908 invoked by alias); 19 Jan 2018 10:19:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65870 invoked by uid 89); 19 Jan 2018 10:19:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=incentive, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, mass
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jan 2018 10:19:16 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id C00B1721E2823	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 11:19:12 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 55C915E0091	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 11:19:12 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4736DA8095C; Fri, 19 Jan 2018 11:19:12 +0100 (CET)
Date: Fri, 19 Jan 2018 10:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: make sys/socket.h completely visible from netinet/in.h
Message-ID: <20180119101912.GH18814@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180116032447.14572-1-yselkowi@redhat.com> <20180116093004.GC3009@calimero.vinschen.de> <46dd6b85-ecb2-02f2-7da4-45c44a782559@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="QWpDgw58+k1mSFBj"
Content-Disposition: inline
In-Reply-To: <46dd6b85-ecb2-02f2-7da4-45c44a782559@cygwin.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2018-q1/txt/msg00017.txt.bz2


--QWpDgw58+k1mSFBj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 832

On Jan 19 01:28, Yaakov Selkowitz wrote:
> On 2018-01-16 03:30, Corinna Vinschen wrote:
> > You don't explain the incentive behind removing sys/time.h.=20
>=20
> POSIX does not mention the inclusion of <sys/time.h> in <sys/socket.h>
> or <netinet/in.h>, nor is there anything in the latter two that would
> require the former.  I can make this clearer in the commit message.
>=20
> > Sure this doesn't break anything?
> Without a mass scratch rebuild I can never be 100% sure. :-)  But so
> far, no issues, and the first part of this definitely helps.

ACK.  Please apply these as two separate patches so we can easily revert
the include *if* it results in problems.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--QWpDgw58+k1mSFBj
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlphxiAACgkQ9TYGna5E
T6C74xAAkuc5bEZ+hX+53exO0xVdTNcspzCkTTis7kl0UQIu9G6w6a6k1J0XNQTJ
KFneRcrtMmErveC3Nf3tKx2gKI1/BnOJQ3Er7MOOsEhAeco9YlmTL7cx60kDcj6b
IQS2z2kLamwphysV6oUQQTsIQI4gsbQxWhcVpSaCQj2TjKCI5OU24Adhgod6mB0Y
T8y4EvPdqdtbwMaCgHzufNzBZEAbDGNaBG6MvM6WnWjrGXskVIIvTdCmVJfvzg41
EmbjAn0QjkGNdhmliBCErwGO1XtrT0y+REPv0KibZcQpao65s8r0rxrstVpw63p7
qyr++YnRfrTZsHclJsvrz7gvGAl14uzvGk6qAxBwWCxwzyvG3TfaY600EoMPCbGT
GyHC4Ykh6u3DyHv609j5zM/Ch8Vsd+sx44G7q/HD8CY2dilr0eO91bXg5nBXw/gX
5QNjCLETWWk/YxQ7B6DZ6Z+Kuv7QtLYj+S0vzQCRz0NLG1hDQlAqHAONK9RixfGS
VcQwLRbGoGI6POupk4hsAvMWIo9HPGXipycxTynkGc6n2SRZigt0oG1onsII6sO0
F5kf4+6dc/bk72J57fbIa7lhdMV04ZDLyWDGiRuOX08BZR1oEsbfcbWFrUyvWLmw
6Hi9IgiW3tfhFZkZkvGzWFIOX17oRBp1N9qZwudk9B5WbHTtsvI=
=Hpie
-----END PGP SIGNATURE-----

--QWpDgw58+k1mSFBj--
