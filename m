Return-Path: <cygwin-patches-return-8702-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73991 invoked by alias); 28 Feb 2017 11:48:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73943 invoked by uid 89); 28 Feb 2017 11:48:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=H*c:NHxtPHrt, snip, H*UA:Outlook, H*x:Outlook
X-HELO: mtaout02-winn.ispmail.ntl.com
Received: from mtaout02-winn.ispmail.ntl.com (HELO mtaout02-winn.ispmail.ntl.com) (81.103.221.48) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Feb 2017 11:48:32 +0000
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])          by mtaout02-winn.ispmail.ntl.com          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP          id <20170228114829.VJDJ23018.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>          for <cygwin-patches@cygwin.com>; Tue, 28 Feb 2017 11:48:29 +0000
Received: from Altus ([213.105.212.114]) by aamtaout02-winn.ispmail.ntl.com          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP          id <20170228114829.RFCH27335.aamtaout02-winn.ispmail.ntl.com@Altus>          for <cygwin-patches@cygwin.com>; Tue, 28 Feb 2017 11:48:29 +0000
From: "David Allsopp" <David.Allsopp@cl.cam.ac.uk>
To: <cygwin-patches@cygwin.com>
References: <000001d28f84$0fce9ea0$2f6bdbe0$@cl.cam.ac.uk> <20170227104625.GA3536@calimero.vinschen.de> <000301d2911c$d89a0510$89ce0f30$@cl.cam.ac.uk> <20170228102913.GB3536@calimero.vinschen.de>
In-Reply-To: <20170228102913.GB3536@calimero.vinschen.de>
Subject: RE: [PATCH] Preserve order of dlopen'd modules in dll_list::topsort
Date: Tue, 28 Feb 2017 11:48:00 -0000
Message-ID: <000301d291b8$94dd3260$be979720$@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;	boundary="----=_NextPart_000_0004_01D291B8.94DDCEA0"
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00043.txt.bz2

This is a multipart message in MIME format.

------=_NextPart_000_0004_01D291B8.94DDCEA0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-length: 2214

Hi Corinna,

Thanks for the feedback!

Corinna Vinschen wrote:
> Hi David,
>=20
> thanks for the new patch.
>=20
> On Feb 27 17:13, David Allsopp wrote:
> > Corinna Vinschen wrote:
> > > On Feb 25 16:27, David Allsopp wrote:
> > > > This patch (below - I hope I have managed to format this email
> > > > correctly) alters the behaviour of dll_list::topsort to preserve
> > > > the order of dlopen'd units.
> > > > [...]
> > > > This patch is licensed under 2-clause BSD as per
> > > > winsup/CONTRIBUTORS, Copyright (c) 2017, MetaStack Solutions Ltd.
>=20
> Do you really want to make it (c) MetaStack?

Oh, I was assuming that there would just be an implied mapping! Simple is b=
est (MetaStack is just me, anyway!), so the previous patch and this fixup m=
ay be merged as my personal copyright, yes.

<snip>

> > > - Last but not least.  You add code to topsort so the loaded DLLs
> > >   are handled first.  The subsequent code is untouched.  However,
> > >   shouldn't the next loop then restrict calling populate_deps to the
> > >   linked DLLs only, at least for performance?
> >
> > Oops :$ That's an artefact of the "story" of the patch's development.
> > As it happens, the first dlopen'd DLL would have been initialised in
> > the second loop, not the first, but the presence of two loops like
> > that was indeed mostly inefficient. I've kept the original one as a
> > "fast path" for the case of no dlopen'd DLLs, though I don't know if
> > that's a worthwhile optimisation.
>=20
> Well, interesting point.  Basically your new code is a drop-in
> replacement, except for the fact that it always calls an extra
> cmalloc/cfree.  However, this is only required if loaded_dlls > 0 so I
> think we may get away with removing the old loop with a simple tweak to
> your new one:
>=20
>   dll** dlopen_deps =3D NULL;
>   if (loaded_dlls > 0)
>     dlopen_deps =3D (dll**) cmalloc (HEAP_2_DLL, maxdeps*sizeof (dll*));
>   while ((d =3D d->next))
>     {
>       [...]
>     }
>   if (dlopen_deps)
>     cfree (dlopen_deps);
>=20
> Do you want to tweak your patch accordingly?

That's much neater - attached is a fixup (which obviously looks a lot clear=
er with git diff --ignore-all-space)

All best,


David

------=_NextPart_000_0004_01D291B8.94DDCEA0
Content-Type: application/octet-stream;
	name="0001-Fixup-8607cf.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Fixup-8607cf.patch"
Content-length: 4088

From 67173b29ff090d2aae495d5db1b4f48167443483 Mon Sep 17 00:00:00 2001=0A=
From: David Allsopp <david.allsopp@metastack.com>=0A=
Date: Tue, 28 Feb 2017 11:42:20 +0000=0A=
Subject: [PATCH] Fixup 8607cf=0A=
=0A=
Signed-off-by: David Allsopp <david.allsopp@metastack.com>=0A=
---=0A=
 winsup/cygwin/dll_init.cc | 63 ++++++++++++++++++++++---------------------=
