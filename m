Return-Path: <cygwin-patches-return-3665-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30168 invoked by alias); 2 Mar 2003 15:40:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30158 invoked from network); 2 Mar 2003 15:40:14 -0000
Date: Sun, 02 Mar 2003 15:40:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: Re: PATCH: Implements /proc/cpuinfo and /proc/partitions
Message-ID: <20030302154006.GH1193@cygbert.vinschen.de>
Mail-Followup-To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
References: <LPEHIHGCJOAIPFLADJAHAEADDGAA.chris@atomice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LPEHIHGCJOAIPFLADJAHAEADDGAA.chris@atomice.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00314.txt.bz2

On Sun, Mar 02, 2003 at 12:50:51PM -0000, Chris January wrote:
> 2003-03-01  Christopher January  <chris@atomice.net>
> 
> 	* autoload.cc (GetSystemTimes): Define new autoload function. 
> 	* fhandler_proc.cc (proc_listing): Add cpuinfo and partitions entries.
> 	(fhandler_proc::fill_filebuf): Add PROC_CPUINFO and PROC_PARTITIONS cases.
> 	(format_proc_uptime): Use GetSystemTimes if available.
> 	(read_value): New macro.
> 	(print): New macro.
> 	(cpuid): New function.
> 	(can_set_flag): New function.
> 	(format_proc_cpuinfo): New function.
> 	(format_proc_partitions): New function.
> 	* w32api/include/winbase.h (FindFirstVolume): Add declaration.
> 	(FindNextVolume): Add declaration.
> 	(FindVolumeClose): Add declaration.
> 	(GetSystemTimes): Add declaration.
> 	* w32api/include/winnt.h: Add define for PF_XMMI64_INSTRUCTIONS_AVAILABLE.

I tried this patch and it works nicely but the patch creates a couple of
warnings at compile time:

fhandler_proc.cc: In function `off_t format_proc_cpuinfo(char*, unsigned int)':
fhandler_proc.cc:683: warning: unused variable `unsigned int extended_family'
fhandler_proc.cc:684: warning: unused variable `unsigned int extended_model'
fhandler_proc.cc:672: warning: unused variable `unsigned int cpuid_sig'
fhandler_proc.cc:672: warning: unused variable `unsigned int extra_info'
fhandler_proc.cc:672: warning: unused variable `unsigned int features'
fhandler_proc.cc:625: warning: unused variable `int cpu'
fhandler_proc.cc:625: warning: unused variable `int r1'
fhandler_proc.cc:625: warning: unused variable `int r2'
fhandler_proc.cc: In function `off_t format_proc_partitions(char*, unsigned int)':
fhandler_proc.cc:906: warning: comparison between signed and unsigned integer expressions

Would you mind to send a new patch w/o these warnings?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
