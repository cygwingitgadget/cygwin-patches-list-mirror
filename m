Return-Path: <cygwin-patches-return-9078-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18700 invoked by alias); 5 Jun 2018 09:54:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17526 invoked by uid 89); 5 Jun 2018 09:54:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=headsup, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Jun 2018 09:54:50 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MaRPE-1fjrNo01DU-00JnfA for <cygwin-patches@cygwin.com>; Tue, 05 Jun 2018 11:54:48 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8A555A8195B; Tue,  5 Jun 2018 11:54:47 +0200 (CEST)
Date: Tue, 05 Jun 2018 09:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/5] Cygwin: Allow the environment pointer to be NULL
Message-ID: <20180605095447.GC17401@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180604193607.17088-1-kbrown@cornell.edu> <20180604193607.17088-3-kbrown@cornell.edu> <1b83c074-0b82-87a0-0ba0-2f253c55f69c@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <1b83c074-0b82-87a0-0ba0-2f253c55f69c@cornell.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q2/txt/msg00035.txt.bz2


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 656

On Jun  4 16:35, Ken Brown wrote:
> On 6/4/2018 3:36 PM, Ken Brown wrote:
> > Following glibc, interpret this as meaning the environment is empty.
>=20
> Sorry, please hold off on reviewing this patch.  I just noticed that I
> missed at least one place (build_env()) where environ=3D=3DNULL could cau=
se a
> crash.  I need to fix this and try to make sure there are no others.

Headsup in terms of the differences betwen 32 and 64 bit.  Note the
(historical and oh so ugly) usage of cur_environ().


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsWXecACgkQ9TYGna5E
T6D+5xAAiovAwfACPbdPp4DGy7wRqdbyITgZfCuEQc32he6lAvVVoLWcE5UNMUr6
TIb/V2S5+myVZk6R4XQQZSC36iw9Yh2vdC0lCC86pBZ5UjXBmFUHv22blb2sCvY4
BHXnJe9qtKUw4J0YHKE8lkwVrShpRjkudFh2nlv4rOvE6p8zuhCxEVAwEIABYkmO
8YgOwZ0NwVm6bSTBFLjlo4jXpW1CChyuwLcSf/77SXM3lqHjQrWKXdfa78U1fdlf
L0vflIqE8PTR2YfSIwJCL6kJD3amfzZjHDTN2F7P4PPd7Hv8ZAKEkotpF35dCoTH
JQ/6UIIHf/JcoSYKCanRhxLSc/2BaIdgfIxH20pj6taI+XKuAtpSoYFM01qGp44i
ZslVLBq7ffaA5ksBx6AR4P0R/BBnnEyr8XR02Zcidk3iq2XiuQ+YbjABYcMcyRpq
3kBGYJvqbLMRRvHk/5IK6drm8Xwx2yztHgdUWDojvaCoCejhbfI18Q9kkKYf1UhS
1BbDXWxHRjfcIQTFA7IfMneoHMUyPLHTlHvlo1sfXUnO1PW6nzFxJEpqrPkHwxCI
V56pSsRb2ajksV8HxsVn6QeckzUl2vXQXtm+Z5/PLr3TGNizwqAA6Ipo3F/f8Ewf
HM8ieQ+SdeNZmV0lZGQOmgOhZq8YiflxC1UQmQqjEAlVaZ3iVbo=
=jLXF
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
