Return-Path: <cygwin-patches-return-3678-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23685 invoked by alias); 9 Mar 2003 20:11:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23676 invoked from network); 9 Mar 2003 20:11:36 -0000
Date: Sun, 09 Mar 2003 20:11:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH: Implements /proc/cpuinfo and /proc/partitions
Message-ID: <20030309201136.GA11496@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030302154006.GH1193@cygbert.vinschen.de> <LPEHIHGCJOAIPFLADJAHMEFADGAA.chris@atomice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LPEHIHGCJOAIPFLADJAHMEFADGAA.chris@atomice.net>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00327.txt.bz2

On Thu, Mar 06, 2003 at 10:58:31PM -0000, Chris January wrote:
>2003-03-06  Christopher January  <chris@atomice.net>
>
>	* autoload.cc (GetSystemTimes): Define new autoload function. 
>	* fhandler_proc.cc (proc_listing): Add cpuinfo and partitions entries.
>	(fhandler_proc::fill_filebuf): Add PROC_CPUINFO and PROC_PARTITIONS cases.
>	(format_proc_uptime): Use GetSystemTimes if available.
>	(read_value): New macro.
>	(print): New macro.
>	(cpuid): New function.
>	(can_set_flag): New function.
>	(format_proc_cpuinfo): New function.
>	(format_proc_partitions): New function.

Applied, with some minor reformatting (comment style, trailing '&&',
protection of read_value and print macros).

Thanks.
cgf
