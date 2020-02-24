Return-Path: <cygwin-patches-return-10106-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 84134 invoked by alias); 24 Feb 2020 10:08:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 84117 invoked by uid 89); 24 Feb 2020 10:08:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-119.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=deeper, H*Ad:U*cygwin-patches, actions, fishy
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Feb 2020 10:08:38 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MAwTn-1jGs263EjZ-00BIhS for <cygwin-patches@cygwin.com>; Mon, 24 Feb 2020 11:08:35 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6701EA8276E; Mon, 24 Feb 2020 11:08:35 +0100 (CET)
Date: Mon, 24 Feb 2020 10:08:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix segfault on shared_console_info access.
Message-ID: <20200224100835.GD4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200221191000.1027-1-takashi.yano@nifty.ne.jp> <20200221194333.GZ4092@calimero.vinschen.de> <20200222170123.23099cf86117791daa1722c5@nifty.ne.jp> <20200222223534.82ef1b99a3359106ce35996b@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20200222223534.82ef1b99a3359106ce35996b@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00212.txt


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 4651

On Feb 22 22:35, Takashi Yano wrote:
> On Sat, 22 Feb 2020 17:01:23 +0900
> Takashi Yano wrote:
> > Hi Corinna,
> >=20
> > On Fri, 21 Feb 2020 20:43:33 +0100
> > Corinna Vinschen wrote:
> > > On Feb 22 04:10, Takashi Yano wrote:
> > > > - Accessing shared_console_info accidentaly causes segmentation
> > > >   fault when it is a NULL pointer. The cause of the problem reported
> > > >   in https://cygwin.com/ml/cygwin/2020-02/msg00197.html is this NULL
> > > >   pointer access in request_xterm_mode_output(). This patch fixes
> > > >   the issue.
> > >=20
> > > When does this occur?  [...]
> > This happens when request_xterm_mode_output() is called from
> > close(). Usually, shared_console_info has been set when it is
> > called from close(), buf this happnes in mintty case. Since I
> > was not sure why shared_console_info is NULL in mintty case,
> > I have investigated deeper.
> >=20
> > And I found the following code causes the same situation.
> >=20
> > /* fork-setsid.c: */
> > /* gcc -mwindows fork-setsid.c -o fork-setsid */
> > #include <unistd.h>
> >=20
> > int main()
> > {
> >     if (!fork()) setsid();
> >     return 0;
> > }
> >=20
> > In this case, close() is called via cygheap->close_ctty() from
> > setsid() even though console is not opened.
> >=20
> > Therefore, the following patch also fixes the mintty issue.
> > However, I am not sure this is the right thing.
> > [...]
> This does not work as expected. How about this one?
>=20
> diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> index 4652de929..138b7a1eb 100644
> --- a/winsup/cygwin/dtable.cc
> +++ b/winsup/cygwin/dtable.cc
> @@ -937,6 +937,7 @@ dtable::fixup_after_exec ()
>  void
>  dtable::fixup_after_fork (HANDLE parent)
>  {
> +  bool ctty_opened =3D false;
>    fhandler_base *fh;
>    for (size_t i =3D 0; i < size; i++)
>      if ((fh =3D fds[i]) !=3D NULL)
> @@ -957,7 +958,11 @@ dtable::fixup_after_fork (HANDLE parent)
>  	  SetStdHandle (std_consts[i], fh->get_handle ());
>  	else if (i <=3D 2)
>  	  SetStdHandle (std_consts[i], fh->get_output_handle ());
> +	if (cygheap->ctty =3D=3D fh->archetype)
> +	  ctty_opened =3D true;
>        }
> +  if (!ctty_opened)
> +    cygheap->ctty =3D NULL;
>  }

I'm not sure this is safe, archetype can be NULL.

