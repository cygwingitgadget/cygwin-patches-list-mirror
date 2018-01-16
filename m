Return-Path: <cygwin-patches-return-8997-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68542 invoked by alias); 16 Jan 2018 15:44:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68517 invoked by uid 89); 16 Jan 2018 15:44:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1347, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jan 2018 15:44:06 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 0B73A721E282E	for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2018 16:43:59 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id C2F585E01E7	for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2018 16:43:58 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C0A9DA80613; Tue, 16 Jan 2018 16:43:58 +0100 (CET)
Date: Tue, 16 Jan 2018 15:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: add LFS_CFLAGS etc. to confstr/getconf
Message-ID: <20180116154358.GC3255@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180116031900.18732-1-yselkowi@redhat.com> <20180116092749.GB3009@calimero.vinschen.de> <9637bdd8-e68f-613b-8074-e711a62447ce@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <9637bdd8-e68f-613b-8074-e711a62447ce@cygwin.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2018-q1/txt/msg00005.txt.bz2


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1511

On Jan 16 09:03, Yaakov Selkowitz wrote:
> On 2018-01-16 03:27, Corinna Vinschen wrote:
> > On Jan 15 21:19, Yaakov Selkowitz wrote:
> >> These are used, for instance, when cross-compiling the Linux kernel.
> >>
> >> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> >> ---
> >>  newlib/libc/include/sys/unistd.h | 4 ++++
> >>  winsup/cygwin/sysconf.cc         | 6 +++++-
> >>  winsup/utils/getconf.c           | 4 ++++
> >>  3 files changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/newlib/libc/include/sys/unistd.h b/newlib/libc/include/sy=
s/unistd.h
> >> index f216fb95c..5386bd49d 100644
> >> --- a/newlib/libc/include/sys/unistd.h
> >> +++ b/newlib/libc/include/sys/unistd.h
> >> @@ -582,6 +582,10 @@ int	unlinkat (int, const char *, int);
> >>  #define _CS_POSIX_V7_THREADS_LDFLAGS          19
> >>  #define _CS_V7_ENV                            20
> >>  #define _CS_V6_ENV                            _CS_V7_ENV
> >> +#define _CS_LFS_CFLAGS                        21
> >> +#define _CS_LFS_LDFLAGS                       22
> >> +#define _CS_LFS_LIBS                          23
> >> +#define _CS_LFS_LINTFLAGS                     24
> >=20
> > Basically ok, but while at it, wouldn't it make sense to add the LFS64
> > macros too?
>=20
> No, because we do not provide off64_t or the *64 function declarations.

Ok.  ACK


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlpeHb4ACgkQ9TYGna5E
T6DMpQ/+O6wmj1/RC0F1PmNDPt8qrrcbaHc1RYspp88zR9tZ/s0tGC+GudDwJZys
wsyTI+YIzwo3e9mm9D5BbGWkSqnhIdplufDK0JvW/1ga2A2R3f0yXIbmGE+Jxw/p
3mJwtTELN8dcR9STeM8OyIYR4pEzt+mJAhJjo8N6HeG0jwgUnOA1aiMiS5PFKYOE
LKzHRPk6PAN8OzfoAMg11mJpQfij1gT+k8cKgKIDkrPCR06axDCf7RcWr8fNgtVc
o7iQE1o3eXBhYaUtvNSxJKBeYFQR7K5xqcQSC0cu//qKgGgWRZ6YijNWDIzL3VuT
rvDZClE14jrIrWeCG4TIq8t0rGAgr8RMpXv2qtWPRqqB9TV3TZEP5MarOe3DefRH
FvqiwYYsST0CV79lgV7ijY7gJwuCsrfhjLknK/8IGAz18cfZiZ9Wls+yh9uLtorQ
U/rTID+UOEfSUwebfkJLEV6Q2SvATmu0p1/iOQ4vSnpXtvRDebR1dJxbPwNkLqOL
/yTDUl7YfSPvRCgD+KxL6N+LXLQDM5iyTnZrp49RhcftTfY1Ez4MfLnKqRbB+vkP
MLcbPcSegyKVZsL9a8sO5/171Tz4Ivceqbj322uqhaQkDPcWWvzeXf66o2Edo3ph
QO/jP0Sw+C4gg+mM/3Z+Nz6gEhvZphhRelSsXDwIAtNFxQyllWM=
=GwfY
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
