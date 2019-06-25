Return-Path: <cygwin-patches-return-9457-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46575 invoked by alias); 25 Jun 2019 07:31:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46563 invoked by uid 89); 25 Jun 2019 07:31:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-115.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Jun 2019 07:31:36 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MsI0K-1iZ0ZT39Rq-00tkhA for <cygwin-patches@cygwin.com>; Tue, 25 Jun 2019 09:31:33 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 23553A807B0; Tue, 25 Jun 2019 09:31:33 +0200 (CEST)
Date: Tue, 25 Jun 2019 07:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix return value of sched_getaffinity
Message-ID: <20190625073133.GE5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190625052523.1927-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <20190625052523.1927-1-mark@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00164.txt.bz2


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1146

Hi Mark,

On Jun 24 22:25, Mark Geisert wrote:
> Return what the documentation says, instead of a misreading of it.
> ---
>  winsup/cygwin/sched.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/sched.cc b/winsup/cygwin/sched.cc
> index e7b44d319..8f24bf80d 100644
> --- a/winsup/cygwin/sched.cc
> +++ b/winsup/cygwin/sched.cc
> @@ -608,7 +608,7 @@ done:
>    else
>      {
>        /* Emulate documented Linux kernel behavior on successful return */
> -      status =3D wincap.cpu_count ();
> +      status =3D sizeof (cpu_set_t);

Wait... what docs are you referring to?  The Linux man page in Fedora 29
says

 On success, sched_setaffinity() and sched_getaffinity() return  0.   On
 error, -1 is returned, and errno is set appropriately.

Also, while at it, would you mind to rearrange the code a bit at this
point?  I think it's a bit puzzeling that status indicates an error code
as well as the non-errno return code from this function.  Kind of like
this:

  if (status)
    {
      set_errno (status)
      return -1;
    }
  return 0;


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0RzdQACgkQ9TYGna5E
T6A4Ug/+PPG5HMCFL/itEQ9SgP8l2mXKb9dZLEK4poEdoh7J8uXtX0k8T77KIs3l
uKi3XsWtbND+Oax92jXnZkDy6YfXF7kKTXw0mrwfC4HwzE0UDJ9p+Ccoa+IlZIb2
16fsSiYocp4DZeQgNdK1JV87qcr5heCcXpwWwCFdtGHj/YfSSbuv6mx9UoSWKzG8
VfiI9I3FZeO/HdOgbaYJUHarnWnt6BsXhXjLBYIjk8g6GRKY4bzBKWywvSupVm0T
muHymzhV5xpaazXOUaP21jFeTWFAxeAujwOWJpWFW5LDtXLpQZtTVv/CWJ/+fBTU
Z0MPuE3lXfb8JVQ/YjqJnhtaX9Jrn5D29cPtpclUu827DDBvpZUxlfdH+X0GJecj
i4kXwD4E7tDnSFw+itH+JMruW/XifXt4rGYV7+bxRjEA/TidDFdoc3na3KS94AtO
CGLoh4Ww60WxirjmRe6COh9xD5hurN5GJzR4dD9FS3/nMGVSIPtauMuQFoQda8yw
4DUrHtoUfW5nL3H/w2JEuA+dSeeY/QkeYr7KJoe1ePZGPHjOmW8XqdiUagkmrby9
vxY0aCnfc3b63B0HUcTMtAyn668383g7u+hJhIbXag2bCzbHgWCJ3jHtWNNLYM60
2l42y1Fha7ojY3YZT3YFWJedxt/8+1tUlwtU/nyXuPEXaOSPQsU=
=tY6P
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
