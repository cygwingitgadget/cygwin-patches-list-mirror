Return-Path: <cygwin-patches-return-7414-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10505 invoked by alias); 30 May 2011 06:25:06 -0000
Received: (qmail 10491 invoked by uid 22791); 30 May 2011 06:25:05 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm6-vm0.bullet.mail.ne1.yahoo.com (HELO nm6-vm0.bullet.mail.ne1.yahoo.com) (98.138.91.54)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 30 May 2011 06:24:51 +0000
Received: from [98.138.90.52] by nm6.bullet.mail.ne1.yahoo.com with NNFMP; 30 May 2011 06:24:50 -0000
Received: from [98.138.226.58] by tm5.bullet.mail.ne1.yahoo.com with NNFMP; 30 May 2011 06:24:50 -0000
Received: from [127.0.0.1] by smtp209.mail.ne1.yahoo.com with NNFMP; 30 May 2011 06:24:50 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp209.mail.ne1.yahoo.com with SMTP; 29 May 2011 23:24:50 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id A8AAC42804D	for <cygwin-patches@cygwin.com>; Mon, 30 May 2011 02:24:49 -0400 (EDT)
Date: Mon, 30 May 2011 06:25:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Bug in cmalloc? Was: Re: Problems with: Improvements to fork handling (2/5)
Message-ID: <20110530062449.GD5283@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCAD609.70106@cs.utoronto.ca> <20110528205000.GA30326@ednor.casa.cgf.cx> <4DE179DE.8040008@cs.utoronto.ca> <20110529002317.GA31865@ednor.casa.cgf.cx> <4DE1B101.4000603@cs.utoronto.ca> <4DE1CD9D.20608@gmail.com> <4DE1DEE7.8030307@cs.utoronto.ca> <20110529162745.GB5283@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110529162745.GB5283@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q2/txt/msg00180.txt.bz2

On Sun, May 29, 2011 at 12:27:45PM -0400, Christopher Faylor wrote:
>On Sun, May 29, 2011 at 01:51:35AM -0400, Ryan Johnson wrote:
>>So, I defined this small function:
>>
>>static void break_cmalloc(int depth, int maxdepth) {
>>     void* x = cmalloc (HEAP_2_DLL, 32);
>>     cfree(x);
>>     if (depth < maxdepth)
>>         break_cmalloc(depth+1, maxdepth);
>>}
>>
>>and called it during fork instead of dlls.topsort(), with maxdepth=5. No 
>>bug (as expected).
>>
>>Then I moved the call to cfree below the recursion, so memory gets freed 
>>in reverse order. Bang. Bash goes down and takes mintty with it after 
>>briefly flashing 'bad address.' Calling bash from cmd.exe hangs the 
>>latter so badly Windows can't kill it (I guess I'll have to reboot).
>
>Thanks for the test case.  I'll investigate later today.

As it turns out, this is not a bug in cmalloc.  fork() was not designed
to allow calling cmalloc() after the "frok grouped" definition at the
beginning of the function.  That records the bounds of the cygheap which
is passed to the child.  If you call cmalloc and friends after that then
the child process will never know that the heap has been extended.  Then
when the heap is copied from the parent by cygheap_fixup_in_child(),
you'll likely be missing pieces of the parent's cygheap and pieces of
the freed pool will end up pointing into blocks of memory which are not
properly initialized.

So, anyway, the problem can likely be fixed by moving the call to
topsort earlier.  I'll try that tomorrow.

cgf
