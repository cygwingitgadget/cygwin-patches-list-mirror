Return-Path: <cygwin-patches-return-3852-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20398 invoked by alias); 9 May 2003 15:06:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20298 invoked from network); 9 May 2003 15:06:32 -0000
Date: Fri, 09 May 2003 15:06:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix for process virtual size display
Message-ID: <20030509150628.GA19612@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3EBBC37B.7020300@hekimian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBBC37B.7020300@hekimian.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00079.txt.bz2

On Fri, May 09, 2003 at 11:04:27AM -0400, Joe Buehler wrote:
>I offer this trivial patch as a possible fix for "top" displaying
>~400 megabytes as the virtual memory size for all processes.  This
>happens because the WIN32 info used appears to refer to "reserved"
>memory, not "committed", and Cygwin processes have about 400 megabytes
>reserved by default (for the stack and/or heap, I forget at the moment).
>
>Whether this is the right thing to do, I don't know.  The sizes
>shown by "top" are now slightly smaller than the working set size.
>Perhaps due to the way that dlls are counted in the two numbers?
>
>Anyway, I offer this if it looks better than current behavior.
>
>2003-05-09  Joe Buehler  <jhpb@draco.hekimian.com>
>
>	* fhandler_process.cc (format_process_stat): use PagefileUsage 
>	instead of VirtualSize
>	(get_mem_values): Ditto.

Looks good to me but I'd like Chris January to comment since this is his
code.

cgf

>Index: fhandler_process.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v
>retrieving revision 1.32
>diff -u -r1.32 fhandler_process.cc
>--- fhandler_process.cc	1 Apr 2003 16:11:41 -0000	1.32
>+++ fhandler_process.cc	9 May 2003 14:54:39 -0000
>@@ -475,7 +474,7 @@
> 	 start_time = (spt.KernelTime.QuadPart + spt.UserTime.QuadPart) * HZ 
> 	 / 10000000ULL;
>        priority = pbi.BasePriority;
>        unsigned page_size = getpagesize ();
>-       vmsize = vmc.VirtualSize;
>+       vmsize = vmc.PagefileUsage;
>        vmrss = vmc.WorkingSetSize / page_size;
>        vmmaxrss = ql.MaximumWorkingSetSize / page_size;
>     }
>@@ -740,7 +743,7 @@
>       res = false;
>       goto out;
>     }
>-  *vmsize = vmc.VirtualSize / page_size;
>+  *vmsize = vmc.PagefileUsage / page_size;
> out:
>   delete [] p;
>   CloseHandle (hProcess);
>-- 
>Joe Buehler
