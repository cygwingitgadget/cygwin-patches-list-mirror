Return-Path: <cygwin-patches-return-3851-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13174 invoked by alias); 9 May 2003 15:04:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13135 invoked from network); 9 May 2003 15:04:28 -0000
Message-ID: <3EBBC37B.7020300@hekimian.com>
Date: Fri, 09 May 2003 15:04:00 -0000
X-Sybari-Trust: 19a353b0 36b09be0 4b210cf9 00000109
From: Joe Buehler <jbuehler@hekimian.com>
Reply-To:  jbuehler@hekimian.com
Organization: Spirent Communications, Inc.
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: [PATCH] fix for process virtual size display
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00078.txt.bz2

I offer this trivial patch as a possible fix for "top" displaying
~400 megabytes as the virtual memory size for all processes.  This
happens because the WIN32 info used appears to refer to "reserved"
memory, not "committed", and Cygwin processes have about 400 megabytes
reserved by default (for the stack and/or heap, I forget at the moment).

Whether this is the right thing to do, I don't know.  The sizes
shown by "top" are now slightly smaller than the working set size.
Perhaps due to the way that dlls are counted in the two numbers?

Anyway, I offer this if it looks better than current behavior.

2003-05-09  Joe Buehler  <jhpb@draco.hekimian.com>

	* fhandler_process.cc (format_process_stat): use PagefileUsage instead of VirtualSize
	(get_mem_values): Ditto.

Index: fhandler_process.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v
retrieving revision 1.32
diff -u -r1.32 fhandler_process.cc
--- fhandler_process.cc	1 Apr 2003 16:11:41 -0000	1.32
+++ fhandler_process.cc	9 May 2003 14:54:39 -0000
@@ -475,7 +474,7 @@
  	 start_time = (spt.KernelTime.QuadPart + spt.UserTime.QuadPart) * HZ / 10000000ULL;
         priority = pbi.BasePriority;
         unsigned page_size = getpagesize ();
-       vmsize = vmc.VirtualSize;
+       vmsize = vmc.PagefileUsage;
         vmrss = vmc.WorkingSetSize / page_size;
         vmmaxrss = ql.MaximumWorkingSetSize / page_size;
      }
@@ -740,7 +743,7 @@
        res = false;
        goto out;
      }
-  *vmsize = vmc.VirtualSize / page_size;
+  *vmsize = vmc.PagefileUsage / page_size;
  out:
    delete [] p;
    CloseHandle (hProcess);
-- 
Joe Buehler
