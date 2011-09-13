Return-Path: <cygwin-patches-return-7509-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32606 invoked by alias); 13 Sep 2011 15:31:56 -0000
Received: (qmail 32594 invoked by uid 22791); 13 Sep 2011 15:31:55 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm16.bullet.mail.sp2.yahoo.com (HELO nm16.bullet.mail.sp2.yahoo.com) (98.139.91.86)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 13 Sep 2011 15:31:14 +0000
Received: from [98.139.91.61] by nm16.bullet.mail.sp2.yahoo.com with NNFMP; 13 Sep 2011 15:31:13 -0000
Received: from [208.71.42.209] by tm1.bullet.mail.sp2.yahoo.com with NNFMP; 13 Sep 2011 15:31:13 -0000
Received: from [127.0.0.1] by smtp220.mail.gq1.yahoo.com with NNFMP; 13 Sep 2011 15:31:13 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@72.70.43.200 with login)        by smtp220.mail.gq1.yahoo.com with SMTP; 13 Sep 2011 08:31:13 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 2375113C00B	for <cygwin-patches@cygwin.com>; Tue, 13 Sep 2011 11:31:12 -0400 (EDT)
Date: Tue, 13 Sep 2011 15:31:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix strace tracing of forked processes when attaching to a process with --pid
Message-ID: <20110913153112.GB22603@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E6E0710.4000909@dronecode.org.uk> <4E6F46E7.5080108@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E6F46E7.5080108@dronecode.org.uk>
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
X-SW-Source: 2011-q3/txt/msg00085.txt.bz2

On Tue, Sep 13, 2011 at 01:04:55PM +0100, Jon TURNEY wrote:
>
>At the moment, --trace-children (enabled by default) only works when the 
>straced process is started by using strace with a command line.
>
>This patch uses the undocumented NtSetInformationProcess(ProcessDebugFlags) 
>call to make --trace-children work when attaching to a process with --pid
>
>This patch removes the explicit DebugActiveProcess() on each child process: In 
>my testing this was not needed when the process was created using 
>CreateProcess() with the DEBUG_PROCESS flag, and failed error 87 when a 
>process had been attached to with DebugActiveProcess() and then had the 
>DEBUG_ONLY_THIS_PROCESS flag cleared.
>
>In the alternative, the man page should be fixed to mention that tracing
>child  processes is only possible when using a command line and not with --pid.
>
>2011-09-12  Jon TURNEY  <jon.turney@dronecode.org.uk>
>
>	* strace.cc (attach_process): Try to turn off DEBUG_ONLY_THIS_PROCESS
>	if attaching to a process with the forkdebug flag set.
>	(handle_output_debug_string): Apparently we don't need to explicitly
>	attach for debugging when a child process starts
>	* Makefile.in (strace.exe): Link with ntdll
>

Looks good.  Please check in.

Thanks.

cgf
