Return-Path: <cygwin-patches-return-9197-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 122088 invoked by alias); 19 Feb 2019 11:43:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 122074 invoked by uid 89); 19 Feb 2019 11:43:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.9 required=5.0 tests=BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=nach, Secure, vor, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 19 Feb 2019 11:43:44 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MmlCY-1hMq2P2VkM-00jtJs for <cygwin-patches@cygwin.com>; Tue, 19 Feb 2019 12:43:31 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C2378A80857; Tue, 19 Feb 2019 12:43:30 +0100 (CET)
Date: Tue, 19 Feb 2019 11:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add secure_getenv
Message-ID: <20190219114330.GK4256@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190219050950.19116-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="a6YTfLRor63AaheO"
Content-Disposition: inline
In-Reply-To: <20190219050950.19116-1-yselkowi@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SW-Source: 2019-q1/txt/msg00007.txt.bz2


--a6YTfLRor63AaheO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1472

On Feb 18 23:09, Yaakov Selkowitz wrote:
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
> This is being used more frequently.  Since we don't have Linux capabiliti=
es,
> setuid/setgid is the only condition we have to check.

I'm not sure this is right.  The Linux man page claims

"Secure execution is required if one of the following conditions was
 true when the program run by the calling process was loaded: [...]"

Do we ever have this situation?  We don't have any capability to make
real and effective user ID different at process startup.  But from that
description it seems secure_getenv does not trigger secure mode if the
process calls seteuid() or setreuid() later in the process.

I ran this STC as root under Linux:

# cat > sec-getenv-test.c <<EOF
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

int main ()
{
  char *env;

  env =3D secure_getenv ("HOME");
  printf ("vor seteuid: HOME=3D%p <%s>\n", env, env ?: "");
  if (seteuid (74) < 0)
    printf ("seteuid: %d <%s>\n", errno, strerror (errno));
  else
    {
      env =3D secure_getenv ("HOME");
      printf ("nach seteuid: HOME=3D%p <%s>\n", env, env ?: "");
    }
  return 0;
}
EOF
# gcc -g -o sec-getenv-test sec-getenv-test.c
# ./sec-getenv-test
vor seteuid: HOME=3D0x7fff17a04ea2 </root>
nach seteuid: HOME=3D0x7fff17a04ea2 </root>


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--a6YTfLRor63AaheO
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlxr6+IACgkQ9TYGna5E
T6CLjhAAkcDphhfhIu0NBaFHUbeci/mjcX64ntq3zb9f4p9AEu0B9BYe5mkmUhQk
tFz3f7Fjm/qPUhi8IiQNfYqIrBxjEYEi2Ih8Fyq2Z6bCeekPTM+/QnuYLhqUi+qH
XL9n09hkg7aTK81fe8vD6y4n/8x6SJeN80Tez5okbklYVO8dRdWnu4Hv7Hf0Ot7F
WAHQ3yuzY2ns2gEzD6QJAKyjY1A4lL11GdZjoQi85VEfMbrCDYsTYbbFg5H5GM8b
So4eAzio5aueEHRCSI3W07SALXAtZi6/7ycEHuCqMn0du5/mXUmQpLaz1eeaw3G2
qgbFqOvxlS5SUD76sxDXUb01PGbPesAH9hQzMx/+UCy8C1BQ8N5vQj8jplpbHRwn
bSEpp69gGs77jBUFmM2UrDMRXr6ZZvWdHI74oDv1Jj9+kyV3u/CD7giLrckttyYT
IbnzTsl37KFVYyFhOV84VcGvQu5L/Tt1e09pjnPHS/KNsmXsbARoKjgRONA6Nxh5
1DcwcqRgNL8+micMy7zMlRqikp+N6xbsWMVnPHYkIclJPINgJm6S9SLaF7n85QiJ
qzNZP+9XCKbkOpb4YYMkFbB9idRP6kB7AHni3ImhTQTRwE7f8nM6e0wJWI0hoouY
mei21fG2vP+cjMGLMDtUoO4r9EptFwdZAjC38gTLNiQtzmEnXi0=
=kjSg
-----END PGP SIGNATURE-----

--a6YTfLRor63AaheO--
