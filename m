Return-Path: <cygwin-patches-return-7237-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22895 invoked by alias); 1 Apr 2011 10:06:20 -0000
Received: (qmail 22867 invoked by uid 22791); 1 Apr 2011 10:06:06 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 01 Apr 2011 10:05:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E4C112C0302; Fri,  1 Apr 2011 12:05:56 +0200 (CEST)
Date: Fri, 01 Apr 2011 10:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] implement /proc/sysvipc/*
Message-ID: <20110401100556.GB24008@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301650256.3108.4.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1301650256.3108.4.camel@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00003.txt.bz2

On Apr  1 04:30, Yaakov (Cygwin/X) wrote:
> These patches implement /proc/sysvipc/*, as found on Linux[1]:
> 
> $ ls -l /proc
> [...]
> dr-xr-xr-x 2 Yaakov         None           0 Apr  1 04:12 sysvipc/
> [...]
> 
> $ ls -l /proc/sysvipc
> total 0
> -r--r--r-- 1 Yaakov None 0 Apr  1 04:12 msg
> -r--r--r-- 1 Yaakov None 0 Apr  1 04:12 sem
> -r--r--r-- 1 Yaakov None 0 Apr  1 04:12 shm
> 
> # yes, these lines are very long
> $ cat /proc/sysvipc/shm 
>        key      shmid perms       size  cpid  lpid nattch   uid   gid cuid   cgid      atime      dtime      ctime
>          0     196608  6600     393216  4960  4996      2  1001   513  1001   513 1301639749          0 1301639749
>          0      65537  6600     393216  4916  4996      2  1001   513  1001   513 1301639750          0 1301639750
> [...]
> 
> If cygserver is not running, then the /proc/sysvipc directory still
> exists but readdir()s as empty, and the files therein are nonexistent:
> 
> $ ls /proc/sysvipc/
> 
> $ ls /proc/sysvipc/shm
> ls: cannot access /proc/sysvipc/sem: No such file or directory
> 
> $ cat /proc/sysvipc/shm
> cat: /proc/sysvipc/shm: No such file or directory
> 
> The code uses some hints from the Cygwin modifications to ipcs(1).
> 
> Patch and new file for winsup/cygwin, and patch for winsup/doc attached.
> 
> 
> Yaakov
> 
> 
> [1] http://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/4/html/Reference_Guide/s2-proc-dir-sysvipc.html
> 

> 2011-04-01  Yaakov Selkowitz  <...>
> 
> 	* new-features.sgml (ov-new1.7.10): Document /proc/sysvipc/.
> 

> 2011-04-01  Yaakov Selkowitz  <...<
> 
> 	Implement /proc/sysvipc/*
> 	* devices.in (dev_procsysvipc_storage): Add.
> 	* devices.cc: Regenerate.
> 	* devices.h (fh_devices): Add FH_PROCSYSVIPC.
> 	* dtable.cc (build_fh_pc): Add case FH_PROCSYSVIPC.
> 	* fhandler.h (class fhandler_procsysvipc): Declare.
> 	(fhandler_union): Add __procsysvipc.
> 	* fhandler_proc.cc (proc_tab): Add sysvipc virt_directory.
> 	* fhandler_procsysvipc.cc: New file.
> 	* Makefile.in (DLL_OFILES): Add fhandler_procsysvipc.o.
> 	* path.h (isproc_dev): Add FH_PROCSYSVIPC to conditional.

Cool stuff.  Thanks for this patch.  However, your patch shows a
problem:

> Index: path.h
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/path.h,v
> retrieving revision 1.154
> diff -u -r1.154 path.h
> --- path.h	17 Jan 2011 14:19:39 -0000	1.154
> +++ path.h	20 Feb 2011 08:24:53 -0000
> @@ -19,7 +19,7 @@
>  
>  #define isproc_dev(devn) \
>    (devn == FH_PROC || devn == FH_REGISTRY || devn == FH_PROCESS || \
> -   devn == FH_PROCNET || devn == FH_PROCSYS)
> +   devn == FH_PROCNET || devn == FH_PROCSYS || devn == FH_PROCSYSVIPC)

The definition of isproc_dev starts to get on my nerves.  We have to
check for six distinct values now.  I think we should really change
the definition.  Here's what we have in devices.h right now:

  FH_PROC    = FHDEV (0, 250),
  FH_REGISTRY= FHDEV (0, 249),
  FH_PROCESS = FHDEV (0, 248),

  FH_FS      = FHDEV (0, 247),  /* filesystem based device */
    
  FH_NETDRIVE= FHDEV (0, 246),
  FH_DEV     = FHDEV (0, 245),
  FH_PROCNET = FHDEV (0, 244),
  FH_PROCESSFD = FHDEV (0, 243),
  FH_PROCSYS = FHDEV (0, 242),
  FH_PROCSYSVIPC = FHDEV (0, 241),

Chris, do you think there's anything speaking against rearranging this
so that the FH_FS and FH_NETDRIVE definitions are separate from the
stuff under /proc?  Or, hang on, we should change all PROC values,
along these lines:

  FH_FS      = FHDEV (0, 247),  /* filesystem based device */
  FH_NETDRIVE= FHDEV (0, 246),
  FH_DEV     = FHDEV (0, 245),

  FH_PROC    = FHDEV (0, 244),
  FH_REGISTRY= FHDEV (0, 243),
  FH_PROCESS = FHDEV (0, 242),
  FH_PROCNET = FHDEV (0, 241),
  FH_PROCESSFD = FHDEV (0, 240),
  FH_PROCSYS = FHDEV (0, 239),
  FH_PROCSYSVIPC = FHDEV (0, 238),

  FH_PROC_MIN_MINOR = FHDEV (0, 200),	/* Arbitrary value */

Then we can simplify the isproc_dev definition like this:

#define isproc_dev(devn) \
	(devn >= FH_PROC_MIN_MINOR && devn <= FH_PROC)

Does that sound ok?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
