Return-Path: <cygwin-patches-return-4001-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25169 invoked by alias); 10 Jul 2003 01:10:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25159 invoked from network); 10 Jul 2003 01:10:11 -0000
Date: Thu, 10 Jul 2003 01:10:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: start_time patch for fhandler_process.cc
Message-ID: <20030710011010.GA8193@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030709005048.GA18400@redhat.com> <ICEBIHGCEJIPLNMBNCMKOEIKCIAA.chris@atomice.net> <20030710000128.GA9943@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030710000128.GA9943@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00017.txt.bz2

On Wed, Jul 09, 2003 at 08:01:28PM -0400, Christopher Faylor wrote:
>On Wed, Jul 09, 2003 at 11:11:48AM +0100, Chris January wrote:
>>
>>> On Tue, Jul 08, 2003 at 07:09:12PM +0100, Chris January wrote:
>>> >Try this Chris and see if it solves the start time problem.
>>> >
>>> >Chris
>>> >
>>> >2003-07-28  Chris January  <kseitz@chris@atomice.net>
>>> >
>>> >	* fhandler_process.cc (format_process_stat): Changed the
>>> calculation for
>>> >start_time.
>>>
>>> Sorry, no.
>>>
>>> Unknown HZ value! (250) Assume 100.
>>> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
>>> cgf       3452  0.0  1.0  2544 2680 ?        R    Aug08   0:00 procps auwx
>>>
>>> Now that I've read the description of what the field is supposed to
>>> contain, I'm wondering if the culprit is the "Unknown HZ value! (250)
>>> Assume 100."
>>Maybe sysconf (_SC_NPROCESSORS_CONF) is reporting the wrong amount if the
>>problem is indeed you are running on an SMP machine.
>
>_SC_NPROCESSORS_CONF returns two, as it should.
>_SC_NPROCESSORS_ONLN returned three, which was wrong, but I just checked in
>a fix for that.  No change after that, though.
>
>I guess I'll build procps and see what's up.

There are a couple of problems.

1) procps is not allowing a valid 500MHZ setting for my system
   (patch enclosed for procps).

2) /proc/stat is not reporting times for all cpus
   (patch enclosed and applied).

With these two patches, procps reports accurate times.

This requires a new procps release, though, unfortunately.

cgf

--- sysinfo.c~	2003-07-09 20:04:10.000000000 -0400
+++ sysinfo.c	2003-07-09 20:58:40.000000000 -0400
@@ -142,6 +142,7 @@ static void init_Hertz_value(void){
   case  195 ...  204 :  Hertz =  200; break; /* normal << 1 */
   case  253 ...  260 :  Hertz =  256; break;
   case  393 ...  408 :  Hertz =  400; break; /* normal << 2 */
+  case  480 ...  520 :  Hertz =  500; break; /* SMP WinNT */
   case  790 ...  808 :  Hertz =  800; break; /* normal << 3 */
   case  990 ... 1010 :  Hertz = 1000; break; /* ARM */
   case 1015 ... 1035 :  Hertz = 1024; break; /* Alpha, ia64 */

2003-07-09  Christopher Faylor  <cgf@redhat.com>

        * fhandler_proc.cc (fhandler_proc::fill_filebuf): Allocate more space
        for stat buffer.
        (format_proc_stat): Reorganize to accumulate and report on all cpus.

Index: fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.31
diff -u -p -r1.31 fhandler_proc.cc
--- fhandler_proc.cc	16 Jun 2003 03:24:10 -0000	1.31
+++ fhandler_proc.cc	10 Jul 2003 00:59:10 -0000
@@ -349,7 +349,7 @@ fhandler_proc::fill_filebuf ()
       }
     case PROC_STAT:
       {
-	filebuf = (char *) realloc (filebuf, bufalloc = 2048);
+	filebuf = (char *) realloc (filebuf, bufalloc = 16384);
 	filesize = format_proc_stat (filebuf, bufalloc);
 	break;
       }
