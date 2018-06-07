Return-Path: <cygwin-patches-return-9091-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16806 invoked by alias); 7 Jun 2018 08:15:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16677 invoked by uid 89); 7 Jun 2018 08:15:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-110.9 required=5.0 tests=BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 07 Jun 2018 08:15:48 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue006 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MNRWv-1fKWQC3DnV-006wbV for <cygwin-patches@cygwin.com>; Thu, 07 Jun 2018 10:15:45 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C2812A804D8; Thu,  7 Jun 2018 10:15:44 +0200 (CEST)
Date: Thu, 07 Jun 2018 08:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/6] Implement clearenv
Message-ID: <20180607081544.GA30775@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180606154559.6828-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20180606154559.6828-1-kbrown@cornell.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q2/txt/msg00048.txt.bz2


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1678

On Jun  6 11:45, Ken Brown wrote:
> This is a followup to https://cygwin.com/ml/cygwin/2018-05/msg00334.html.
>=20
> In this patch series I attempt to implement the glibc extension
> clearenv(). I also implement glibc's notion of environ=3D=3DNULL being
> shorthand for an empty environment.
>=20
> v2: In patch 2 I've tried harder to fix all the cases in which
> environ=3D=3DNULL could be a problem.  I did this by grepping the sources
> for 'cur_environ' and '__cygwin_environ', but it's still possible that
> I missed something.
>=20
> I've also incorporated the changes suggested by Corinna and Yaakov.
>=20
> Ken Brown (6):
>   Cygwin: Clarify some code in environ.cc
>   Cygwin: Allow the environment pointer to be NULL
>   Cygwin: Implement the GNU extension clearenv
>   Cygwin: Remove workaround in environ.cc
>   Cygwin: Document clearenv and bump API minor
>   Bump Cygwin DLL version to 2.11.0
>=20
>  winsup/cygwin/common.din                 |  1 +
>  winsup/cygwin/environ.cc                 | 56 +++++++++++++++++++-----
>  winsup/cygwin/include/cygwin/stdlib.h    |  3 ++
>  winsup/cygwin/include/cygwin/version.h   |  7 +--
>  winsup/cygwin/pinfo.cc                   |  7 +--
>  winsup/cygwin/release/{2.10.1 =3D> 2.11.0} |  1 +
>  winsup/doc/new-features.xml              | 20 +++++++++
>  winsup/doc/posix.xml                     |  1 +
>  8 files changed, 80 insertions(+), 16 deletions(-)
>  rename winsup/cygwin/release/{2.10.1 =3D> 2.11.0} (97%)
>=20
> --=20
> 2.17.0

Good job.  Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsY6bAACgkQ9TYGna5E
T6CmrRAAgnunR4AOoF+BBVDOItOYXAIPswwcj52UF8toDJrcV65Tpx9HHVC7tMqC
bvkuXB/AZH7Qw1NRi0xQqUh0X2zpNYHpk4e0SH+Q+OKYbaKIpqkIqjcKSO7a0DeK
Y0IK7KLqhixBShtz+yBjJ1Gsb6dqAlQuXTOOandEVOn4/TiqXJbulH1CPtd0IWsO
eWvdT8cF/yRdXd/bBXhxdVrh2bAeFxcelitzjHhw+bPAzBizDMkw8IuMrFt96ke4
9EZ4z2pM5JzJqctvpmuiZgSwlX3IxL2x3zA5FH0IX9EWogc6nO2D75eULOT3NH5m
gG6SH6Lvbu/I/pPW9u7NYJqV6qCUoLHIaXFVH++ds7acEl8VQP9nhbP+JkFlt8aX
GUjThQtJ15tWjbL/F3lzDfeZRtx3m0eKhTSPxfgs1mWHp3KFAXkNNFg+dKBGSYIv
Xfphvt6J5qs3Rx4LN2vJTVtc3DDEPEtnLEzF8vgHjnNxjWy07n5dhx7CKBwlNox6
fBCoy+AysQ9JbPpHlzgq9HPuG5ZnzQhWWwYoBRRYPwEqz6/IQDUaCSBnDON5BD5b
XMfq+eYkf/jsDoW5ss1whZafmxwHupgoUlRnLY4Xvup6HoFyWzackgN+qkMii0w8
K0pR80BaCwnJkCs673DDGY/3l8WwziJgCti0l+DMw1/pvoju1bY=
=98I7
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
