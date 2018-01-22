Return-Path: <cygwin-patches-return-9016-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66264 invoked by alias); 22 Jan 2018 14:05:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 66247 invoked by uid 89); 22 Jan 2018 14:05:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jan 2018 14:05:12 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 42846721E280C	for <cygwin-patches@cygwin.com>; Mon, 22 Jan 2018 15:05:08 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id D250A5E040E	for <cygwin-patches@cygwin.com>; Mon, 22 Jan 2018 15:05:07 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BA4CBA80756; Mon, 22 Jan 2018 15:05:07 +0100 (CET)
Date: Mon, 22 Jan 2018 14:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: Declare pthread_rwlock_timedrdlock, pthread_rwlock_timedwrlock
Message-ID: <20180122140507.GU18814@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180122055151.12900-1-yselkowi@redhat.com> <20180122085059.GQ18814@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="iKKZt69u2Wx/rspf"
Content-Disposition: inline
In-Reply-To: <20180122085059.GQ18814@calimero.vinschen.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2018-q1/txt/msg00024.txt.bz2


--iKKZt69u2Wx/rspf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1665

On Jan 22 09:50, Corinna Vinschen wrote:
> On Jan 21 23:51, Yaakov Selkowitz wrote:
> > These were added in commit 8128f5482f2b1889e2336488e9d45a33c9972d11 but
> > without their public declarations.
> >=20
> > Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> > ---
> >  winsup/cygwin/include/pthread.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pt=
hread.h
> > index 6d3bfd0eb..3dfc2bc80 100644
> > --- a/winsup/cygwin/include/pthread.h
> > +++ b/winsup/cygwin/include/pthread.h
> > @@ -191,8 +191,12 @@ int pthread_spin_unlock (pthread_spinlock_t *);
> >  int pthread_rwlock_destroy (pthread_rwlock_t *rwlock);
> >  int pthread_rwlock_init (pthread_rwlock_t *rwlock, const pthread_rwloc=
kattr_t *attr);
> >  int pthread_rwlock_rdlock (pthread_rwlock_t *rwlock);
> > +int pthread_rwlock_timedrdlock (pthread_rwlock_t *rwlock,
> > +				const struct timespec *abstime);
> >  int pthread_rwlock_tryrdlock (pthread_rwlock_t *rwlock);
> >  int pthread_rwlock_wrlock (pthread_rwlock_t *rwlock);
> > +int pthread_rwlock_timedwrlock (pthread_rwlock_t *rwlock,
> > +				const struct timespec *abstime);
> >  int pthread_rwlock_trywrlock (pthread_rwlock_t *rwlock);
> >  int pthread_rwlock_unlock (pthread_rwlock_t *rwlock);
> >  int pthread_rwlockattr_init (pthread_rwlockattr_t *rwlockattr);
> > --=20
> > 2.15.1
>=20
> Ouch, thanks for catching.  ACK.

I pushed this patch myself to build a 2.10.0-0.2 test release.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--iKKZt69u2Wx/rspf
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlpl75MACgkQ9TYGna5E
T6B+BA/7BJEd+nz/rcIzLGbdTcgNORvtbCufNc2tLtYDni9dyTBGBlf2XHfGszmX
ZyKY3w9+9f24t1wSRzUZMFUXhlJ3S7CfKQRe0Z1ntaNFiI1GwDFNhIVN6Zhjsvsr
z4xND3GhxsJec2UEM0ATMSj8+pGPN9jdOjZNlvrMWv+5EZ0qwnjqD2sGWTUgzI7Z
pZIi4hbauwOAn4+iQomX6OVraUSh4RYhy7ZvZKGNseWtVQmMOYQwtRmijWZeHCPQ
8MGeRWJD7Lugk+YarG07MgPHpY8s3kT79s1sADEMmuqy7lcpcpkYK+Y1eXL0H4Qb
4Zi84YhglnjjcN4ycN6FcFFMav1ptFf6fVECv4aX6OzBEzKGRmapIfNNA05YVOOF
8eRrUQPTYYQaeIBhylDaFKpbUu1Y8Fws/ATssPBKRWlc/o0PoRaIVEH/dzv9r04A
TgRSlYKvrOPWwBwyjLpzGOgnzzU8tztoaJKZ4NoKbZ6733FxECfK3K6QL7VzMgED
MwoPVGIYftblawbBcuIA0yIROsBgbSY82Scfs8Nt9Udxf0IT9JFwocsHJ3YL9F6X
gfbN30DOOPExGLt7Z7exJghu3KGV1zLImAtNBLuoAj12tEoIznLzOOzRmU5DcWVj
WorYlPHWuglcZrEJo9+ejhqqYilA/t5gTbXV6Mw+YY3rw4Gl5MY=
=3r5m
-----END PGP SIGNATURE-----

--iKKZt69u2Wx/rspf--
