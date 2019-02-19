Return-Path: <cygwin-patches-return-9203-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 55245 invoked by alias); 19 Feb 2019 17:41:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 55219 invoked by uid 89); 19 Feb 2019 17:41:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-100.9 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 19 Feb 2019 17:41:51 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mzi3l-1hIbxl3akr-00viUI for <cygwin-patches@cygwin.com>; Tue, 19 Feb 2019 18:41:48 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0D751A803E7; Tue, 19 Feb 2019 18:41:48 +0100 (CET)
Date: Tue, 19 Feb 2019 17:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add secure_getenv
Message-ID: <20190219174147.GP4256@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190219050950.19116-1-yselkowi@redhat.com> <20190219114330.GK4256@calimero.vinschen.de> <20190219115910.GM4256@calimero.vinschen.de> <a31c3d43c9866900e7938015e2fed2c93712348e.camel@redhat.com> <b434e09b-94a5-c7af-db2f-3a9d2dfe991f@redhat.com> <20190219172128.GO4256@calimero.vinschen.de> <20cd56a5-ed2f-27a6-5101-958e44353430@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="l4IMblsHEWQg+b+m"
Content-Disposition: inline
In-Reply-To: <20cd56a5-ed2f-27a6-5101-958e44353430@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SW-Source: 2019-q1/txt/msg00013.txt.bz2


--l4IMblsHEWQg+b+m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1046

On Feb 19 11:27, Eric Blake wrote:
> On 2/19/19 11:21 AM, Corinna Vinschen wrote:
>=20
> >> That said, while it is ideal to avoid squashing to NULL in situations
> >> that are not security boundaries (as with your STC displaying HOME even
> >> after seteuid() on Linux), I'm also okay if we filter too aggressively
> >> (the way gnulib's fallback implementation does when neither
> >> __secure_getenv() nor issetugid() available).
> >=20
> > In fact, gnulib's implementation would chose the
> >=20
> >    if (issetugid ())
> >      return NULL;
> >    return getenv (name);
> >=20
> > branch on Cygwin right now, just as on BSDs.  If that's the right thing
> > to do for BSD, it's not... *really* wrong for Cygwin either, regardless
> > what Linux is doing.
> >=20
> > That in turn means Yaakov's patch is perfeclty fine since it's equivale=
nt
> > to the above gnulib code.
> >=20
> > Agreed?
>=20
> Yes.

Fine, thanks.  Patch is ok to push, Yaakov, just add release msg
changes, too.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--l4IMblsHEWQg+b+m
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlxsP9sACgkQ9TYGna5E
T6B6wRAAg1nRHkE9zYIQ2R0ulXyjjSdHvbJqF3lZHxdoTx5OyQqRk3cKBfShmXTG
BTYCFCT4G9S+rm+Xrz/nVhj6vFyYcXV5yLA5lNjqAmsHxIkelB2BKSUjZREiRv5E
LsLhXUmpIyZHAZVaFRa+5oTnaHmbgH0AMw8jfqSSWGEqGmewcZciZ6r74H5x5/OX
ymYjOoRIr+vtMiqGGyWRnlXTj2ZonwveamX2sM2YJSBnulfSLnFzlGkRMX4Mjxl4
5napB7g4EmQP/k5DYa8IoRlFz2LIOpOqWOvmDcAryN6fWIq0LBIrroRejKO5ULrs
CCQ7wlKYg08eQxKzjVNxLtjTLRUYf8DBeFZWV1OdhUcyZHjU0NlK7P19w6NQNi/q
ZkAs7KlwbnOc4G3IzVuTIM1B2z1Y9qGhoixW/SDETp3KmtzIo2rFHhAGq59RqhqA
V1WjWFYlZvR/xnSryP5L4RDi1l/W/k5hqQ1fjNxDKvMikR6JXumB8fQym6t1MUmw
NfF9+NuUIxZbG1rAGW8em8Fb0aNKLrHtfGz4Z/4t7vIMFLKgW0XiR6OkvjGkhdZ9
o7UOr47ui3kSjdd0uWhp6wv4vdEG4ktZHl6h8S2TDTdLBWWk8WXP2RsVQKaaoBoT
Lflk7dGuIKLpsfV8RYgplPZdWSyXFlRFPI7qO6mYtBKN1c5Gwfo=
=Slbf
-----END PGP SIGNATURE-----

--l4IMblsHEWQg+b+m--
