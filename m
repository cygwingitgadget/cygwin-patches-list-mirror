Return-Path: <cygwin-patches-return-8727-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7142 invoked by alias); 27 Mar 2017 15:18:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7127 invoked by uid 89); 27 Mar 2017 15:18:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Mar 2017 15:18:10 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id D7762721E280C	for <cygwin-patches@cygwin.com>; Mon, 27 Mar 2017 17:18:07 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 454B15E0222	for <cygwin-patches@cygwin.com>; Mon, 27 Mar 2017 17:18:07 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 270C4A80695; Mon, 27 Mar 2017 17:18:07 +0200 (CEST)
Date: Mon, 27 Mar 2017 15:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] declaration of ppoll() by poll.h should be guarded by _GNU_SOURCE
Message-ID: <20170327151807.GD8279@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170327150411.143276-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20170327150411.143276-1-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q1/txt/msg00068.txt.bz2


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 934

On Mar 27 16:04, Jon Turney wrote:
> Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
> ---
>  winsup/cygwin/include/sys/poll.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/winsup/cygwin/include/sys/poll.h b/winsup/cygwin/include/sys=
/poll.h
> index 8228278..0da4c3f 100644
> --- a/winsup/cygwin/include/sys/poll.h
> +++ b/winsup/cygwin/include/sys/poll.h
> @@ -39,9 +39,11 @@ struct pollfd {
>  typedef unsigned int nfds_t;
>=20=20
>  extern int poll __P ((struct pollfd *fds, nfds_t nfds, int timeout));
> +#if __GNU_VISIBLE
>  extern int ppoll __P ((struct pollfd *fds, nfds_t nfds,
>  		       const struct timespec *timeout_ts,
>  		       const sigset_t *sigmask));
> +#endif
>=20=20
>  __END_DECLS
>=20=20
> --=20
> 2.8.3

Please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2S0uAAoJEPU2Bp2uRE+gHaUP/1OIrZHigUil7cTU0Jkt+qlC
r8lscsTgyeoTQrscXal19Hbb8XHKW5SqEJjEWROpkh8cwJB5aoDx6q0g1Kmp/jMG
vGkAJCXXshFCp5YRgkoqQ7K2i8kuPmJNJPUeFevY8YcXECwGx2X6bbyFp0HXP7gx
OMoqNvQFP5VeaUE9RxLZOxAZTeUehKEx3VOP1P+qxm1aOJLAJgTC8OgGYIPwurAk
Ry8UEzmRcNQyPeBjy+g47uc1j0Xn0tLaIXJjFOomN/YPWtxenELiRdNpExq253Vn
k/iCG1A7DaSWU2a9DExm/xFozljEmwn834wrATZAk3DZbSIYn8joG78bHzPZeM5f
z5Kj4r7KSrgk8UJ0UFTozAG/qxgd5YQC7vloR4RsF5k05FTus7HAhiWajzHrM7VD
1QJXCBXK6P++z61NXg2102wjsFu98zyGoPSxUu1L8n4QauKEa9Jc0bA2+hU5OoJw
HZ3zFr/16+tJi7/T2LphMlybwYydkf0Kan5+LZ5pJ720ES7kQbYfu9ftrwBIaOr7
yyiTNk84k9k8fBbBpgHbgoKs5x7uzR4ATvQY8eHLFZ5MdLWRiAM28iX20AuA0qOa
+165eZOoLUZaBMp7ae2fXgtlHUBnt2VIAmXkQWxYOvkq+Du5wySdQLJzKw+YtFDE
wweXhnnT3gjNVPhWuuF+
=Kcxv
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
