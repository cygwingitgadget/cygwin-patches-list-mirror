Return-Path: <cygwin-patches-return-2768-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22368 invoked by alias); 6 Aug 2002 02:51:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22353 invoked from network); 6 Aug 2002 02:51:29 -0000
Message-ID: <023c01c23cf4$823d56e0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: add_handle and malloc
Date: Mon, 05 Aug 2002 19:51:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0239_01C23CFC.E3AF3210"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00216.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0239_01C23CFC.E3AF3210
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 528

The add_handle in "debug.cc" code still malloc's entries once the
free list is exhausted, which doesn't work very well on fork now
that the entries are (otherwise) in cygheap.  I've attached a
patch that gets rid of the malloc, so once the free list is
exhausted, new handles simply aren't added to the list.

Isn't it always the way: you write a test program for one thing
and you find something else entirely.  My real problem is that
something's leaking handles, so now it's back to that original
issue.

Cheers,

// Conrad


------=_NextPart_000_0239_01C23CFC.E3AF3210
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 152

2002-08-06  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* debug.cc (newh): Don't malloc extra entries.
	(add_handle): Downgrade strace message level.


------=_NextPart_000_0239_01C23CFC.E3AF3210
Content-Type: text/plain;
	name="debug.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="debug.patch.txt"
Content-length: 1166

Index: debug.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/debug.cc,v
retrieving revision 1.38
diff -u -r1.38 debug.cc
--- debug.cc	1 Aug 2002 16:20:31 -0000	1.38
+++ debug.cc	6 Aug 2002 02:41:50 -0000
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

------=_NextPart_000_0239_01C23CFC.E3AF3210--

