Return-Path: <cygwin-patches-return-1973-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3498 invoked by alias); 11 Mar 2002 18:04:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3468 invoked from network); 11 Mar 2002 18:04:45 -0000
Message-ID: <006201c1c927$8d05f550$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: msync patch
Date: Mon, 11 Mar 2002 10:16:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_005F_01C1C927.8C1AAAF0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00330.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_005F_01C1C927.8C1AAAF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 489

This patch modifies msync in mmap.cc so that you can call msync with an
address which occurs in the middle of an mmap'ed region. It also fixes the
bug where the address in the relevant mmap_record would not match the one
passed to msync if the offset of the mmap'ed region within the file was not
on a dwAllocationGranularity boundary.

Regards
Chris

2002-03-11  Christopher January <chris@atomice.net>

 * mmap.cc (msync): Match addresses which are in the middle
 of an mmap'ed region.


------=_NextPart_000_005F_01C1C927.8C1AAAF0
Content-Type: application/octet-stream;
	name="mmap.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mmap.patch"
Content-length: 928

Index: mmap.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/mmap.cc,v=0A=
retrieving revision 1.52=0A=
diff -u -3 -p -u -p -a -b -B -r1.52 mmap.cc=0A=
--- mmap.cc	2002/02/25 17:47:47	1.52=0A=
+++ mmap.cc	2002/03/11 17:48:45=0A=
@@ -664,7 +664,8 @@ msync (caddr_t addr, size_t len, int fla=0A=
 	  for (int li =3D 0; li < l->nrecs; ++li)=0A=
 	    {=0A=
 	      mmap_record *rec =3D l->recs + li;=0A=
-	      if (rec->get_address () =3D=3D addr)=0A=
+              caddr_t rec_addr =3D rec->get_address ();=0A=
+              if (addr >=3D rec_addr && addr < rec_addr + rec->get_size ()=
)=0A=
 		{=0A=
 		  fhandler_base *fh =3D rec->alloc_fh ();=0A=
 		  int ret =3D fh->msync (rec->get_handle (), addr, len, flags);=0A=

------=_NextPart_000_005F_01C1C927.8C1AAAF0
Content-Type: application/octet-stream;
	name="ChangeLog.mmap"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.mmap"
Content-length: 136

2002-03-11  Christopher January <chris@atomice.net>

	* mmap.cc (msync): Match addresses which are in the middle
	of an mmap'ed region.

------=_NextPart_000_005F_01C1C927.8C1AAAF0--
