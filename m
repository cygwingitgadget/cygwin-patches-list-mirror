Return-Path: <cygwin-patches-return-3826-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9339 invoked by alias); 19 Apr 2003 00:55:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9330 invoked from network); 19 Apr 2003 00:55:37 -0000
Date: Sat, 19 Apr 2003 00:55:00 -0000
From: Diego Biurrun <diego@biurrun.de>
Subject: /proc/cpuinfo output differs from Linux
To: cygwin-patches@cygwin.com
Message-id: <3EA07D56.5070509@biurrun.de>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_6FUk2nWOj1vvGErav4mMnA)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4a)
 Gecko/20030401
X-SW-Source: 2003-q2/txt/msg00053.txt.bz2

This is a multi-part message in MIME format.

--Boundary_(ID_6FUk2nWOj1vvGErav4mMnA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
Content-length: 693

Hello!

I am an MPlayer developer and was wondering why our configure script was 
suddenly failing to detect my K6-III CPU.  Then I noticed that Cygwin 
/proc/cpuinfo formatting is not the same as in Linux.

Cygwin:
   $ cat /proc/cpuinfo
   vendor id       : AuthenticAMD

Linux:
   lea:~$ cat /proc/cpuinfo
   vendor_id       : GenuineIntel

Cygwin outputs "vendor id" (with a blank), while Linux uses "vendor_id" 
with an underscore.  We use this information to identify processors and 
set up optimizations accordingly.

I grepped through the Cygwin sources for "vendor id" and made a small 
patch.  It is not tested but trivial, so I expect it to be fully correct.
Regards

Diego Biurrun

--Boundary_(ID_6FUk2nWOj1vvGErav4mMnA)
Content-type: text/plain; name=changelog
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=changelog
Content-length: 178

2003-04-18  Diego Biurrun  <diego@biurrun.de>

	* fhandler_proc.cc (format_proc_cpuinfo): Change /proc/cpuinfo "vendor id"
	string to "vendor_id" to conform with Linux systems.


--Boundary_(ID_6FUk2nWOj1vvGErav4mMnA)
Content-type: text/plain; name=vendor_id.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=vendor_id.patch
Content-length: 1265

Index: winsup/cygwin/fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.28
diff -u -p -r1.28 fhandler_proc.cc
--- winsup/cygwin/fhandler_proc.cc	16 Apr 2003 03:03:44 -0000	1.28
+++ winsup/cygwin/fhandler_proc.cc	18 Apr 2003 23:40:24 -0000
@@ -606,7 +606,7 @@ format_proc_cpuinfo (char *destbuf, size
 	{
 	  bufptr += __small_sprintf (bufptr, "processor       : %d\n", cpu_number);
 	  read_value ("VendorIdentifier", REG_SZ);
-	  bufptr += __small_sprintf (bufptr, "vendor id       : %s\n", szBuffer);
+	  bufptr += __small_sprintf (bufptr, "vendor_id       : %s\n", szBuffer);
 	  read_value ("Identifier", REG_SZ);
 	  bufptr += __small_sprintf (bufptr, "identifier      : %s\n", szBuffer);
           if (wincap.is_winnt ())
@@ -640,7 +640,7 @@ format_proc_cpuinfo (char *destbuf, size
 	  cpuid (&maxf, &vendor_id[0], &vendor_id[2], &vendor_id[1], 0);
 	  maxf &= 0xffff;
 	  vendor_id[3] = 0;
-	  bufptr += __small_sprintf (bufptr, "vendor id       : %s\n", (char *)vendor_id);
+	  bufptr += __small_sprintf (bufptr, "vendor_id       : %s\n", (char *)vendor_id);
           unsigned cpu_mhz  = 0;
           if (wincap.is_winnt ())
             {

--Boundary_(ID_6FUk2nWOj1vvGErav4mMnA)--
