Return-Path: <cygwin-patches-return-2769-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28090 invoked by alias); 6 Aug 2002 03:01:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28076 invoked from network); 6 Aug 2002 03:01:33 -0000
Message-ID: <026301c23cf5$eabeebb0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <023c01c23cf4$823d56e0$6132bc3e@BABEL>
Subject: Re: add_handle and malloc
Date: Mon, 05 Aug 2002 20:01:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0260_01C23CFE.4C603B50"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00217.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0260_01C23CFE.4C603B50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 231

Attached is a slightly more thorough version of the previous
patch: this one also removes the `allocated' flag (and associated
code) since it is only used for malloc'ed entries.

This patch supersedes the previous one.

// Conrad


------=_NextPart_000_0260_01C23CFE.4C603B50
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 258

2002-08-06  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* debug.h (handle_list::allocated): Remove field.
	* debug.cc (newh): Don't malloc extra entries.
	(add_handle): Downgrade strace message level.
	(delete_handle): Remove case for `allocated' entries.


------=_NextPart_000_0260_01C23CFE.4C603B50
Content-Type: text/plain;
	name="debug.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="debug.patch.txt"
Content-length: 1979

Index: debug.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/debug.h,v
retrieving revision 1.20
diff -u -r1.20 debug.h
--- debug.h	3 Aug 2002 23:43:42 -0000	1.20
+++ debug.h	6 Aug 2002 02:57:52 -0000
@@ -81,7 +81,6 @@
=20
 struct handle_list
   {
-    BOOL allocated;
     HANDLE h;
     const char *name;
     const char *func;
Index: debug.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/debug.cc,v
retrieving revision 1.38
diff -u -r1.38 debug.cc
--- debug.cc	1 Aug 2002 16:20:31 -0000	1.38
+++ debug.cc	6 Aug 2002 02:57:52 -0000
@@ -101,17 +101,9 @@
=20
   for (hl =3D cygheap->debug.freeh; hl < cygheap->debug.freeh + NFREEH; hl=
++)
     if (hl->name =3D=3D NULL)
-      goto out;
+      return hl;
=20
-  /* All used up??? */
-  if ((hl =3D (handle_list *) malloc (sizeof *hl)) !=3D NULL)
-    {
-      memset (hl, 0, sizeof (*hl));
-      hl->allocated =3D TRUE;
-    }
-
-out:
-  return hl;
+  return NULL;
 }
=20
 /* Add a handle to the linked list of known handles. */
@@ -136,8 +128,8 @@
   if ((hl =3D newh ()) =3D=3D NULL)
     {
       here.unlock ();
-      system_printf ("couldn't allocate memory for %s(%d): %s(%p)",
-		     func, ln, name, h);
+      debug_printf ("couldn't allocate memory for %s(%d): %s(%p)",
+		    func, ln, name, h);
       return;
     }
   hl->h =3D h;
@@ -160,10 +152,7 @@
   handle_list *hnuke =3D hl->next;
   debug_printf ("nuking handle '%s'", hnuke->name);
   hl->next =3D hl->next->next;
-  if (hnuke->allocated)
-    free (hnuke);
-  else
-    memset (hnuke, 0, sizeof (*hnuke));
+  memset (hnuke, 0, sizeof (*hnuke));
 }
=20
 void

------=_NextPart_000_0260_01C23CFE.4C603B50--

