Return-Path: <cygwin-patches-return-7912-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22932 invoked by alias); 4 Dec 2013 09:32:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22916 invoked by uid 89); 4 Dec 2013 09:32:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.5 required=5.0 tests=AWL,BAYES_50,RDNS_NONE,URIBL_BLOCKED autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from Unknown (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Dec 2013 09:32:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 41EEC1A0677; Wed,  4 Dec 2013 10:32:38 +0100 (CET)
Date: Wed, 04 Dec 2013 09:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix off-by-one in dup2
Message-ID: <20131204093238.GA28314@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52437121.1070507@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <52437121.1070507@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q4/txt/msg00008.txt.bz2


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2038

Hi guys,


I'm not quite sure yet *why* this happens, but this change in
dtable::find_unused_handle...

On Sep 25 17:26, Eric Blake wrote:
> [...]
> diff --git i/winsup/cygwin/dtable.cc w/winsup/cygwin/dtable.cc
> index 2501a26..c2982a8 100644
> --- i/winsup/cygwin/dtable.cc
> +++ w/winsup/cygwin/dtable.cc
> @@ -233,7 +233,7 @@ dtable::find_unused_handle (int start)
>  	if (fds[i] =3D=3D NULL)
>  	  return i;
>      }
> -  while (extend (NOFILE_INCR));
> +  while (extend (MAX (NOFILE_INCR, start - size)));
>    return -1;
>  }

...introduced the problem reported in
http://cygwin.com/ml/cygwin/2013-12/msg00072.html

The problem is still present in the current sources.

If I apply this change...

Index: dtable.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
retrieving revision 1.275
diff -u -p -r1.275 dtable.cc
--- dtable.cc	1 Dec 2013 19:17:56 -0000	1.275
+++ dtable.cc	4 Dec 2013 09:26:01 -0000
@@ -223,7 +223,8 @@ dtable::delete_archetype (fhandler_base=20
 int
 dtable::find_unused_handle (size_t start)
 {
-  size_t extendby =3D (start >=3D size) ? 1 + start - size : NOFILE_INCR;
+  //size_t extendby =3D (start >=3D size) ? 1 + start - size : NOFILE_INCR;
+  size_t extendby =3D NOFILE_INCR;
=20
   /* This do loop should only ever execute twice. */
   int res =3D -1;


..., which essentially reverts the original change from Eric, the
problem is fixed.

Off the top of my head I don't understand why Eric's as well as cgf's
solution (which are not equivalent) both introduce this problem, but
always using NOFILE_INCR works, so I publish it here for discussion.

I'm off for a doc appointment now, maybe I have some clue while sitting
in the anteroom.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-length: 836

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSnva2AAoJEPU2Bp2uRE+gVGUP/iusJg4NdmM7NtW7QFWced4/
sQaPGdVwdIN15/C0qikIT26fkhMpzUYPs8kx4ZHR9T7ZSwuFXD5f3mEk+viGikR9
/r2Ml4X62cjUQ7fHlU+EfywrSE5D3wU1YOu4qcmFF4vkml6I1B5X9MUvA5dtzaBb
T4sKtUWjwRqe+TDFdxzjT2HeyuhbQvQeOBipHvvTIcggju9bp8JTaBWggO06Nnu/
OeSMyDrH37URHuKPt+AqfE3tl8mWD/8S+Y0PNoqPcpYpcQtofTWat4yeZR27ayH7
JK6JyAOaof7obYfdPNBN3MznZ+O7oqwU56QLf20luo8Ri1gidJ19/yNqLF9NAnaV
XRNhGGYCnolu58qOkBY6sEgnCUlRZ99EYlrwlQ3oZjB2rB5/bC1I4dL9VCWaKboL
IDXqSiWa9xXrABvtcSLY66l0Nes62NbL45B3rAQy7nQc8/p5I5RPUun4hXsNJSST
aF12a0yhxXJOwMiTAYoosVC0N5RNERCh1IlVipjNcTe2Uu0BAXPCWUGGmShLUeQc
FW9gCUsex8Km7tKmBz6sqTNxICRQzQLuj+DYeqPQjfAte/AOf+1+QfJrgNczU5PA
xlBnpNrVBzJwezh6I69zbyqTNuYWsX8zVPVW1GhJQIuEEBK8AarvPW/ccCIaYlCy
D/erMMhQwaAC6FnRCkhG
=WPiJ
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
