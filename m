Return-Path: <cygwin-patches-return-4881-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6106 invoked by alias); 26 Jul 2004 12:16:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6094 invoked from network); 26 Jul 2004 12:16:55 -0000
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH] Fix AMD flags in /proc/cpuinfo
Date: Mon, 26 Jul 2004 12:16:00 -0000
Message-ID: <0c9501c4730a$71ea1550$0207a8c0@avocado>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0C96_01C47312.D3AE7D50"
X-SW-Source: 2004-q3/txt/msg00033.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0C96_01C47312.D3AE7D50
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-length: 369

This patch extends Tomas Ukkonen's earlier AMD fix by removing
Intel-specific flags from /proc/cpuinfo on AMD processors. It also adds
support for a few more AMD-specific flags. Output for the flags field on
/proc/cpuinfo on my AMD Athlon XP now matches Linux. I changed a few of
the names for Intel extended features to match Linux.

Chris

--
http://www.atomice.com 

------=_NextPart_000_0C96_01C47312.D3AE7D50
Content-Type: application/octet-stream;
	name="proc_amd.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc_amd.patch"
Content-length: 4577

Index: fhandler_proc.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v=0A=
retrieving revision 1.44=0A=
diff -U3 -r1.44 fhandler_proc.cc=0A=
--- fhandler_proc.cc	19 Jul 2004 13:13:48 -0000	1.44=0A=
+++ fhandler_proc.cc	26 Jul 2004 12:11:40 -0000=0A=
@@ -698,14 +698,14 @@=0A=
 	  cpuid (&maxf, &vendor_id[0], &vendor_id[2], &vendor_id[1], 0);=0A=
 	  maxf &=3D 0xffff;=0A=
 	  vendor_id[3] =3D 0;=0A=
-=09=20=20=0A=
+=0A=
 	  // vendor identification=0A=
 	  bool is_amd =3D false, is_intel =3D false;=0A=
 	  if (!strcmp ((char*)vendor_id, "AuthenticAMD"))=0A=
 	    is_amd =3D true;=0A=
 	  else if (!strcmp ((char*)vendor_id, "GenuineIntel"))=0A=
 	    is_intel =3D true;=0A=
-=09=20=20=0A=
+=0A=
 	  bufptr +=3D __small_sprintf (bufptr, "vendor_id       : %s\n", (char *)=
vendor_id);=0A=
 	  unsigned cpu_mhz  =3D 0;=0A=
 	  if (wincap.is_winnt ())=0A=
@@ -841,9 +841,9 @@=0A=
 		print (" psn");=0A=
 	      if (features1 & (1 << 19))=0A=
 		print (" clfl");=0A=
-	      if (features1 & (1 << 21))=0A=
+	      if (is_intel && features1 & (1 << 21))=0A=
 		print (" dtes");=0A=
-	      if (features1 & (1 << 22))=0A=
+	      if (is_intel && features1 & (1 << 22))=0A=
 		print (" acpi");=0A=
 	      if (features1 & (1 << 23))=0A=
 		print (" mmx");=0A=
@@ -851,45 +851,56 @@=0A=
 		print (" fxsr");=0A=
 	      if (features1 & (1 << 25))=0A=
 		print (" sse");=0A=
