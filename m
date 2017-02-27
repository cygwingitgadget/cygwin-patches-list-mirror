Return-Path: <cygwin-patches-return-8700-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7868 invoked by alias); 27 Feb 2017 17:13:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7849 invoked by uid 89); 27 Feb 2017 17:13:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=H*c:NHxtPHrt, H*UA:Outlook, H*x:Outlook, H*UA:Microsoft
X-HELO: mtaout04-winn.ispmail.ntl.com
Received: from mtaout04-winn.ispmail.ntl.com (HELO mtaout04-winn.ispmail.ntl.com) (81.103.221.52) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Feb 2017 17:13:45 +0000
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])          by mtaout04-winn.ispmail.ntl.com          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP          id <20170227171342.GNKH28357.mtaout04-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>          for <cygwin-patches@cygwin.com>; Mon, 27 Feb 2017 17:13:42 +0000
Received: from Altus ([213.105.212.114]) by aamtaout04-winn.ispmail.ntl.com          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP          id <20170227171342.MAMX2125.aamtaout04-winn.ispmail.ntl.com@Altus>          for <cygwin-patches@cygwin.com>; Mon, 27 Feb 2017 17:13:42 +0000
From: "David Allsopp" <David.Allsopp@cl.cam.ac.uk>
To: <cygwin-patches@cygwin.com>
References: <000001d28f84$0fce9ea0$2f6bdbe0$@cl.cam.ac.uk> <20170227104625.GA3536@calimero.vinschen.de>
In-Reply-To: <20170227104625.GA3536@calimero.vinschen.de>
Subject: RE: [PATCH] Preserve order of dlopen'd modules in dll_list::topsort
Date: Mon, 27 Feb 2017 17:13:00 -0000
Message-ID: <000301d2911c$d89a0510$89ce0f30$@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;	boundary="----=_NextPart_000_0004_01D2911C.D89A7A40"
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00041.txt.bz2

This is a multipart message in MIME format.

------=_NextPart_000_0004_01D2911C.D89A7A40
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-length: 4263

Hi Corinna,

