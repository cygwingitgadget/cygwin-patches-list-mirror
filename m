Return-Path: <cygwin-patches-return-3704-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18280 invoked by alias); 13 Mar 2003 23:57:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18200 invoked from network); 13 Mar 2003 23:57:42 -0000
From: "Chris January" <chris@atomice.net>
To: <cygwin@cygwin.com>,
	"Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: RE: Cygwin installation choke
Date: Thu, 13 Mar 2003 23:57:00 -0000
Message-ID: <LPEHIHGCJOAIPFLADJAHMEMNDGAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <20030313225350.GV27047@cygbert.vinschen.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
X-SW-Source: 2003-q1/txt/msg00353.txt.bz2

> On Thu, Mar 13, 2003 at 05:09:21PM +0000, Chris Hardie wrote:
> > "The CYGWIN1.DLL is linked to missing export
> > KERNEL32.DLL:IsProcessorFeaturePresent"
> >
> > I'm running Windows '95 on a P300 Celeron. Anyone have any idea what's
> > going on?
>
> Fixed in CVS.  Thanks for the report.
Corinna, the cpuid results are still valid if the user doesn't have NT. Only
in the worst case scenario (i.e. a user running Windows 95/98 on a 486) will
it be necessary to resort to falling back on the registry values alone.

Chris

Index: fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.25
diff -u -p -r1.25 fhandler_proc.cc
--- fhandler_proc.cc	13 Mar 2003 22:53:16 -0000	1.25
+++ fhandler_proc.cc	13 Mar 2003 23:52:31 -0000
@@ -631,15 +631,7 @@ format_proc_cpuinfo (char *destbuf, size
 	    debug_printf ("processor does not support CPUID instruction");
 	}

-      if (!wincap.is_winnt ())
-        {
-	  bufptr += __small_sprintf (bufptr, "processor       : %d\n",
cpu_number);
-	  read_value ("VendorIdentifier", REG_SZ);
-	  bufptr += __small_sprintf (bufptr, "vendor id       : %s\n", szBuffer);
-	  read_value ("Identifier", REG_SZ);
-	  bufptr += __small_sprintf (bufptr, "identifier      : %s\n", szBuffer);
-	}
-      else if (!has_cpuid)
+    if (!has_cpuid)
 	{
 	  bufptr += __small_sprintf (bufptr, "processor       : %d\n",
cpu_number);
 	  read_value ("VendorIdentifier", REG_SZ);
@@ -649,23 +641,26 @@ format_proc_cpuinfo (char *destbuf, size
 	  read_value ("~Mhz", REG_DWORD);
 	  bufptr += __small_sprintf (bufptr, "cpu MHz         : %u\n", *(DWORD *)
szBuffer);

-	  print ("flags           :");
-	  if (IsProcessorFeaturePresent (PF_3DNOW_INSTRUCTIONS_AVAILABLE))
-	    print (" 3dnow");
-	  if (IsProcessorFeaturePresent (PF_COMPARE_EXCHANGE_DOUBLE))
-	    print (" cx8");
-	  if (!IsProcessorFeaturePresent (PF_FLOATING_POINT_EMULATED))
-	    print (" fpu");
-	  if (IsProcessorFeaturePresent (PF_MMX_INSTRUCTIONS_AVAILABLE))
-	    print (" mmx");
-	  if (IsProcessorFeaturePresent (PF_PAE_ENABLED))
-	    print (" pae");
-	  if (IsProcessorFeaturePresent (PF_RDTSC_INSTRUCTION_AVAILABLE))
-	    print (" tsc");
-	  if (IsProcessorFeaturePresent (PF_XMMI_INSTRUCTIONS_AVAILABLE))
-	    print (" sse");
-	  if (IsProcessorFeaturePresent (PF_XMMI64_INSTRUCTIONS_AVAILABLE))
-	    print (" sse2");
+      if (!wincap.is_winnt ())
+        {
+	      print ("flags           :");
+	      if (IsProcessorFeaturePresent (PF_3DNOW_INSTRUCTIONS_AVAILABLE))
+	        print (" 3dnow");
+	      if (IsProcessorFeaturePresent (PF_COMPARE_EXCHANGE_DOUBLE))
+	        print (" cx8");
+	      if (!IsProcessorFeaturePresent (PF_FLOATING_POINT_EMULATED))
+	        print (" fpu");
+	      if (IsProcessorFeaturePresent (PF_MMX_INSTRUCTIONS_AVAILABLE))
+	        print (" mmx");
+	      if (IsProcessorFeaturePresent (PF_PAE_ENABLED))
+	        print (" pae");
+	      if (IsProcessorFeaturePresent (PF_RDTSC_INSTRUCTION_AVAILABLE))
+	        print (" tsc");
+	      if (IsProcessorFeaturePresent (PF_XMMI_INSTRUCTIONS_AVAILABLE))
+	        print (" sse");
+	      if (IsProcessorFeaturePresent (PF_XMMI64_INSTRUCTIONS_AVAILABLE))
+	        print (" sse2");
+      }
 	}
       else
 	{
