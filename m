Return-Path: <cygwin-patches-return-9536-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26526 invoked by alias); 30 Jul 2019 16:07:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26517 invoked by uid 89); 30 Jul 2019 16:07:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=UD:cygwin.com, cygwincom, cygwin.com, retry
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 30 Jul 2019 16:07:58 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M1Hi8-1hvEUD30LC-002kVC for <cygwin-patches@cygwin.com>; Tue, 30 Jul 2019 18:07:55 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 07EE8A80668; Tue, 30 Jul 2019 18:07:55 +0200 (CEST)
Date: Tue, 30 Jul 2019 16:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] silent fork retry with shm (broke emacs-X11)
Message-ID: <20190730160754.GZ11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190730152256.22873-1-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="qKhyKP9HH88saeqA"
Content-Disposition: inline
In-Reply-To: <20190730152256.22873-1-michael.haubenwallner@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00056.txt.bz2


--qKhyKP9HH88saeqA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 963

Hi Michael,

On Jul 30 17:22, Michael Haubenwallner wrote:
> Hi,
>=20
> following up https://cygwin.com/ml/cygwin-patches/2019-q2/msg00155.html
>=20
> It turns out that fixup_shms_after_fork does require the child pinfo to
> be "remember"ed, while the fork retry to be silent on failure requires
> the child to not be "attach"ed yet.
>=20
> As current pinfo.remember performs both "remember" and "attach" at once,
> the first patch does introduce pinfo.remember_without_attach, to not
> change current behaviour of pinfo.remember and keep patches small.
>=20
> However, my first thought was to clean up pinfo API a little and have
> remember not do both "remember+attach" at once, but introduce some new
> remember_and_attach method instead.  But then, when 'bool detach' is
> true, the "_and_attach" does feel wrong.

I'd prefer to drop the reattach call from remember, calling both of them
where appropriate.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--qKhyKP9HH88saeqA
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1Aa1oACgkQ9TYGna5E
T6C+kxAAhx7JnVia3ydk1lwBuJIaKZJdeRt3ZzoNytJATVLn266UdSRY1Kv6HNSa
SqvfFcoV4ueaWY/9J4bqndQ43RIEoqFLWVSCOhW5S+lwwYDF9QWTx9kdu+jeP58W
qNhEa7rMvHvza3h42fQgDOuZWcQP7wJweR3hutkG16UrDZH/BjnHPz33xvdbaNom
WY6PPnEEXgx/DKQ4Kc24zEymJ94aGncr0ZNjnJ4RPKjhpPAhJkLkLkohWzAR4fhg
4Lo+x0BnIG0yYIFhE8tkmcCBWhwN9LjQcJMPC15Hg9G/a17Fr8mfg/7ohtEwXUZI
H1pI/9rCIsQVcBeuWxPHZ07ntmz0sBw1CeZ14lfKa41vzmZdGPJ2/m5GnKs+gLbu
Ac9WY9h4u3PsvhL1fA3qy0Lt3jGoykz0rXgaSso0kyGypysKGVqvZZEg/6BT/9+a
QifgEhPUjR6yoG0hYPmI/1YuZISHv3mU5uNEbpZHAFw5VzKtz6kVFMpZeea2j4z2
elNRXelRXQYnJxm6l3pvgSQBsIJ2cV4joNjH7GtIXgTWqHeRDhvOu2JK+MyJEGMC
sdIkrMMAOxfPGl3C6wvYCdNjRkPNhO4efmuHGv8bjHsT2K57pVoiXHj48kL4HkQh
qZRyP+aMC/zaEj5uN9QetNy+MWl0kT2hmpTIEVbClDlZfi6FZnM=
=lB3T
-----END PGP SIGNATURE-----

--qKhyKP9HH88saeqA--
