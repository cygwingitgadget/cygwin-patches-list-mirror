Return-Path: <cygwin-patches-return-2902-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26957 invoked by alias); 31 Aug 2002 13:49:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26942 invoked from network); 31 Aug 2002 13:49:52 -0000
X-WM-Posted-At: avacado.atomice.net; Sat, 31 Aug 02 14:49:50 +0100
From: "Chris January" <chris@atomice.net>
To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: /proc patch
Date: Sat, 31 Aug 2002 06:49:00 -0000
Message-ID: <LPEHIHGCJOAIPFLADJAHIEDICLAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0003_01C250FD.A89FFB40"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-SW-Source: 2002-q3/txt/msg00350.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0003_01C250FD.A89FFB40
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 701

This patch fixes the bug Emil Briggs found. It also uses the HZ define in
sys/param.h as the number of 'jiffies' per second, instead of hard-coding it
at 100.

Chris

---
2002-08-31  Christopher January  <chris@atomice.net>

	* fhandler_proc.cc: Add <sys/param.h> include.
	(format_proc_uptime): Use KernelTime and UserTime only as they include
	the other counters.
	(format_proc_stat): KernelTime includes IdleTime, so subtract IdleTime
	from KernelTime. Make number of 'jiffies' per second same as HZ define.
	* fhandler_process.cc: Add <sys/param.h> include.
	(format_process_stat): Make number of 'jiffies' per second same as
	HZ define. Use KernelTime and UserTime only to calculate start_time.


------=_NextPart_000_0003_01C250FD.A89FFB40
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 530

2002-08-31  Christopher January  <chris@atomice.net>

	* fhandler_proc.cc: Add <sys/param.h> include.
	(format_proc_uptime): Use KernelTime and UserTime only as they include
	the other counters.
	(format_proc_stat): KernelTime includes IdleTime, so subtract IdleTime
	from KernelTime. Make number of 'jiffies' per second same as HZ define.
	* fhandler_process.cc: Add <sys/param.h> include.
	(format_process_stat): Make number of 'jiffies' per second same as
	HZ define. Use KernelTime and UserTime only to calculate start_time.
	
------=_NextPart_000_0003_01C250FD.A89FFB40
Content-Type: application/octet-stream;
	name="proc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc.patch"
Content-length: 4716

? fhandler.h.2=0A=
? fhandler_proc.cc.2=0A=
? fhandler_process.cc.2=0A=
? fhandler_process2.cc=0A=
? tty.cc.fix=0A=
? unicode.cc=0A=
Index: fhandler_proc.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v=0A=
retrieving revision 1.14=0A=
diff -u -3 -p -u -p -r1.14 fhandler_proc.cc=0A=
--- fhandler_proc.cc	2 Jul 2002 01:36:15 -0000	1.14=0A=
+++ fhandler_proc.cc	31 Aug 2002 13:40:52 -0000=0A=
@@ -23,6 +23,7 @@ details. */=0A=
 #include "cygheap.h"=0A=
 #include <assert.h>=0A=
 #include <sys/utsname.h>=0A=
+#include <sys/param.h>=0A=
 #include "ntdll.h"=0A=
=20=0A=
 #define _COMPILING_NEWLIB=0A=
