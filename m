Return-Path: <cygwin-patches-return-3664-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11836 invoked by alias); 2 Mar 2003 14:10:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11827 invoked from network); 2 Mar 2003 14:10:34 -0000
Message-ID: <3E6210D6.4000802@yahoo.com>
Date: Sun, 02 Mar 2003 14:10:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To:  cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris January <chris@atomice.net>
CC: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: Re: PATCH: Implements /proc/cpuinfo and /proc/partitions
References: <LPEHIHGCJOAIPFLADJAHAEADDGAA.chris@atomice.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00313.txt.bz2

Please separate the w32api patches into a different patch set.

Thanks.

Chris January wrote:
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
> 
> ---
> Christopher January www.atomice.com
