Return-Path: <cygwin-patches-return-6884-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9409 invoked by alias); 9 Jan 2010 11:14:19 -0000
Received: (qmail 9367 invoked by uid 22791); 9 Jan 2010 11:14:16 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f222.google.com (HELO mail-ew0-f222.google.com) (209.85.219.222)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 09 Jan 2010 11:14:12 +0000
Received: by ewy22 with SMTP id 22so24059071ewy.19         for <cygwin-patches@cygwin.com>; Sat, 09 Jan 2010 03:14:09 -0800 (PST)
Received: by 10.213.24.25 with SMTP id t25mr561706ebb.73.1263035648909;         Sat, 09 Jan 2010 03:14:08 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm46859802eyb.18.2010.01.09.03.14.06         (version=SSLv3 cipher=RC4-MD5);         Sat, 09 Jan 2010 03:14:07 -0800 (PST)
Message-ID: <4B4868EF.8010301@gmail.com>
Date: Sat, 09 Jan 2010 11:14:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix multifarious bad pinfo accesses [was Re: Expect goes  crazy... spinning cpu in kill_pgrp]
Content-Type: multipart/mixed;  boundary="------------040602050108030501010704"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------040602050108030501010704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 4155

[ ref: http://cygwin.com/ml/cygwin-developers/2009-10/threads.html#00225 ]

    Hi all,

  This fixes the bug I was discussing in the referenced thread.  To summarize:

STC(*): Bootstrap gcc, then run make check at -j8 (or so).  At some point,
generally not too long into the run, one of the running expect instances will
go crazy and process creation will start failing everywhere else.

Bug: Expect hits a segfault while trying to abort.  The segfault leads to an
abort, which leads back to the same segfault, which tries again to abort... ad
infinitum.

Cause: The segfault happens when we try and look up the controlling tty of an
exec()ed program stub.  Here's the relevant class definition (comments,
function members and whitespace trimmed for clarity):

> class _pinfo
> {
> public:
>   pid_t pid;
>   DWORD process_state;
>   DWORD exitcode;	/* set when process exits */
> 
> #define PINFO_REDIR_SIZE ((char *) &myself.procinfo->exitcode - (char *) myself.procinfo)
> 
>   DWORD cygstarted;
>   pid_t ppid;
>   DWORD dwProcessId;
>   char progname[NT_MAX_PATH];
>   __uid32_t uid;	/* User ID */
>   __gid32_t gid;	/* Group ID */
>   pid_t pgid;		/* Process group ID */
>   pid_t sid;		/* Session ID */
>   int ctty;		/* Control tty */
>   bool has_pgid_children;/* True if we've forked or spawned children with our GID. */
>   long start_time;
>   struct rusage rusage_self;
>   struct rusage rusage_children;
>   int nice;
>   char stopsig;
 [ ... snip ... ]
>   /* signals */
>   HANDLE sendsig;
>   HANDLE exec_sendsig;
>   DWORD exec_dwProcessId;
> public:
>   HANDLE wr_proc_pipe;
>   DWORD wr_proc_pipe_owner;
>   friend class pinfo;
> };

  The salient point is that PINFO_REDIR_SIZE definition.  This is used in
pinfo::init() like so:

>       DWORD mapsize;
>       if (flag & PID_EXECED)
> 	mapsize = PINFO_REDIR_SIZE;
>       else
> 	mapsize = sizeof (_pinfo);
> 
>       procinfo = (_pinfo *) open_shared (L"cygpid", n, h0, mapsize, shloc,
> 					 sec_attribs, access);

  So, the idea is (iiuc) that if the current pinfo is for an exec()ed program
stub, there's no need for most of the data, so let's save some memory space
and PTEs by only mapping a reduced view of the start of the pinfo object,
containing only the pertinent data members.

  This is where the problem arises, because the segfault happens when trying
to access the 'ctty' member of an exec()ed pinfo.  As the second post in the
thread demonstrates, there are several places that access members of the
_pinfo beyond the end of the short mapping.  And even guarding those accesses
with tests against PID_EXECED state doesn't always help, because there's
always a TOCTOU race there; it would need proper inter-process locking to be
completely safe.

  That's rather top-heavy and undesirable though, but there's a simpler
answer.  Since this code was first written, a lot of the big data structs have
been moved out of _pinfo.  And whatever size of mapping you request with
PINFO_REDIR_SIZE, you've got a 4kB page granularity with a minimum of one
page, anyway.  If the ctty member had been before the big progname[] array
rather than after it, it would have been fallen within that one page.

  So, the attached patch just rearranges the order of data members so that all
the small data members go at the start, and are hence always available in both
sizes of _pinfo view mapping; just for correctness' sake, it also redefines
PINFO_REDIR_SIZE to match the actual end of the small data members.  This
should mean that no more system resources of any kind are used than was
originally the case, but all the required data is available when needed.

winsup/cygwin/ChangeLog:

	* pinfo.h (_pinfo::progname[]): Move to end.
	(PINFO_REDIR_SIZE): Redefine to point up to start of
	progname[] member.

  I've now had a gcc testrun going at -j8 all night with no sign of the old
race condition; it's never made it a fraction this far before without falling
down^W^Wgetting splatted by a falling hippo.  I'm pretty sure that I've got it
this time; OK for head?

    cheers,
      DaveK
-- 
(*) - For sufficiently complex values of simple.  Sorry I don't have a real
testcase.

--------------040602050108030501010704
Content-Type: text/x-c;
 name="pinfo-race-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pinfo-race-fix.diff"
Content-length: 1266

Index: winsup/cygwin/pinfo.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.h,v
retrieving revision 1.109
diff -p -u -r1.109 pinfo.h
--- winsup/cygwin/pinfo.h	6 Oct 2009 21:51:17 -0000	1.109
+++ winsup/cygwin/pinfo.h	9 Jan 2010 05:28:30 -0000
@@ -50,8 +50,6 @@ public:
 
   DWORD exitcode;	/* set when process exits */
 
-#define PINFO_REDIR_SIZE ((char *) &myself.procinfo->exitcode - (char *) myself.procinfo)
-
   /* > 0 if started by a cygwin process */
   DWORD cygstarted;
 
@@ -63,9 +61,6 @@ public:
     signals.  */
   DWORD dwProcessId;
 
-  /* Used to spawn a child for fork(), among other things. */
-  char progname[NT_MAX_PATH];
-
   /* User information.
      The information is derived from the GetUserName system call,
      with the name looked up in /etc/passwd and assigned a default value
@@ -120,6 +115,12 @@ public:
   HANDLE wr_proc_pipe;
   DWORD wr_proc_pipe_owner;
   friend class pinfo;
+
+  /* Used to spawn a child for fork(), among other things. */
+  char progname[NT_MAX_PATH];
+  /* Truncate it after execed process exits. */
+#define PINFO_REDIR_SIZE ((char *) &myself.procinfo->progname[0] - (char *) myself.procinfo)
+
 };
 
 DWORD WINAPI commune_process (void *);

--------------040602050108030501010704--
