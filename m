Return-Path: <cygwin-patches-return-2776-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18083 invoked by alias); 6 Aug 2002 18:05:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18061 invoked from network); 6 Aug 2002 18:05:50 -0000
Message-ID: <01e501c23d74$400b2c90$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: init_cheap and _csbrk
Date: Tue, 06 Aug 2002 11:05:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01E2_01C23D7C.A15841B0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00224.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_01E2_01C23D7C.A15841B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 691

I stumbled over this last night but I thought it better to wait
until I'd had both sleep and pizza before posting it off :-)

The _csbrk function, from "cygheap.cc", is rounding up the first
allocation to a multiple of a page size, which seems unnecessary
since VirtualAlloc does that anyway (i.e., if you reserve/commit a
single byte on a page, it reserves/commits the whole page).  More
importantly, it can't be right to add the allocation request size
to the return value for the first allocation (except that the
first "allocation" is probably always 0, so actually it's
alright).

And while I was there I moved one initialization about for the
usual "aesthetic" reasons :-)

// Conrad


------=_NextPart_000_01E2_01C23D7C.A15841B0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 281

2002-08-06  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* cygheap.cc (init_cheap): Make initial setting of cygheap_max here.
	(_csbrk): Move initial setting of cygheap_max to init_cheap.
	Don't round allocation to a page boundary in recursive call and
	correct the return value.


------=_NextPart_000_01E2_01C23D7C.A15841B0
Content-Type: text/plain;
	name="cygheap.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygheap.patch.txt"
Content-length: 1035

Index: cygheap.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.cc,v
retrieving revision 1.66
diff -u -r1.66 cygheap.cc
--- cygheap.cc	30 Jul 2002 01:31:51 -0000	1.66
+++ cygheap.cc	6 Aug 2002 17:54:50 -0000
@@ -61,6 +61,7 @@
       api_fatal ("AllocationBase %p, BaseAddress %p, RegionSize %p, State =
%p\n",
 		 m.AllocationBase, m.BaseAddress, m.RegionSize, m.State);
     }
+  cygheap_max =3D cygheap;
 }
=20
 static void dup_now (void *, child_info *, unsigned) __attribute__ ((regpa=
rm(3)));
@@ -176,9 +177,8 @@
   if (!cygheap)
     {
       init_cheap ();
-      cygheap_max =3D cygheap;
-      (void) _csbrk ((int) pagetrunc (4095 + sbs + sizeof (*cygheap)));
-      prebrk =3D (char *) (cygheap + 1) + sbs;
+      (void) _csbrk (sizeof (*cygheap) + sbs);
+      prebrk =3D (char *) (cygheap + 1);
     }
   else
     {

------=_NextPart_000_01E2_01C23D7C.A15841B0--