@@ -423,9 +424,8 @@ format_proc_uptime (char *destbuf, size_=0A=
   else=0A=
     {=0A=
       idle_time =3D spt.IdleTime.QuadPart / 100000ULL;=0A=
-      uptime =3D (spt.InterruptTime.QuadPart + spt.KernelTime.QuadPart +=
=0A=
-		spt.IdleTime.QuadPart + spt.UserTime.QuadPart +=0A=
-		spt.DpcTime.QuadPart) / 100000ULL;=0A=
+      uptime =3D (spt.KernelTime.QuadPart +=0A=
+		        spt.UserTime.QuadPart) / 100000ULL;=0A=
     }=0A=
=20=0A=
   return __small_sprintf (destbuf, "%U.%02u %U.%02u\n",=0A=
@@ -467,9 +467,9 @@ format_proc_stat (char *destbuf, size_t=20=0A=
 		       ret, RtlNtStatusToDosError (ret));=0A=
 	  return 0;=0A=
 	}=0A=
-      kernel_time =3D (spt.KernelTime.QuadPart + spt.InterruptTime.QuadPar=
t + spt.DpcTime.QuadPart) / 100000ULL;=0A=
-      user_time =3D spt.UserTime.QuadPart / 100000ULL;=0A=
-      idle_time =3D spt.IdleTime.QuadPart / 100000ULL;=0A=
+      kernel_time =3D (spt.KernelTime.QuadPart - spt.IdleTime.QuadPart) * =
HZ / 10000000ULL;=0A=
+      user_time =3D spt.UserTime.QuadPart * HZ / 10000000ULL;=0A=
+      idle_time =3D spt.IdleTime.QuadPart * HZ / 10000000ULL;=0A=
       interrupt_count =3D spt.InterruptCount;=0A=
       pages_in =3D spi.PagesRead;=0A=
       pages_out =3D spi.PagefilePagesWritten + spi.MappedFilePagesWritten;=
=0A=
Index: fhandler_process.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v=0A=
retrieving revision 1.18=0A=
diff -u -3 -p -u -p -r1.18 fhandler_process.cc=0A=
--- fhandler_process.cc	2 Jul 2002 01:36:15 -0000	1.18=0A=
+++ fhandler_process.cc	31 Aug 2002 13:40:53 -0000=0A=
@@ -23,6 +23,7 @@ details. */=0A=
 #include "dtable.h"=0A=
 #include "cygheap.h"=0A=
 #include "ntdll.h"=0A=
+#include <sys/param.h>=0A=
 #include <assert.h>=0A=
=20=0A=
 #define _COMPILING_NEWLIB=0A=
@@ -454,22 +455,18 @@ format_process_stat (_pinfo *p, char *de=0A=
 	  return 0;=0A=
 	}=0A=
        fault_count =3D vmc.PageFaultCount;=0A=
-       utime =3D put.UserTime.QuadPart / 100000ULL;=0A=
-       stime =3D put.KernelTime.QuadPart / 100000ULL;=0A=
+       utime =3D put.UserTime.QuadPart * HZ / 10000000ULL;=0A=
+       stime =3D put.KernelTime.QuadPart * HZ / 10000000ULL;=0A=
        if (stodi.CurrentTime.QuadPart > put.CreateTime.QuadPart)=0A=
-	 start_time =3D (spt.InterruptTime.QuadPart + spt.KernelTime.QuadPart +=
=0A=
-		       spt.IdleTime.QuadPart + spt.UserTime.QuadPart +=0A=
-		       spt.DpcTime.QuadPart - stodi.CurrentTime.QuadPart +=0A=
-		       put.CreateTime.QuadPart) / 100000ULL;=0A=
+         start_time =3D (spt.KernelTime.QuadPart + spt.UserTime.QuadPart -=
=0A=
+                       stodi.CurrentTime.QuadPart + put.CreateTime.QuadPar=
t) * HZ / 10000000ULL;=0A=
        else=0A=
 	 /*=0A=
 	  * sometimes stodi.CurrentTime is a bit behind=0A=
 	  * Note: some older versions of procps are broken and can't cope=0A=
 	  * with process start times > time(NULL).=0A=
 	  */=0A=
-	 start_time =3D (spt.InterruptTime.QuadPart + spt.KernelTime.QuadPart +=
=0A=
-		       spt.IdleTime.QuadPart + spt.UserTime.QuadPart +=0A=
-		       spt.DpcTime.QuadPart) / 100000ULL;=0A=
+	 start_time =3D (spt.KernelTime.QuadPart + spt.UserTime.QuadPart) * HZ / =
10000000ULL;=0A=
        priority =3D pbi.BasePriority;=0A=
        unsigned page_size =3D getpagesize();=0A=
        vmsize =3D vmc.VirtualSize;=0A=
@@ -478,7 +475,7 @@ format_process_stat (_pinfo *p, char *de=0A=
     }=0A=
   else=0A=
     {=0A=
-      start_time =3D (GetTickCount() / 1000 - time(NULL) + p->start_time) =
* 100;=0A=
+      start_time =3D (GetTickCount() / 1000 - time(NULL) + p->start_time) =
* HZ;=0A=
     }=0A=
   return __small_sprintf (destbuf, "%d (%s) %c "=0A=
 				   "%d %d %d %d %d "=0A=

------=_NextPart_000_0003_01C250FD.A89FFB40--