----=0A=
 1 file changed, 30 insertions(+), 33 deletions(-)=0A=
=0A=
diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc=0A=
index e3a710a..0fd65a6 100644=0A=
--- a/winsup/cygwin/dll_init.cc=0A=
+++ b/winsup/cygwin/dll_init.cc=0A=
@@ -313,49 +313,46 @@ dll_list::topsort ()=0A=
=20=0A=
   /* make sure we have all the deps available */=0A=
   dll* d =3D &start;=0A=
+  dll** dlopen_deps =3D NULL;=0A=
+  long maxdeps =3D 4;=0A=
+  long dlopen_ndeps =3D 0;=0A=
+=0A=
   if (loaded_dlls > 0)=0A=
+    dlopen_deps =3D (dll**) cmalloc (HEAP_2_DLL, maxdeps*sizeof (dll*));=
=0A=
+=0A=
+  while ((d =3D d->next))=0A=
     {=0A=
-      /* Ensure that all dlopen'd DLLs depend on previously dlopen'd DLLs.=
 This=0A=
-         prevents topsort from reversing the order of dlopen'd DLLs on cal=
ls to=0A=
-         fork. */=0A=
-      long maxdeps =3D 4;=0A=
-      long dlopen_ndeps =3D 0;=0A=
-      dll** dlopen_deps =3D (dll**) cmalloc (HEAP_2_DLL, maxdeps*sizeof (d=
ll*));=0A=
-      while ((d =3D d->next))=0A=
+      if (!d->ndeps)=0A=
         {=0A=
-          if (!d->ndeps)=0A=
+          /* Ensure that all dlopen'd DLLs depend on previously dlopen'd D=
LLs.=0A=
+             This prevents topsort from reversing the order of dlopen'd DL=
Ls on=0A=
+             calls to fork. */=0A=
+          if (d->type =3D=3D DLL_LOAD)=0A=
             {=0A=
-              if (d->type =3D=3D DLL_LOAD)=0A=
+              /* Initialise d->deps with all previously dlopen'd DLLs. */=
=0A=
+              if (dlopen_ndeps)=0A=
                 {=0A=
-                  /* Initialise d->deps with all previously dlopen'd DLLs.=
 */=0A=
-                  if (dlopen_ndeps)=0A=
-                    {=0A=
-                      d->ndeps =3D dlopen_ndeps;=0A=
-                      d->deps =3D (dll**) cmalloc (HEAP_2_DLL,=0A=
-                                                 dlopen_ndeps*sizeof (dll*=
));=0A=
-                      memcpy (d->deps, dlopen_deps, dlopen_ndeps*sizeof (d=
ll*));=0A=
-                    }=0A=
-                  /* Add this DLL to the list of previously dlopen'd DLLs.=
 */=0A=
-                  if (dlopen_ndeps >=3D maxdeps)=0A=
-                    {=0A=
-                      maxdeps =3D 2*(1+maxdeps);=0A=
-                      dlopen_deps =3D (dll**) crealloc(dlopen_deps,=0A=
-                                                     maxdeps*sizeof (dll*)=
);=0A=
-                    }=0A=
-                  dlopen_deps[dlopen_ndeps++] =3D d;=0A=
+                  d->ndeps =3D dlopen_ndeps;=0A=
+                  d->deps =3D (dll**) cmalloc (HEAP_2_DLL,=0A=
+                                             dlopen_ndeps*sizeof (dll*));=
=0A=
+                  memcpy (d->deps, dlopen_deps, dlopen_ndeps*sizeof (dll*)=
);=0A=
                 }=0A=
-              populate_deps (d);=0A=
+              /* Add this DLL to the list of previously dlopen'd DLLs. */=
=0A=
+              if (dlopen_ndeps >=3D maxdeps)=0A=
+                {=0A=
+                  maxdeps =3D 2*(1+maxdeps);=0A=
+                  dlopen_deps =3D (dll**) crealloc(dlopen_deps,=0A=
+                                                 maxdeps*sizeof (dll*));=
=0A=
+                }=0A=
+              dlopen_deps[dlopen_ndeps++] =3D d;=0A=
             }=0A=
-        }=0A=
-      cfree(dlopen_deps);=0A=
-    }=0A=
-  else=0A=
-    {=0A=
-      while ((d =3D d->next))=0A=
-        if (!d->ndeps)=0A=
           populate_deps (d);=0A=
+        }=0A=
     }=0A=
=20=0A=
+  if (loaded_dlls > 0)=0A=
+    cfree(dlopen_deps);=0A=
+=0A=
   /* unlink head and tail pointers so the sort can rebuild the list */=0A=
   d =3D start.next;=0A=
   start.next =3D end =3D NULL;=0A=
--=20=0A=
2.10.2.windows.1=0A=
=0A=

------=_NextPart_000_0004_01D291B8.94DDCEA0--
