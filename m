Return-Path: <cygwin-patches-return-6179-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6946 invoked by alias); 11 Dec 2007 12:18:26 -0000
Received: (qmail 6936 invoked by uid 22791); 11 Dec 2007 12:18:25 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 11 Dec 2007 12:18:21 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Tue, 11 Dec 2007 12:18:17 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: "Cygwin patches" <cygwin-patches@cygwin.com>
Subject: Cygheap page boundary allocation bug.
Date: Tue, 11 Dec 2007 12:18:00 -0000
Message-ID: <0b0d01c83bef$e9364690$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; 	boundary="----=_NextPart_000_0B0E_01C83BEF.E9364690"
X-Mailer: Microsoft Office Outlook 11
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00031.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0B0E_01C83BEF.E9364690
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Content-length: 1745


    Hi gang,

  My bug turned out to be a problem in the cygheap _csbrk routine.  If an
allocation takes you exactly to the end of a granularity page, _csbrk calls
VirtualAlloc with a dwSize of zero bytes - the adjusted amount by which the heap
needs to be extended into the next page.  VirtualAlloc doesn't like this and
returns win32 error 87 (ERROR_INVALID_PARAMETER), which fakes out _csbrk into
thinking there's no memory available.

  (This was happening to me in the fork()'d child of g++.exe just as it was
passing through spawn_guts on its way to exec()'ing cc1plus.exe, resulting in
cc1plus.exe having an invalid environment when it got going.  Amazingly enough,
it managed to stagger on through compilation and complete execution, and the
only symptom that something was wrong was that it gave an error when it couldn't
find a header file that I knew for sure was on the -I search path... because
GCC_CYGWIN_MINGW=1 had gone missing from the environment).

  The fix is dead simple, just don't call VirtualAlloc: we get cygheap_max
pointing exactly to the first byte of the next unallocated granularity page, and
next time round - this is critically dependent on the current behaviour of the
nextpage() macro, which doesn't round a pointer to the very first byte of a page
to the next one, maybe that needs a comment to prevent someone thinking it's a
bug in the future - the page will be allocated.

  Bug is present on, and patch applies cleanly to, both branch and trunk.

2007-12-11  Dave Korn  <dave.korn@artimi.com>

	* cygheap.cc (_csbrk):  Don't request zero bytes from VirtualAlloc,
	as windows treats that as an invalid parameter and returns an error.

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....

------=_NextPart_000_0B0E_01C83BEF.E9364690
Content-Type: application/octet-stream;
	name="pr1481-patch.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pr1481-patch.diff"
Content-length: 800

diff -pru cygwin-1.5.23-2/winsup/cygwin/cygheap.cc cygwin-1.5.23-2.fixed/wi=
nsup/cygwin/cygheap.cc=0A=
--- cygwin-1.5.23-2/winsup/cygwin/cygheap.cc	2006-06-03 07:35:10.000000000 =
+0100=0A=
+++ cygwin-1.5.23-2.fixed/winsup/cygwin/cygheap.cc	2007-12-11 02:19:09.9858=
54900 +0000=0A=
@@ -129,7 +129,7 @@ _csbrk (int sbs)=0A=
 	newbase =3D _cygheap_end;=0A=
=20=0A=
       DWORD adjsbs =3D allocsize ((char *) cygheap_max - newbase);=0A=
-      if (!VirtualAlloc (newbase, adjsbs, MEM_COMMIT | MEM_RESERVE, PAGE_R=
EADWRITE))=0A=
+      if (adjsbs && !VirtualAlloc (newbase, adjsbs, MEM_COMMIT | MEM_RESER=
VE, PAGE_READWRITE))=0A=
 	{=0A=
 	  MEMORY_BASIC_INFORMATION m;=0A=
 	  if (!VirtualQuery (newbase, &m, sizeof m))=0A=
Only in cygwin-1.5.23-2.fixed/winsup/cygwin/include/sys: strace.h.rej=0A=

------=_NextPart_000_0B0E_01C83BEF.E9364690--
