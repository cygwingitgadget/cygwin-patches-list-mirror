Return-Path: <cygwin-patches-return-3709-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17399 invoked by alias); 18 Mar 2003 01:45:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17362 invoked from network); 18 Mar 2003 01:45:04 -0000
From: "Chris January" <chris@atomice.net>
To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: /proc/cpuinfo fix
Date: Tue, 18 Mar 2003 01:45:00 -0000
Message-ID: <LPEHIHGCJOAIPFLADJAHMEABDHAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0001_01C2ECEF.FFB16570"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
X-SW-Source: 2003-q1/txt/msg00358.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C2ECEF.FFB16570
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 741

This patch changes Corinna's fix for the IsProcessorFeaturePresent missing
export so that the cpuid instruction is called (if available) even on non-NT
systems, giving more detailed information. This patch does not allow for the
bug in IsProcessorFeaturePresent on Windows NT 4 (i.e. on 486DX processors
it will incorrectly report that an FPU is not present).
This patch is UNTESTED on Windows 95/98/Me since I can't do that until
tomorrow.

2003-03-18  Christopher January  <chris@atomice.net>

	* fhandler_proc.cc (format_proc_cpuinfo): Use IsProcessorFeaturePresent
	only on Windows NT. Read CPU Mhz value only on NT. Revert previous change
	so cpuid instruction is called even on non-NT systems.

---
Christopher January www.atomice.com

------=_NextPart_000_0001_01C2ECEF.FFB16570
Content-Type: application/octet-stream;
	name="cpuinfo.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cpuinfo.patch"
Content-length: 7729

Index: fhandler_proc.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v=0A=
retrieving revision 1.25=0A=
diff -u -p -r1.25 fhandler_proc.cc=0A=
--- fhandler_proc.cc	13 Mar 2003 22:53:16 -0000	1.25=0A=
+++ fhandler_proc.cc	18 Mar 2003 01:27:20 -0000=0A=
@@ -631,42 +631,38 @@ format_proc_cpuinfo (char *destbuf, size=0A=
 	    debug_printf ("processor does not support CPUID instruction");=0A=
 	}=0A=
