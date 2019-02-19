Return-Path: <cygwin-patches-return-9198-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 33837 invoked by alias); 19 Feb 2019 11:59:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 33801 invoked by uid 89); 19 Feb 2019 11:59:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.9 required=5.0 tests=BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*F:D*cygwin.com, our
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 19 Feb 2019 11:59:14 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MeTHG-1hWDgR2Lwq-00aW1g for <cygwin-patches@cygwin.com>; Tue, 19 Feb 2019 12:59:11 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A4754A80857; Tue, 19 Feb 2019 12:59:10 +0100 (CET)
Date: Tue, 19 Feb 2019 11:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add secure_getenv
Message-ID: <20190219115910.GM4256@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190219050950.19116-1-yselkowi@redhat.com> <20190219114330.GK4256@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="qpqR4wE1CEr+Roqx"
Content-Disposition: inline
In-Reply-To: <20190219114330.GK4256@calimero.vinschen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SW-Source: 2019-q1/txt/msg00008.txt.bz2


--qpqR4wE1CEr+Roqx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1864

On Feb 19 12:43, Corinna Vinschen wrote:
> On Feb 18 23:09, Yaakov Selkowitz wrote:
> > Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> > ---
> > This is being used more frequently.  Since we don't have Linux capabili=
ties,
> > setuid/setgid is the only condition we have to check.
>=20
> I'm not sure this is right.  The Linux man page claims
>=20
> "Secure execution is required if one of the following conditions was
>  true when the program run by the calling process was loaded: [...]"
>=20
> Do we ever have this situation?  We don't have any capability to make
> real and effective user ID different at process startup.  But from that
> description it seems secure_getenv does not trigger secure mode if the
> process calls seteuid() or setreuid() later in the process.
>=20
> I ran this STC as root under Linux:
>=20
> # cat > sec-getenv-test.c <<EOF
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <errno.h>
> #include <string.h>
> #include <sys/types.h>
> #include <unistd.h>
>=20
> int main ()
> {
>   char *env;
>=20
>   env =3D secure_getenv ("HOME");
>   printf ("vor seteuid: HOME=3D%p <%s>\n", env, env ?: "");
>   if (seteuid (74) < 0)
>     printf ("seteuid: %d <%s>\n", errno, strerror (errno));
>   else
>     {
>       env =3D secure_getenv ("HOME");
>       printf ("nach seteuid: HOME=3D%p <%s>\n", env, env ?: "");
>     }
>   return 0;
> }
> EOF
> # gcc -g -o sec-getenv-test sec-getenv-test.c
> # ./sec-getenv-test
> vor seteuid: HOME=3D0x7fff17a04ea2 </root>
> nach seteuid: HOME=3D0x7fff17a04ea2 </root>

I also tried to run secure_getenv after fork, like this:

  seteuid()
  if (fork () =3D=3D 0)
    env =3D secure_getenv ("HOME");

but it still returns a valid value.

So I wonder if secure_getenv isn't just a synonym for getenv
in our case.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--qpqR4wE1CEr+Roqx
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlxr744ACgkQ9TYGna5E
T6BeiQ/9E8d1OPv1YYmHdb2HxvXXLk6d6vtk8jwPAqMhaF18LKGzKNjwgSh/FzwT
KYl989K2Ls9ZwfRlHj+VlV20y8r9xftWvWjIN7lmVwrkJGa6hJ1SEI/SYgWRcrJ9
h9yPRu4r7bwuqQmV6/8D5WUJDarnzmkvvOuo9pFYqYRA8W6s2Hiamh03l7aPU6nj
O/SkAJEvMTYi152Z2D2lcfrlFd7PX0e5SVUB0cIHi4aUULxdZwrQ2tjpL5TnCYHH
Oc/9Gb+yFwD8qW5sD7DdN92lrZYS7Itfl3bB0trhQTcrP2vKXPeaLnC2mcVwmUQO
wwk5AJQHvBU3sBAfdRdEte0KfyzbGx5hc2IySoB5FyKKpedNeLEwEuWhXyA0kesd
Yy8ueB9XIFhSXdT5E07YLqc62xChJB8H26Yz8pGxOzSK2iOVeTK8393EwK0/mN6O
tHWzvmeoqpfj7IEgQGEQ72EksrZoy8YkStDulsd7OL5DV73jEBb6kUMI0BhaMuod
Qqt7gbHijRfO0WmAzf6UFH0ysSmhRb+xmiA8sw1F4XkFDyyI14bDQA2QlFzKp+e+
lE9/d+UsxLGOUosI0XjalsNjbxz8Cy8Ino0UTXZn8MUbMADQbdtk444XrZWY6+S7
TI7MjL0oyVD9WoQPMNfF7u5UH9TKNtKNcv2mVLxaAXTtXhgVI7M=
=zDYr
-----END PGP SIGNATURE-----

--qpqR4wE1CEr+Roqx--