I debugged this situation as well and what strikes me as weird is
that in fhandler_console::close, there are two calls to
request_xterm_mode_output(false).  The first one is only called if
shared_console_info is !=3D NULL, the other one is always called if
wincap.has_con_24bit_colors().  This looks a bit fishy.  Not only
the shared_console_info test is missing, but also the con_is_legacy
test.

What about something like this:

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_con=
sole.cc
index 42040a97162e..edb71fffe48f 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -1159,18 +1159,17 @@ fhandler_console::close ()
=20
   acquire_output_mutex (INFINITE);
=20
-  if (shared_console_info && myself->pid =3D=3D con.owner &&
-      wincap.has_con_24bit_colors () && !con_is_legacy)
-    request_xterm_mode_output (false);
-
-  /* Restore console mode if this is the last closure. */
-  OBJECT_BASIC_INFORMATION obi;
-  NTSTATUS status;
-  status =3D NtQueryObject (get_handle (), ObjectBasicInformation,
-			  &obi, sizeof obi, NULL);
-  if (NT_SUCCESS (status) && obi.HandleCount =3D=3D 1)
-    if (wincap.has_con_24bit_colors ())
-      request_xterm_mode_output (false);
+  if (shared_console_info && !con_is_legacy && wincap.has_con_24bit_colors=
 ())
+    {
+      /* Restore console mode if this is the last closure. */
+      OBJECT_BASIC_INFORMATION obi;
+      NTSTATUS status;
+      status =3D NtQueryObject (get_handle (), ObjectBasicInformation,
+			      &obi, sizeof obi, NULL);
+      if ((NT_SUCCESS (status) && obi.HandleCount =3D=3D 1)
+	  || myself->pid =3D=3D con.owner)
+	request_xterm_mode_output (false);
+    }
=20
   release_output_mutex ();
=20
Btw., are you testing the console with black background?  I'm asking
because I'm using the console with grey background and black characters,
and I'm always seeing artifacts when using vim in xterm mode.

E.g., open vim on the fork-setsid.c source in the console in xterm
mode.  Move the cursor to the beginning of the word `setsid'.  Now
press the three chars

  c h <CR>

this moves the setsid call to the next line.  But it also adds
black background after `setsid();'.  Simiar further actions always
create black background artifacts.

Is there anything we can do against that?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5ToKMACgkQ9TYGna5E
T6BjIw/+KFP/2+MO8L1L5ne7+jsr7W/A3UApRamVML5PgHrQ5klDTWLFP2LgTi1i
J6STsxImxgXTMBfyIYBMbVp2pmhH04rDCpigGYrU00hTbvMYbqasYAas0DHI1qEi
PJKKb26H0R30WO5hKJgVChEBHVk3+71iPsGqmcbbe/HeCylGKpdljC852jKInJ8D
yGGSgmRUrIoKGv9pi3M/sWxcN63RIAWcyPSHyXn5q0qfrdT8ODg9EMZ9BsU+FF62
13jgtx33TRPC4UbDUuC41yi/ZE0yLazN1CMOP5CKe8oJwUIc1NttiSsXpI8o6jgC
yTzi9zzfRWWX+v7/ZgqYUV6zeSJGFPonKMtcLtX6WFU5PxC5rMQ7C7+ZJiD/Xcge
Rznd7HKAeyZV6P3sOejZ8ytpQrQ1kyiq2lai05062xu19viv1Zb74UBcPZvmgjSM
l7SGbFCKbnQxty1581RM1jEFDbZIKjkp6PyTxJ4aylhWOKmMkzLrFiRfyN8KZC6t
ErHF4hN/mkT7NLlcS82MFh5G4VBfF/o+b6r4iU7alUB6rvqC7VItvgvPo5hYvobB
eHPenuC/bPZPh7Q2afKiFG4adHYWQTAbq62enQwWtGnlnWOJxMPG3l+XMONsG0WD
IyMRiHo5KpYASiJPzqUmeM4UHUNLc19vomV+igltAQTRl5Nr61o=
=t4KV
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