-	      if (features1 & (1 << 26))=0A=
-		print (" sse2");=0A=
-	      if (features1 & (1 << 27))=0A=
-		print (" ss");=0A=
-	      if (features1 & (1 << 28))=0A=
-		print (" htt");=0A=
-	      if (features1 & (1 << 29))=0A=
-		print (" tmi");=0A=
-	      if (features1 & (1 << 30))=0A=
-		print (" ia-64");=0A=
-	      if (features1 & (1 << 31))=0A=
-		print (" pbe");=0A=
-	      if (features2 & (1 << 0))=0A=
-		print (" sse3");=0A=
-	      if (features2 & (1 << 3))=0A=
-		print (" mon");=0A=
-	      if (features2 & (1 << 4))=0A=
-		print (" dscpl");=0A=
-	      if (features2 & (1 << 8))=0A=
-		print (" tm2");=0A=
-	      if (features2 & (1 << 10))=0A=
-		print (" cid");=0A=
-=09=20=20=20=20=20=20=0A=
-	      if (is_amd)=0A=
+	      if (is_intel)=0A=
+	        {=0A=
+	          if (features1 & (1 << 26))=0A=
+		    print (" sse2");=0A=
+	          if (features1 & (1 << 27))=0A=
+		    print (" ss");=0A=
+	          if (features1 & (1 << 28))=0A=
+		    print (" htt");=0A=
+	          if (features1 & (1 << 29))=0A=
+		    print (" tmi");=0A=
+	          if (features1 & (1 << 30))=0A=
+		    print (" ia-64");=0A=
+	          if (features1 & (1 << 31))=0A=
+		    print (" pbe");=0A=
+=0A=
+	          if (features2 & (1 << 0))=0A=
+		    print (" pni");=0A=
+	          if (features2 & (1 << 3))=0A=
+		    print (" monitor");=0A=
+	          if (features2 & (1 << 4))=0A=
+		    print (" ds_cpl");=0A=
+		  if (features2 & (1 << 7))=0A=
+		    print (" tm2");=0A=
+	          if (features2 & (1 << 8))=0A=
+		    print (" est");=0A=
+	         if (features2 & (1 << 10))=0A=
+		    print (" cid");=0A=
+	        }=0A=
+=0A=
+	      if (is_amd && maxe >=3D 0x80000001)=0A=
 	        {=0A=
 		  // uses AMD extended calls to check=0A=
 		  // for 3dnow and 3dnow extended support=0A=
 		  // (source: AMD Athlon Processor Recognition Application Note)=0A=
-		  unsigned int a =3D 0, b, c, d;=0A=
-		  cpuid (&a, &b, &c, &d, 0x80000000);=0A=
-=09=09=20=20=0A=
-		  if (a >=3D 0x80000001)  // has basic capabilities=0A=
+=0A=
+		  if (maxe >=3D 0x80000001)  // has basic capabilities=0A=
 		    {=0A=
-		      cpuid (&a, &b, &c, &d, 0x80000001);=0A=
-=09=09=20=20=20=20=20=20=0A=
-		      if(d & (1 << 30)) // 31th bit is on=0A=
+		      cpuid (&unused, &unused, &unused, &features2, 0x80000001);=0A=
+=0A=
+                      if (features2 & (1 << 11))=0A=
+		        print (" syscall");=0A=
+                      if (features2 & (1 << 19))=0A=
+		        print (" mp");=0A=
+                      if (features2 & (1 << 22))=0A=
+                        print (" mmxext");=0A=
+                      if (features2 & (1 << 29))=0A=
+                        print (" lm");=0A=
+		      if (features2 & (1 << 30)) // 31th bit is on=0A=
 			print (" 3dnowext");=0A=
-=09=09=20=20=20=20=20=20=0A=
-		      if(d & (1 << 31)) // 32th bit (highest) is on=0A=
+		      if (features2 & (1 << 31)) // 32th bit (highest) is on=0A=
 			print (" 3dnow");=0A=
 		    }=0A=
 		}=0A=

------=_NextPart_000_0C96_01C47312.D3AE7D50
Content-Type: application/octet-stream;
	name="proc_amd.ChangeLog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc_amd.ChangeLog"
Content-length: 261

2004-07-20  Christopher January  <chris@atomice.net>=0A=
=0A=
	* fhandler_proc.cc (format_proc_cpuinfo): Remove Intel-specific flags from=
 /proc/cpuinfo on=0A=
	non-Intel processors. Added new AMD-specific flags. Changed Intel flag nam=
es to match Linux.=0A=

------=_NextPart_000_0C96_01C47312.D3AE7D50--
