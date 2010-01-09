Return-Path: <cygwin-patches-return-6890-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16492 invoked by alias); 9 Jan 2010 16:37:31 -0000
Received: (qmail 16477 invoked by uid 22791); 9 Jan 2010 16:37:29 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-52-118.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.52.118)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 09 Jan 2010 16:37:25 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 4CF0313C0C7 	for <cygwin-patches@cygwin.com>; Sat,  9 Jan 2010 11:37:15 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id E53932B35A; Sat,  9 Jan 2010 11:37:14 -0500 (EST)
Date: Sat, 09 Jan 2010 16:37:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix multifarious bad pinfo accesses [was Re: Expect  goes  crazy... spinning cpu in kill_pgrp]
Message-ID: <20100109163714.GA12815@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B4868EF.8010301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B4868EF.8010301@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00006.txt.bz2

On Sat, Jan 09, 2010 at 11:30:55AM +0000, Dave Korn wrote:
>[ ref: http://cygwin.com/ml/cygwin-developers/2009-10/threads.html#00225 ]
>
>    Hi all,
>
>  This fixes the bug I was discussing in the referenced thread.  To summarize:
>
>STC(*): Bootstrap gcc, then run make check at -j8 (or so).  At some point,
>generally not too long into the run, one of the running expect instances will
>go crazy and process creation will start failing everywhere else.
>
>Bug: Expect hits a segfault while trying to abort.  The segfault leads to an
>abort, which leads back to the same segfault, which tries again to abort... ad
>infinitum.
>
>Cause: The segfault happens when we try and look up the controlling tty of an
>exec()ed program stub.  Here's the relevant class definition (comments,
>function members and whitespace trimmed for clarity):
>
>> class _pinfo
>> {
>> public:
>>   pid_t pid;
>>   DWORD process_state;
>>   DWORD exitcode;	/* set when process exits */
>> 
>> #define PINFO_REDIR_SIZE ((char *) &myself.procinfo->exitcode - (char *) myself.procinfo)
>> 
>>   DWORD cygstarted;
>>   pid_t ppid;
>>   DWORD dwProcessId;
>>   char progname[NT_MAX_PATH];
>>   __uid32_t uid;	/* User ID */
>>   __gid32_t gid;	/* Group ID */
>>   pid_t pgid;		/* Process group ID */
>>   pid_t sid;		/* Session ID */
>>   int ctty;		/* Control tty */
>>   bool has_pgid_children;/* True if we've forked or spawned children with our GID. */
>>   long start_time;
>>   struct rusage rusage_self;
>>   struct rusage rusage_children;
>>   int nice;
>>   char stopsig;
> [ ... snip ... ]
>>   /* signals */
>>   HANDLE sendsig;
>>   HANDLE exec_sendsig;
>>   DWORD exec_dwProcessId;
>> public:
>>   HANDLE wr_proc_pipe;
>>   DWORD wr_proc_pipe_owner;
>>   friend class pinfo;
>> };
>
>  The salient point is that PINFO_REDIR_SIZE definition.  This is used in
>pinfo::init() like so:
>
>>       DWORD mapsize;
>>       if (flag & PID_EXECED)
>> 	mapsize = PINFO_REDIR_SIZE;
>>       else
>> 	mapsize = sizeof (_pinfo);
>> 
>>       procinfo = (_pinfo *) open_shared (L"cygpid", n, h0, mapsize, shloc,
>> 					 sec_attribs, access);
>
>So, the idea is (iiuc) that if the current pinfo is for an exec()ed
>program stub, there's no need for most of the data, so let's save some
>memory space and PTEs by only mapping a reduced view of the start of
>the pinfo object, containing only the pertinent data members.
>
>This is where the problem arises, because the segfault happens when
>trying to access the 'ctty' member of an exec()ed pinfo.

These abbreviated records are not supposed to be accessed for things
like "ctty" since it could be irrelevant.  If something is attempting to
access the ctty then it is wrong and that's what needs to be fixed.

One of the reasons for keeping an abbreviated structure is to catch
situations like this, in fact.

>As the second post in the thread demonstrates, there are several places
>that access members of the _pinfo beyond the end of the short mapping.
>And even guarding those accesses with tests against PID_EXECED state
>doesn't always help, because there's always a TOCTOU race there; it
>would need proper inter-process locking to be completely safe.

True, but you still have a problem if you're accessing a pinfo structure
which is referencing a soon-to-be-execed process.  You could be sending
signals to it or attempting to otherwise manipulate it.

>That's rather top-heavy and undesirable though, but there's a simpler
>answer.  Since this code was first written, a lot of the big data
>structs have been moved out of _pinfo.  And whatever size of mapping
>you request with PINFO_REDIR_SIZE, you've got a 4kB page granularity
>with a minimum of one page, anyway.  If the ctty member had been before
>the big progname[] array rather than after it, it would have been
>fallen within that one page.

But you'd still be accessing ctty incorrectly.

>  So, the attached patch just rearranges the order of data members so that all
>the small data members go at the start, and are hence always available in both
>sizes of _pinfo view mapping; just for correctness' sake, it also redefines
>PINFO_REDIR_SIZE to match the actual end of the small data members.  This
>should mean that no more system resources of any kind are used than was
>originally the case, but all the required data is available when needed.
>
>winsup/cygwin/ChangeLog:
>
>	* pinfo.h (_pinfo::progname[]): Move to end.
>	(PINFO_REDIR_SIZE): Redefine to point up to start of
>	progname[] member.
>
>  I've now had a gcc testrun going at -j8 all night with no sign of the old
>race condition; it's never made it a fraction this far before without falling
>down^W^Wgetting splatted by a falling hippo.  I'm pretty sure that I've got it
>this time; OK for head?

I'd prefer something like this:

--- pinfo.cc    18 Dec 2009 20:32:04 -0000      1.258
+++ pinfo.cc    9 Jan 2010 16:35:47 -0000
@@ -416,7 +416,7 @@
 bool __stdcall
 _pinfo::exists ()
 {
-  return this && !(process_state & PID_EXITED);
+  return this && !(process_state & (PID_EXITED | PID_EXECED));
 }

 bool

That says that an execed "pinfo" doesn't really exist if it has been
execed.  If that causes a few problems to be fixed up, that's ok.  I'd
rather fix those than lie about the ctty of a nonexistent process.

cgf
