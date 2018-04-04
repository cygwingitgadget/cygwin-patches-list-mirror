Return-Path: <cygwin-patches-return-9044-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 37928 invoked by alias); 4 Apr 2018 08:39:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 37904 invoked by uid 89); 4 Apr 2018 08:39:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-110.4 required=5.0 tests=BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Apr 2018 08:39:45 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue006 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MQpjt-1ewJ9M3oeD-00U5Qr for <cygwin-patches@cygwin.com>; Wed, 04 Apr 2018 10:39:41 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 97CB3A818CB; Wed,  4 Apr 2018 10:39:41 +0200 (CEST)
Date: Wed, 04 Apr 2018 08:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Posix asynchronous I/O support, part 2
Message-ID: <20180404083941.GJ2833@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180329053153.6620-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <20180329053153.6620-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-UI-Out-Filterresults: notjunk:1;V01:K0:CGZ+nRBBeuU=:jLHW8yyPoP18MnTihlecEW 0s1v+/fNiwCUs8dMFjfgLkMmH3iPTRKF70Lq6H+r+JvxhFE8HtLchTuaQVaCzTGIndtVlgK7t NlUyAdw6SWFZawVFqwi1xw2NiN5wfZZBTEbS4X+mIo4+KPOO2pMOu8c5HA5qikPyO6aDzw4fG ovcsNHf1M95K+UesU6KpRptfsw6k7AzcTGlblQiHJj59+r1619Kfms5lzn7Emt3mu95HBMvDW bkSMmPM2XqkAcdX5RHvpyXJco9Lak8x5dzbDp29h4b/Eqq17hDiP+B6Pghl6YdGwlJafD6BXl UX8QS1K56TalDAqo1Npyd0NWFAqiggb5rIN7MqiEMOU5aOYMDOYco62kcLOavnWddnwqdEVH1 MAvUqa+fbSFBf5aAf5Tn5K/Y8rQltzaI+gKedGD+z2QgTAX8+O3/m4pggGyFETjPV2//vc3lb KDtMNdXRisn2AFB3C1kziwJA+JG9zoe1H3xPHfgtWWXBKK0tSxeBAxIBSgNP3WN6yvXsQbKJE eVobPdsOoXd1/XU9IEfB2qXVLcpqXbw7mc8pNS8Wsm+gvxPaGRnWlRtzHKdMeWDT3IcDawyBQ S5MibS3fK+JuYYblVIMuq4bVFbrqh7JfWeVsxXJaGK+tSgXyJFTSPZjc4h7QJ4DgwXkddjZju qCC0TQKfuaPkOjZdbPXEPMdBIBkXUVNqjfLSKe+G5VevWTxzP9HzIaKjiqlBYwaaD5MhoUtyf LPMfPfEa28IWatW+yHmYEEGFitOb6wzsRMdyIQ==
X-SW-Source: 2018-q2/txt/msg00001.txt.bz2


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 396

On Mar 28 22:31, Mark Geisert wrote:
> ---
>  winsup/cygwin/include/aio.h | 78 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 winsup/cygwin/include/aio.h

Looks fine, too.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlrEj00ACgkQ9TYGna5E
T6DOIRAApKXfWjDcBki5vkVEgWk4yXhrhFIV1vGlogQ3f9BiAnHXaic4BNRkIjnK
AQ5empm4uENiAq/kiTNXYKbqkEwOLiZJbVA1Z5jiLriHDHl8dtDfAe4BZDCCfffh
rh3ZHrycT64AnObaOQobFOHwEODQt2H5AlDjAx2wn0mEi1S9am1NzqVeGKxeY3My
toRsQ8DlsScnmUnoWsuN9UfVVQnTOiYbwS8a3MPitiOt8gTi0e45CQzKBcTIcgRK
8e0O4bvqBvvrg+wCtL68AgI/wySVEEjZ+gaeYz1raNfvo+dhOxhcMXW+AthCwEAi
RS7ADZosPRtiRHNpwUHPqJdBcfG8SXz4+QW8+g401wWjL8n9Zdiuaf1Yj745yBj3
bDFsXTyvOP/q3fK5lYv4ExFLmxu8uG9nn8RG/aBYgNqf1rvzTunmQ58yOBrpqiZu
OdHZDhirCCPXGL+8VfLXOD5f+TLPsaFFP4yjxvBSo1sfjWEe2yu6BdLXIlImIZMX
ip7FS8UveZw4XnhUdcP/lsWB41Iq3rRUJJyTduMlMoCvrU5sxZFjBsk/uJtWQQQT
dSzaEen608VgsKZj3M0WDkGvjA/hNPzA0hKo3vbsPbSpou7em+UYaQuJWu0FWMcQ
RkLx/5UdwbVJvubvY9UZV4kFQv+Nw8hvMYMdkxXblE5iTSCQd1s=
=tPXd
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