@@ -456,24 +456,61 @@ out:
 static _off64_t
 format_proc_stat (char *destbuf, size_t maxsize)
 {
-  unsigned long long user_time = 0ULL, kernel_time = 0ULL, idle_time = 0ULL;
   unsigned long pages_in = 0UL, pages_out = 0UL, interrupt_count = 0UL,
 		context_switches = 0UL, swap_in = 0UL, swap_out = 0UL;
   time_t boot_time = 0;
 
-  if (wincap.is_winnt ())
+  char *eobuf = destbuf;
+  if (!wincap.is_winnt ())
+    eobuf += __small_sprintf (destbuf, "cpu %U %U %U %U\n", 0, 0, 0, 0);
+  else
     {
       NTSTATUS ret;
-      SYSTEM_PROCESSOR_TIMES spt;
       SYSTEM_PERFORMANCE_INFORMATION spi;
       SYSTEM_TIME_OF_DAY_INFORMATION stodi;
-      ret = NtQuerySystemInformation (SystemProcessorTimes,
-				      (PVOID) &spt,
-				      sizeof spt, NULL);
+
+      SYSTEM_BASIC_INFORMATION sbi;
+      if ((ret = NtQuerySystemInformation (SystemBasicInformation,
+					   (PVOID) &sbi, sizeof sbi, NULL))
+	  != STATUS_SUCCESS)
+	{
+	  __seterrno_from_win_error (RtlNtStatusToDosError (ret));
+	  debug_printf ("NtQuerySystemInformation: ret = %d, "
+			"Dos(ret) = %d",
+			ret, RtlNtStatusToDosError (ret));
+	  sbi.NumberProcessors = 1;
+	}
+
+      SYSTEM_PROCESSOR_TIMES spt[sbi.NumberProcessors];
+      ret = NtQuerySystemInformation (SystemProcessorTimes, (PVOID) spt,
+				      sizeof spt[0] * sbi.NumberProcessors, NULL);
+      interrupt_count = 0;
       if (ret == STATUS_SUCCESS)
-	ret = NtQuerySystemInformation (SystemPerformanceInformation,
-					(PVOID) &spi,
-					sizeof spi, NULL);
+	{
+	  unsigned long long user_time = 0ULL, kernel_time = 0ULL, idle_time = 0ULL;
+	  for (int i = 0; i < sbi.NumberProcessors; i++)
+	    {
+	      kernel_time += (spt[i].KernelTime.QuadPart - spt[i].IdleTime.QuadPart) * HZ / 10000000ULL;
+	      user_time += spt[i].UserTime.QuadPart * HZ / 10000000ULL;
+	      idle_time += spt[i].IdleTime.QuadPart * HZ / 10000000ULL;
+	    }
+
+	  eobuf += __small_sprintf (eobuf, "cpu %U %U %U %U\n",
+				    user_time, 0ULL, kernel_time, idle_time);
+	  user_time = 0ULL, kernel_time = 0ULL, idle_time = 0ULL;
+	  for (int i = 0; i < sbi.NumberProcessors; i++)
+	    {
+	      interrupt_count += spt[i].InterruptCount;
+	      kernel_time = (spt[i].KernelTime.QuadPart - spt[i].IdleTime.QuadPart) * HZ / 10000000ULL;
+	      user_time = spt[i].UserTime.QuadPart * HZ / 10000000ULL;
+	      idle_time = spt[i].IdleTime.QuadPart * HZ / 10000000ULL;
+	      eobuf += __small_sprintf (eobuf, "cpu%d %U %U %U %U\n", i,
+					user_time, 0ULL, kernel_time, idle_time);
+	    }
+
+	  ret = NtQuerySystemInformation (SystemPerformanceInformation,
+					  (PVOID) &spi, sizeof spi, NULL);
+	}
       if (ret == STATUS_SUCCESS)
 	ret = NtQuerySystemInformation (SystemTimeOfDayInformation,
 					(PVOID) &stodi,
@@ -486,10 +523,6 @@ format_proc_stat (char *destbuf, size_t 
 		       ret, RtlNtStatusToDosError (ret));
 	  return 0;
 	}
-      kernel_time = (spt.KernelTime.QuadPart - spt.IdleTime.QuadPart) * HZ / 10000000ULL;
-      user_time = spt.UserTime.QuadPart * HZ / 10000000ULL;
-      idle_time = spt.IdleTime.QuadPart * HZ / 10000000ULL;
-      interrupt_count = spt.InterruptCount;
       pages_in = spi.PagesRead;
       pages_out = spi.PagefilePagesWritten + spi.MappedFilePagesWritten;
       /*
@@ -512,19 +545,17 @@ format_proc_stat (char *destbuf, size_t 
    * counters is by no means worth it.
    *   }
    */
-  return __small_sprintf (destbuf, "cpu %U %U %U %U\n"
-				   "page %u %u\n"
+  eobuf += __small_sprintf (eobuf, "page %u %u\n"
 				   "swap %u %u\n"
 				   "intr %u\n"
 				   "ctxt %u\n"
 				   "btime %u\n",
-			  user_time, 0ULL,
-			  kernel_time, idle_time,
-			  pages_in, pages_out,
-			  swap_in, swap_out,
-			  interrupt_count,
-			  context_switches,
-			  boot_time);
+				   pages_in, pages_out,
+				   swap_in, swap_out,
+				   interrupt_count,
+				   context_switches,
+				   boot_time);
+  return eobuf - destbuf;
 }
 
 #define read_value(x,y) \