=20=0A=
-      if (!wincap.is_winnt ())=0A=
-        {=0A=
-	  bufptr +=3D __small_sprintf (bufptr, "processor       : %d\n", cpu_numb=
er);=0A=
-	  read_value ("VendorIdentifier", REG_SZ);=0A=
-	  bufptr +=3D __small_sprintf (bufptr, "vendor id       : %s\n", szBuffer=
);=0A=
-	  read_value ("Identifier", REG_SZ);=0A=
-	  bufptr +=3D __small_sprintf (bufptr, "identifier      : %s\n", szBuffer=
);=0A=
-	}=0A=
-      else if (!has_cpuid)=0A=
+=0A=
+      if (!has_cpuid)=0A=
 	{=0A=
 	  bufptr +=3D __small_sprintf (bufptr, "processor       : %d\n", cpu_numb=
er);=0A=
 	  read_value ("VendorIdentifier", REG_SZ);=0A=
 	  bufptr +=3D __small_sprintf (bufptr, "vendor id       : %s\n", szBuffer=
);=0A=
 	  read_value ("Identifier", REG_SZ);=0A=
 	  bufptr +=3D __small_sprintf (bufptr, "identifier      : %s\n", szBuffer=
);=0A=
-	  read_value ("~Mhz", REG_DWORD);=0A=
-	  bufptr +=3D __small_sprintf (bufptr, "cpu MHz         : %u\n", *(DWORD =
*) szBuffer);=0A=
+          if (wincap.is_winnt ())=0A=
+            {=0A=
+	      read_value ("~Mhz", REG_DWORD);=0A=
+	      bufptr +=3D __small_sprintf (bufptr, "cpu MHz         : %u\n", *(DW=
ORD *) szBuffer);=0A=
=20=0A=
-	  print ("flags           :");=0A=
-	  if (IsProcessorFeaturePresent (PF_3DNOW_INSTRUCTIONS_AVAILABLE))=0A=
-	    print (" 3dnow");=0A=
-	  if (IsProcessorFeaturePresent (PF_COMPARE_EXCHANGE_DOUBLE))=0A=
-	    print (" cx8");=0A=
-	  if (!IsProcessorFeaturePresent (PF_FLOATING_POINT_EMULATED))=0A=
-	    print (" fpu");=0A=
-	  if (IsProcessorFeaturePresent (PF_MMX_INSTRUCTIONS_AVAILABLE))=0A=
-	    print (" mmx");=0A=
-	  if (IsProcessorFeaturePresent (PF_PAE_ENABLED))=0A=
-	    print (" pae");=0A=
-	  if (IsProcessorFeaturePresent (PF_RDTSC_INSTRUCTION_AVAILABLE))=0A=
-	    print (" tsc");=0A=
-	  if (IsProcessorFeaturePresent (PF_XMMI_INSTRUCTIONS_AVAILABLE))=0A=
-	    print (" sse");=0A=
-	  if (IsProcessorFeaturePresent (PF_XMMI64_INSTRUCTIONS_AVAILABLE))=0A=
-	    print (" sse2");=0A=
-	}=0A=
+	      print ("flags           :");=0A=
+	      if (IsProcessorFeaturePresent (PF_3DNOW_INSTRUCTIONS_AVAILABLE))=0A=
+	        print (" 3dnow");=0A=
+	      if (IsProcessorFeaturePresent (PF_COMPARE_EXCHANGE_DOUBLE))=0A=
+	        print (" cx8");=0A=
+	      if (!IsProcessorFeaturePresent (PF_FLOATING_POINT_EMULATED))=0A=
+	        print (" fpu");=0A=
+	      if (IsProcessorFeaturePresent (PF_MMX_INSTRUCTIONS_AVAILABLE))=0A=
+	        print (" mmx");=0A=
+	      if (IsProcessorFeaturePresent (PF_PAE_ENABLED))=0A=
+	        print (" pae");=0A=
+	      if (IsProcessorFeaturePresent (PF_RDTSC_INSTRUCTION_AVAILABLE))=0A=
+	        print (" tsc");=0A=
+	      if (IsProcessorFeaturePresent (PF_XMMI_INSTRUCTIONS_AVAILABLE))=0A=
+	        print (" sse");=0A=
+	      if (IsProcessorFeaturePresent (PF_XMMI64_INSTRUCTIONS_AVAILABLE))=
=0A=
+	        print (" sse2");=0A=
+	    }=0A=
+        }=0A=
       else=0A=
 	{=0A=
 	  bufptr +=3D __small_sprintf (bufptr, "processor       : %d\n", cpu_numb=
er);=0A=
@@ -675,8 +671,12 @@ format_proc_cpuinfo (char *destbuf, size=0A=
 	  maxf &=3D 0xffff;=0A=
 	  vendor_id[3] =3D 0;=0A=
 	  bufptr +=3D __small_sprintf (bufptr, "vendor id       : %s\n", (char *)=
vendor_id);=0A=
-	  read_value ("~Mhz", REG_DWORD);=0A=
-	  unsigned cpu_mhz =3D *(DWORD *)szBuffer;=0A=
+          unsigned cpu_mhz  =3D 0;=0A=
+          if (wincap.is_winnt ())=0A=
+            {=0A=
+	      read_value ("~Mhz", REG_DWORD);=0A=
+	      cpu_mhz =3D *(DWORD *)szBuffer;=0A=
+            }=0A=
 	  if (maxf >=3D 1)=0A=
 	    {=0A=
 	      unsigned features2, features1, extra_info, cpuid_sig;=0A=
@@ -722,26 +722,50 @@ format_proc_cpuinfo (char *destbuf, size=0A=
 		  // could implement a lookup table here if someone needs it=0A=
 		  strcpy (szBuffer, "unknown");=0A=
 		}=0A=
-	      bufptr +=3D __small_sprintf (bufptr, "type            : %s\n"=0A=
-						 "cpu family      : %d\n"=0A=
-						 "model           : %d\n"=0A=
-						 "model name      : %s\n"=0A=
-						 "stepping        : %d\n"=0A=
-						 "brand id        : %d\n"=0A=
-						 "cpu count       : %d\n"=0A=
-						 "apic id         : %d\n"=0A=
-						 "cpu MHz         : %d\n"=0A=
-						 "fpu             : %s\n",=0A=
-					 type_str,=0A=
-					 family,=0A=
-					 model,=0A=
-					 szBuffer,=0A=
-					 stepping,=0A=
-					 brand_id,=0A=
-					 cpu_count,=0A=
-					 apic_id,=0A=
-					 cpu_mhz,=0A=
-					 IsProcessorFeaturePresent (PF_FLOATING_POINT_EMULATED) ? "no" : "yes=
");=0A=
+              if (wincap.is_winnt ())=0A=
+                {=0A=
+	          bufptr +=3D __small_sprintf (bufptr, "type            : %s\n"=
=0A=
+	        				     "cpu family      : %d\n"=0A=
+						     "model           : %d\n"=0A=
+						     "model name      : %s\n"=0A=
+						     "stepping        : %d\n"=0A=
+						     "brand id        : %d\n"=0A=
+						     "cpu count       : %d\n"=0A=
+						     "apic id         : %d\n"=0A=
+						     "cpu MHz         : %d\n"=0A=
+						     "fpu             : %s\n",=0A=
+					     type_str,=0A=
+					     family,=0A=
+					     model,=0A=
+					     szBuffer,=0A=
+					     stepping,=0A=
+					     brand_id,=0A=
+					     cpu_count,=0A=
+					     apic_id,=0A=
+					     cpu_mhz,=0A=
+					     (features1 & (1 << 0)) ? "yes" : "no");=0A=
+                }=0A=
+              else=0A=
+                {=0A=
+                  bufptr +=3D __small_sprintf (bufptr, "type            : =
%s\n"=0A=
+                                                     "cpu family      : %d=
\n"=0A=
+                                                     "model           : %d=
\n"=0A=
+                                                     "model name      : %s=
\n"=0A=
+                                                     "stepping        : %d=
\n"=0A=
+                                                     "brand id        : %d=
\n"=0A=
+                                                     "cpu count       : %d=
\n"=0A=
+                                                     "apic id         : %d=
\n"=0A=
+                                                     "fpu             : %s=
\n",=0A=
+                                             type_str,=0A=
+                                             family,=0A=
+                                             model,=0A=
+                                             szBuffer,=0A=
+                                             stepping,=0A=
+                                             brand_id,=0A=
+                                             cpu_count,=0A=
+                                             apic_id,=0A=
+                                             (features1 & (1 << 0)) ? "yes=
" : "no");=0A=
+                }=0A=
 	      print ("flags           :");=0A=
 	      if (features1 & (1 << 0))=0A=
 		print (" fpu");=0A=
@@ -814,7 +838,7 @@ format_proc_cpuinfo (char *destbuf, size=0A=
 	      if (features2 & (1 << 10))=0A=
 		print (" cid");=0A=
 	    }=0A=
-	  else=0A=
+	  else if (wincap.is_winnt ())=0A=
 	    {=0A=
 	      bufptr +=3D __small_sprintf (bufptr, "cpu MHz         : %d\n"=0A=
 						 "fpu             : %s\n",=0A=

------=_NextPart_000_0001_01C2ECEF.FFB16570--
