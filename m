Return-Path: <SRS0=5WD9=G6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 1E8954BB5924
	for <cygwin-patches@cygwin.com>; Sun,  6 Sep 2026 11:17:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1E8954BB5924
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1E8954BB5924
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788693476; cv=none;
	b=c4M7EzaIH3G1+wTRCJnojm38WLrZBIPVzJ6kYyeIT6m4DPpgfm3080fAPHzhRHoc7GmFqsTe2HnEg5dohfziRF/d+3vjwHY0sxu9wlc2jrAg8UMFZ+XtsfiwU3mvMhUNCQgRzg56oXCLGJBHREiz7kMjeWm/namgFrXPwB+9WxU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788693476; c=relaxed/simple;
	bh=W2WKL9x0PqSTsmWYU/vwDqDmQcKb8KQ++5+YGb6U8bY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=O1Ppge7VbylcEAJw47diOQYcRbXilNBv0M5bLAJexP4rNXRl/I/fNHekrtOuqPZThTbXOw0bVmhQ32d4kdI7aH9r4pcmn9M0Ar6WOChyvGayyh/aonZxzjUVclvTY+IBACQeznabpUu0OmIwO+g0nCBbDJb3xSIDJpj4YzFWItc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JmmuKGOR
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1E8954BB5924
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JmmuKGOR
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260906111753777.FHCI.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 6 Sep 2026 20:17:53 +0900
Date: Sun, 6 Sep 2026 20:17:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: proc: Provides correct number of thread rather
 than 0
Message-Id: <20260906201751.b2d707daf31d453c581ddbe0@nifty.ne.jp>
In-Reply-To: <4b926817-53b0-4ef6-b1f5-23f15a2c94ff@maxrnd.com>
References: <20260904012457.466-1-takashi.yano@nifty.ne.jp>
	<4b926817-53b0-4ef6-b1f5-23f15a2c94ff@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1788693473;
 bh=66ZlVOIvp1sPyD7PjxQplSqr4/SyHdeu7DKyTOwO3ig=;
 h=Date:From:To:Subject:In-Reply-To;
 b=JmmuKGORDwqJ7EEVHGjPJ+VAaP71dc3lJrWkVxJLekZ/tqDuwJn1ZpSV+LRJBuPfsMztqmDe
 wkXjWZJldYj4NezRldo7hO2futicwKRe77dot8N2J8JDB4IQwSptHiJavBsGS2Yric+IQ3hLzA
 ILeuyi1afZZQayxMTzrv+YjPkOfG+9QMTqq/A0KvBm2xp/MKt+vpNPDYHkOD614K11Ig1aTDd0
 1xF7ku+NfY03UTNNrJbx5NZrl9KxyK8XYlWoCu2pkdigfY9NRpW8ZyLmhe2sZDJs1QJD8N+Lkr
 J0ydfGg4S4jZAtKtme6Mt2+z1u328FfvGLz0B6GCfrPb9J7A==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_NUMSUBJECT,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Thanks for the review.

On Fri, 4 Sep 2026 23:38:28 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 9/3/2026 6:24 PM, Takashi Yano wrote:
> > Currently, /proc/<pid>/stat always reports 0 as the number of thread.
> > However, get_process_state() does know the thread count for the
> > process, so expose that value in /proc/<pid>/stat. Additionally, add
> > a "Threads:" entry to /proc/<pid>/status.
> 
> A Fixes: line is needed around here.

Added.

> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >   winsup/cygwin/fhandler/proc.cc    |  4 ++--
> >   winsup/cygwin/fhandler/process.cc | 18 ++++++++++++------
> >   winsup/cygwin/release/3.7.0       |  3 +++
> >   3 files changed, 17 insertions(+), 8 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
> > index f1cd468fc..12a43afe2 100644
> > --- a/winsup/cygwin/fhandler/proc.cc
> > +++ b/winsup/cygwin/fhandler/proc.cc
> > @@ -437,12 +437,12 @@ format_proc_version (void *, char *&destbuf)
> >   static off_t
> >   format_proc_loadavg (void *, char *&destbuf)
> >   {
> > -  extern int get_process_state (DWORD dwProcessId);
> > +  extern int get_process_state (DWORD dwProcessId, DWORD *num_threads);
> >     unsigned int running = 0;
> >     winpids pids ((DWORD) 0);
> >   
> >     for (unsigned i = 0; i < pids.npids; i++)
> > -    switch (get_process_state (pids[i]->dwProcessId)) {
> > +    switch (get_process_state (pids[i]->dwProcessId, NULL)) {
> >         case 'O':
> >         case 'R':
> >   	running++;
> > diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
> > index e00cae58d..537a4b370 100644
> > --- a/winsup/cygwin/fhandler/process.cc
> > +++ b/winsup/cygwin/fhandler/process.cc
> > @@ -81,7 +81,7 @@ static const virt_tab_t process_tab[] =
> >   
> >   static const int PROCESS_LINK_COUNT =
> >     (sizeof (process_tab) / sizeof (virt_tab_t)) - 1;
> > -int get_process_state (DWORD dwProcessId);
> > +int get_process_state (DWORD dwProcessId, DWORD *num_threads);
> >   static bool get_mem_values (DWORD dwProcessId, size_t &vmsize, size_t &vmrss,
> >   			    size_t &vmtext, size_t &vmdata, size_t &vmlib,
> >   			    size_t &vmshare);
> > @@ -1121,6 +1121,7 @@ format_process_stat (void *data, char *&destbuf)
> >   {
> >     _pinfo *p = (_pinfo *) data;
> >     char cmd[NAME_MAX + 1];
> > +  DWORD num_threads = 0;
> >     int state = 'R';
> >     unsigned long fault_count = 0UL,
> >   		vmsize = 0UL, vmrss = 0UL, vmmaxrss = 0UL;
> > @@ -1155,7 +1156,7 @@ format_process_stat (void *data, char *&destbuf)
> >     else if (p->process_state & PID_STOPPED)
> >       state = 'T';
> >     else
> > -    state = get_process_state (p->dwProcessId);
> > +    state = get_process_state (p->dwProcessId, &num_threads);
> >   
> >     int nice = 0, prio = 0;
> >   
> > @@ -1241,14 +1242,14 @@ format_process_stat (void *data, char *&destbuf)
> >   				   "%d %d %d %d "
> >   				   "%d %u %lu %lu %u %u "
> >   				   "%U %U %U %U "
> > -				   "%d %d %d %d "
> > +				   "%d %d %u %d "
> >   				   "%U "
> >   				   "%lu %ld %lu\n",
> >   			  p->pid, cmd, state,
> >   			  p->ppid, p->pgid, p->sid, tty_nr,
> >   			  -1, 0, fault_count, fault_count, 0, 0,
> >   			  utime, stime, utime, stime,
> > -			  prio, nice, 0, 0,
> > +			  prio, nice, num_threads, 0,
> >   			  start_time,
> >   			  vmsize, vmrss, vmmaxrss
> >   			  );
> > @@ -1259,6 +1260,7 @@ format_process_status (void *data, char *&destbuf)
> >   {
> >     _pinfo *p = (_pinfo *) data;
> >     char cmd[NAME_MAX + 1];
> > +  DWORD num_threads = 0;
> >     int state = 'R';
> >     const char *state_str = "unknown";
> >     size_t vmsize = 0, vmrss = 0, vmdata = 0, vmlib = 0, vmtext = 0, vmshare = 0;
> > @@ -1281,7 +1283,7 @@ format_process_status (void *data, char *&destbuf)
> >     else if (p->process_state & PID_STOPPED)
> >       state = 'T';
> >     else
> > -    state = get_process_state (p->dwProcessId);
> > +    state = get_process_state (p->dwProcessId, &num_threads);
> >     switch (state)
> >       {
> >       case 'O':
> > @@ -1327,6 +1329,7 @@ format_process_status (void *data, char *&destbuf)
> >   				   "VmStk:\t%8lu kB\n"
> >   				   "VmExe:\t%8lu kB\n"
> >   				   "VmLib:\t%8lu kB\n"
> > +				   "Threads:\t%u\n"
> >   				   "SigPnd:\t%016lx\n"
> >   				   "SigBlk:\t%016lx\n"
> >   				   "SigIgn:\t%016lx\n",
> > @@ -1340,6 +1343,7 @@ format_process_status (void *data, char *&destbuf)
> >   			  vmsize * kb_per_page, 0UL, vmrss * kb_per_page,
> >   			  vmdata * kb_per_page, 0UL, vmtext * kb_per_page,
> >   			  vmlib * kb_per_page,
> > +			  num_threads,
> >   			  pnd, blk, ign
> >   			  );
> >   }
> > @@ -1516,7 +1520,7 @@ format_process_mountinfo (void *data, char *&destbuf)
> >   }
> >   
> >   int
> > -get_process_state (DWORD dwProcessId)
> > +get_process_state (DWORD dwProcessId, DWORD *num_threads)
> >   {
> >     /* This isn't really heavy magic - just go through the processes' threads
> >        one by one and return a value accordingly.  Errors are silently ignored. */
> > @@ -1554,6 +1558,8 @@ get_process_state (DWORD dwProcessId)
> >   	{
> >   	  SYSTEM_THREADS *st;
> >   	  st = &sp->Threads[0];
> > +	  if (num_threads)
> > +	    *num_threads = sp->NumberOfThreads;
> >   	  state = 'S';
> >   	  for (unsigned i = 0; i < sp->NumberOfThreads; i++)
> >   	    {
> > diff --git a/winsup/cygwin/release/3.7.0 b/winsup/cygwin/release/3.7.0
> > index 3f6a0ecd7..831c8d189 100644
> > --- a/winsup/cygwin/release/3.7.0
> > +++ b/winsup/cygwin/release/3.7.0
> > @@ -26,6 +26,9 @@ What's new:
> >     runs on a pty rather than on the console device originating from the pseudo
> >     console.
> >   
> > +- Expose the number of threads in the process in /proc/<pid>/stat and
> > +  /proc/<pid>/status.
> > +
> >   Fixes:
> >   ------
> >   
> 
> The code update LGTM.  Thanks for resolving this issue.

Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
