Return-Path: <cygwin-patches-return-3859-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19226 invoked by alias); 19 May 2003 21:44:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19195 invoked from network); 19 May 2003 21:44:00 -0000
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] fix for process virtual size display
Date: Mon, 19 May 2003 21:44:00 -0000
Message-ID: <ICEBIHGCEJIPLNMBNCMKOEFACGAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20030519013751.GA10987@redhat.com>
Importance: Normal
X-SW-Source: 2003-q2/txt/msg00086.txt.bz2

> Ping.
Sorry, I've been very busy recently.

I'm actually inclined to keep vmc.VirtualSize instead of vmc.PagefileUsage.
However I found this formula cited in one of the Linux man pages:
          vsize=(brk-start_code+PAGE_SIZE-1)+(TASK_SIZE-esp)
which would seem to indicate vmsize actually refers to committed memory.
With this in mind, I'm happy for this patch to be committed. Further work
may be
needed to include DLLs in that figure, however that would be a separate
patch.

Chris

>
> cgf
>
> On Fri, May 09, 2003 at 11:06:28AM -0400, Christopher Faylor wrote:
> >On Fri, May 09, 2003 at 11:04:27AM -0400, Joe Buehler wrote:
> >>I offer this trivial patch as a possible fix for "top" displaying
> >>~400 megabytes as the virtual memory size for all processes.  This
> >>happens because the WIN32 info used appears to refer to "reserved"
> >>memory, not "committed", and Cygwin processes have about 400 megabytes
> >>reserved by default (for the stack and/or heap, I forget at the moment).
> >>
> >>Whether this is the right thing to do, I don't know.  The sizes
> >>shown by "top" are now slightly smaller than the working set size.
> >>Perhaps due to the way that dlls are counted in the two numbers?
> >>
> >>Anyway, I offer this if it looks better than current behavior.
> >>
> >>2003-05-09  Joe Buehler  <jhpb@draco.hekimian.com>
> >>
> >>	* fhandler_process.cc (format_process_stat): use PagefileUsage
> >>	instead of VirtualSize
> >>	(get_mem_values): Ditto.
> >
> >Looks good to me but I'd like Chris January to comment since this is his
> >code.
> >
> >cgf
> >
> >>Index: fhandler_process.cc
> >>===================================================================
> >>RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v
> >>retrieving revision 1.32
> >>diff -u -r1.32 fhandler_process.cc
> >>--- fhandler_process.cc	1 Apr 2003 16:11:41 -0000	1.32
> >>+++ fhandler_process.cc	9 May 2003 14:54:39 -0000
> >>@@ -475,7 +474,7 @@
> >> 	 start_time = (spt.KernelTime.QuadPart +
> spt.UserTime.QuadPart) * HZ
> >> 	 / 10000000ULL;
> >>        priority = pbi.BasePriority;
> >>        unsigned page_size = getpagesize ();
> >>-       vmsize = vmc.VirtualSize;
> >>+       vmsize = vmc.PagefileUsage;
> >>        vmrss = vmc.WorkingSetSize / page_size;
> >>        vmmaxrss = ql.MaximumWorkingSetSize / page_size;
> >>     }
> >>@@ -740,7 +743,7 @@
> >>       res = false;
> >>       goto out;
> >>     }
> >>-  *vmsize = vmc.VirtualSize / page_size;
> >>+  *vmsize = vmc.PagefileUsage / page_size;
> >> out:
> >>   delete [] p;
> >>   CloseHandle (hProcess);
> >>--
> >>Joe Buehler
>
>
