Return-Path: <cygwin-patches-return-9015-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 52262 invoked by alias); 22 Jan 2018 08:51:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52235 invoked by uid 89); 22 Jan 2018 08:51:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jan 2018 08:51:04 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id F1E3F721E280C	for <cygwin-patches@cygwin.com>; Mon, 22 Jan 2018 09:50:59 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 7A7D75E040E	for <cygwin-patches@cygwin.com>; Mon, 22 Jan 2018 09:50:59 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 64BE2A8059C; Mon, 22 Jan 2018 09:50:59 +0100 (CET)
Date: Mon, 22 Jan 2018 08:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: Declare pthread_rwlock_timedrdlock, pthread_rwlock_timedwrlock
Message-ID: <20180122085059.GQ18814@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180122055151.12900-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="HcXnUX77nabWBLF4"
Content-Disposition: inline
In-Reply-To: <20180122055151.12900-1-yselkowi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2018-q1/txt/msg00023.txt.bz2


--HcXnUX77nabWBLF4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1498

On Jan 21 23:51, Yaakov Selkowitz wrote:
> These were added in commit 8128f5482f2b1889e2336488e9d45a33c9972d11 but
> without their public declarations.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/include/pthread.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthr=
ead.h
> index 6d3bfd0eb..3dfc2bc80 100644
> --- a/winsup/cygwin/include/pthread.h
> +++ b/winsup/cygwin/include/pthread.h
> @@ -191,8 +191,12 @@ int pthread_spin_unlock (pthread_spinlock_t *);
>  int pthread_rwlock_destroy (pthread_rwlock_t *rwlock);
>  int pthread_rwlock_init (pthread_rwlock_t *rwlock, const pthread_rwlocka=
ttr_t *attr);
>  int pthread_rwlock_rdlock (pthread_rwlock_t *rwlock);
> +int pthread_rwlock_timedrdlock (pthread_rwlock_t *rwlock,
> +				const struct timespec *abstime);
>  int pthread_rwlock_tryrdlock (pthread_rwlock_t *rwlock);
>  int pthread_rwlock_wrlock (pthread_rwlock_t *rwlock);
> +int pthread_rwlock_timedwrlock (pthread_rwlock_t *rwlock,
> +				const struct timespec *abstime);
>  int pthread_rwlock_trywrlock (pthread_rwlock_t *rwlock);
>  int pthread_rwlock_unlock (pthread_rwlock_t *rwlock);
>  int pthread_rwlockattr_init (pthread_rwlockattr_t *rwlockattr);
> --=20
> 2.15.1

Ouch, thanks for catching.  ACK.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--HcXnUX77nabWBLF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlplpfMACgkQ9TYGna5E
T6CXFw/+OHTMa/BOI9yoqyxrPVAnqO31BEgjGcsx8jfm+fmC7i2yUWlYYBuyLY6n
L5cHwjnTyc3pI78S/9738j8Q9/i0YWS2ixPik7B0iL09JiRsrmrzMY7VGmsdzh2M
D1ir7Nv/XuJaxEzOKbFBKQy5So8uM9xLI/oC1t9rf9bPBU2+l2lhOLulfQXvv+eY
y8+zzjtjdNbygRlimzzD6dBsieDzSvQHNuvkloK7Agd7UBIW9dHNy3RFSo88Tax+
z/akQcSK/bOtmm+s1JvVfAXStZy0Exsad1QzkhLA0rYdI/qFNfreFAO2Vx5vJ+RO
KT/SexVejA+10LGSaJxhUAJ0lLA48ctG4+zDATT9FZVCQnp0U77+/RGUmqfbPHKW
E0hDiWvDkZT+S8IUXczZpDa6ov2Z3FqZ6PtJ9Exgr8cQ2VNIupv/f1MHnFN1b+uz
hqcE6cFVhOpcGvEf1FNc93XkI5gIzzx0Mhe7bgg067vh8HyVdWOVt6s0qNWYok4Y
/l2595C1hrT4AMYMOrhhxiqXONzLFzNg4CKt/CTTx345xNxIM4L9qh9K8Y+JT7yQ
AmKOBOoLg884+PGJcqSCriTu9PACIz0c409lhdYOGPO+AkIwryKe4wrNRQQYJ1LH
AeKhwnEwwM5gKZyzTItwQ4mJfGEi1jeQ1MQCqBoEsMU4MfgIZ/I=
=cxrk
-----END PGP SIGNATURE-----

--HcXnUX77nabWBLF4--