Corinna Vinschen wrote:
> Hi David,
>=20
> On Feb 25 16:27, David Allsopp wrote:
> > This patch (below - I hope I have managed to format this email
> > correctly) alters the behaviour of dll_list::topsort to preserve the
> > order of dlopen'd units.
> >
> > The load order of unrelated DLLs is reversed every time fork is
> > called, since dll_list::topsort finds the tail of the list and then
> > unwinds to reinsert items. My change takes advantage of what should be
> > undefined behaviour in dll_list::populate_deps (ndeps non-zero and
> > ndeps and deps not
> > initialised) to allow the deps field to be initialised prior to the
> > call and appended to, rather than overwritten.
> >
> > All DLLs which have been dlopen'd have their deps list initialised
> > with the list of all previously dlopen'd units. These extra
> > dependencies mean that the unwind preserves the order of dlopen'd units.
> >
> > The motivation for this is the FlexDLL linker used in OCaml. The
> > FlexDLL linker allows a dlopen'd unit to refer to symbols in
> > previously dlopen'd units and it resolves these symbols in DllMain
> > before anything else has initialised (including the Cygwin DLL). This
> > means that dependencies may exist between dlopen'd units (which the
> > OCaml runtime system understands) but which Windows is unaware of.
> > During fork, the process-level table which FlexDLL uses to get the
> > symbol table of each DLL is copied over but because the load order of
> > dlopen'd DLLs is reversed, it is possible for FlexDLL to attempt to
> > access memory in the DLL before it has been loaded and hence it fails
> > with an access violation. Because the list is reversed on each call to
> > fork, it means that a subsequent call to fork puts the DLLs back into
> > the correct order, hence "even" invocations of fork work!
> >
> > An interesting side-effect is that this only occurs if the DLLs load
> > at their preferred base address - if they have to be rebased, then
> > FlexDLL works because at the time that the dependent unit is loaded
> > out of order, there is still in memory the "dummy"
> > DONT_RESOLVE_DLL_REFERENCES version of the dependency which, as it
> > happens, will contain the correct symbol table in the data section.
> > For my tests, this initially appeared to be an x86-only problem, but
> > that was only because the two DLLs on x64 should have been rebased.
> >
> > I'm very happy to include the complete detail for this and, for the
> > extremely keen, the relevant Git branch in OCaml which demonstrates
> > this problem. Given the way in which FlexDLL operates, I would contend
> > that this is a sensible change of behaviour for the Cygwin DLL, though
> > not a bug fix.
> > I'd be extremely happy to see this patch integrated, as the workaround
> > necessary in FlexDLL to support Cygwin's fork is horrible (and
> > non-transparent to the library user).
> >
> > This patch is licensed under 2-clause BSD as per winsup/CONTRIBUTORS,
> > Copyright (c) 2017, MetaStack Solutions Ltd.
>=20
> First of all, I think this makes perfect sense.  I just have a few
> questions in terms of the patch itself.
>=20
> - Your browser inserts undesired line breaks, so the patch is broken.
>   Can you please resend the `git format-patch' output as attachment?

Darn - sorry about that (it's the first time I'd tried to send a format-pat=
ch, rather than as a PR). Patch attached.

> - While you're at it, please reformat your patch so the line length
>   is not longer than 80 chars.

Done - sorry, I'd inferred a longer length from a few other longer lines!

> - Last but not least.  You add code to topsort so the loaded DLLs
>   are handled first.  The subsequent code is untouched.  However,
>   shouldn't the next loop then restrict calling populate_deps to the
>   linked DLLs only, at least for performance?

Oops :$ That's an artefact of the "story" of the patch's development. As it=
 happens, the first dlopen'd DLL would have been initialised in the second =
loop, not the first, but the presence of two loops like that was indeed mos=
tly inefficient. I've kept the original one as a "fast path" for the case o=
f no dlopen'd DLLs, though I don't know if that's a worthwhile optimisation=
.=20

All best,


David

------=_NextPart_000_0004_01D2911C.D89A7A40
Content-Type: application/octet-stream;
	name="0001-Preserve-order-of-dlopen-d-modules-in-dll_list-topso.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Preserve-order-of-dlopen-d-modules-in-dll_list-topso.patch"
Content-length: 4085

From 8607cf5dad47de078ef7a74676386e9eb981c2a8 Mon Sep 17 00:00:00 2001=0A=
From: David Allsopp <david.allsopp@metastack.com>=0A=
Date: Mon, 27 Feb 2017 17:06:34 +0000=0A=
Subject: [PATCH] Preserve order of dlopen'd modules in dll_list::topsort=0A=
=0A=
Signed-off-by: David Allsopp <david.allsopp@metastack.com>=0A=
---=0A=
 winsup/cygwin/dll_init.cc   | 58 ++++++++++++++++++++++++++++++++++++++++-=
----=0A=
 winsup/cygwin/release/2.7.1 |  2 ++=0A=
 2 files changed, 54 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc=0A=
index 0fe5714..e3a710a 100644=0A=
--- a/winsup/cygwin/dll_init.cc=0A=
+++ b/winsup/cygwin/dll_init.cc=0A=
@@ -271,9 +271,16 @@ void dll_list::populate_deps (dll* d)=0A=
   PIMAGE_DATA_DIRECTORY dd =3D pef->idata_dir (IMAGE_DIRECTORY_ENTRY_IMPOR=
T);=0A=
   /* Annoyance: calling crealloc with a NULL pointer will use the=0A=
      wrong heap and crash, so we have to replicate some code */=0A=
-  long maxdeps =3D 4;=0A=
-  d->deps =3D (dll**) cmalloc (HEAP_2_DLL, maxdeps*sizeof (dll*));=0A=
-  d->ndeps =3D 0;=0A=
+  long maxdeps;=0A=
+  if (!d->ndeps)=0A=
+    {=0A=
+      maxdeps =3D 4;=0A=
+      d->deps =3D (dll**) cmalloc (HEAP_2_DLL, maxdeps*sizeof (dll*));=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      maxdeps =3D d->ndeps;=0A=
+    }=0A=
   for (PIMAGE_IMPORT_DESCRIPTOR id=3D=0A=
 	(PIMAGE_IMPORT_DESCRIPTOR) pef->rva (dd->VirtualAddress);=0A=
       dd->Size && id->Name;=0A=
@@ -306,9 +313,48 @@ dll_list::topsort ()=0A=
=20=0A=
   /* make sure we have all the deps available */=0A=
   dll* d =3D &start;=0A=
-  while ((d =3D d->next))=0A=
-    if (!d->ndeps)=0A=
-      populate_deps (d);=0A=
+  if (loaded_dlls > 0)=0A=
+    {=0A=
+      /* Ensure that all dlopen'd DLLs depend on previously dlopen'd DLLs.=
 This=0A=
+         prevents topsort from reversing the order of dlopen'd DLLs on cal=
ls to=0A=
+         fork. */=0A=
+      long maxdeps =3D 4;=0A=
+      long dlopen_ndeps =3D 0;=0A=
+      dll** dlopen_deps =3D (dll**) cmalloc (HEAP_2_DLL, maxdeps*sizeof (d=
ll*));=0A=
+      while ((d =3D d->next))=0A=
+        {=0A=
+          if (!d->ndeps)=0A=
+            {=0A=
+              if (d->type =3D=3D DLL_LOAD)=0A=
+                {=0A=
+                  /* Initialise d->deps with all previously dlopen'd DLLs.=
 */=0A=
+                  if (dlopen_ndeps)=0A=
+                    {=0A=
+                      d->ndeps =3D dlopen_ndeps;=0A=
+                      d->deps =3D (dll**) cmalloc (HEAP_2_DLL,=0A=
+                                                 dlopen_ndeps*sizeof (dll*=
));=0A=
+                      memcpy (d->deps, dlopen_deps, dlopen_ndeps*sizeof (d=
ll*));=0A=
+                    }=0A=
+                  /* Add this DLL to the list of previously dlopen'd DLLs.=
 */=0A=
+                  if (dlopen_ndeps >=3D maxdeps)=0A=
+                    {=0A=
+                      maxdeps =3D 2*(1+maxdeps);=0A=
+                      dlopen_deps =3D (dll**) crealloc(dlopen_deps,=0A=
+                                                     maxdeps*sizeof (dll*)=
);=0A=
+                    }=0A=
+                  dlopen_deps[dlopen_ndeps++] =3D d;=0A=
+                }=0A=
+              populate_deps (d);=0A=
+            }=0A=
+        }=0A=
+      cfree(dlopen_deps);=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      while ((d =3D d->next))=0A=
+        if (!d->ndeps)=0A=
+          populate_deps (d);=0A=
+    }=0A=
=20=0A=
   /* unlink head and tail pointers so the sort can rebuild the list */=0A=
   d =3D start.next;=0A=
diff --git a/winsup/cygwin/release/2.7.1 b/winsup/cygwin/release/2.7.1=0A=
index 54e1100..411a0ae 100644=0A=
--- a/winsup/cygwin/release/2.7.1=0A=
+++ b/winsup/cygwin/release/2.7.1=0A=
@@ -8,6 +8,8 @@ What changed:=0A=
 - cygcheck and strace now always generate output with Unix LF line endings=
,=0A=
   rather than with DOS/Windows CR LF line endings.=0A=
=20=0A=
+- fork now preserves the load order of unrelated dlopen'd modules.=0A=
+=0A=
=20=0A=
 Bug Fixes=0A=
 ---------=0A=
--=20=0A=
2.10.2.windows.1=0A=
=0A=

------=_NextPart_000_0004_01D2911C.D89A7A40--
