Return-Path: <cygwin-patches-return-7418-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18099 invoked by alias); 30 May 2011 12:25:28 -0000
Received: (qmail 18083 invoked by uid 22791); 30 May 2011 12:25:27 -0000
X-SWARE-Spam-Status: No, hits=-0.8 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 30 May 2011 12:25:05 +0000
Received: (qmail 12452 invoked by uid 107); 30 May 2011 12:25:01 -0000
Received: from sb-gw15.cs.toronto.edu (HELO discarded) (128.100.3.15) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Mon, 30 May 2011 14:25:02 +0200
Message-ID: <4DE387C2.3010600@cs.utoronto.ca>
Date: Mon, 30 May 2011 12:25:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Bug in cmalloc? Was: Re: Problems with: Improvements to fork handling (2/5)
References: <4DCAD609.70106@cs.utoronto.ca> <20110528205000.GA30326@ednor.casa.cgf.cx> <4DE179DE.8040008@cs.utoronto.ca> <20110529002317.GA31865@ednor.casa.cgf.cx> <4DE1B101.4000603@cs.utoronto.ca> <4DE1CD9D.20608@gmail.com> <4DE1DEE7.8030307@cs.utoronto.ca> <20110529162745.GB5283@ednor.casa.cgf.cx> <20110530062449.GD5283@ednor.casa.cgf.cx>
In-Reply-To: <20110530062449.GD5283@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
X-SW-Source: 2011-q2/txt/msg00184.txt.bz2

On 30/05/2011 2:24 AM, Christopher Faylor wrote:
> On Sun, May 29, 2011 at 12:27:45PM -0400, Christopher Faylor wrote:
>> On Sun, May 29, 2011 at 01:51:35AM -0400, Ryan Johnson wrote:
>>> So, I defined this small function:
>>>
>>> static void break_cmalloc(int depth, int maxdepth) {
>>>      void* x = cmalloc (HEAP_2_DLL, 32);
>>>      cfree(x);
>>>      if (depth<  maxdepth)
>>>          break_cmalloc(depth+1, maxdepth);
>>> }
>>>
>>> and called it during fork instead of dlls.topsort(), with maxdepth=5. No
>>> bug (as expected).
>>>
>>> Then I moved the call to cfree below the recursion, so memory gets freed
>>> in reverse order. Bang. Bash goes down and takes mintty with it after
>>> briefly flashing 'bad address.' Calling bash from cmd.exe hangs the
>>> latter so badly Windows can't kill it (I guess I'll have to reboot).
>> Thanks for the test case.  I'll investigate later today.
> As it turns out, this is not a bug in cmalloc.  fork() was not designed
> to allow calling cmalloc() after the "frok grouped" definition at the
> beginning of the function.  That records the bounds of the cygheap which
> is passed to the child.  If you call cmalloc and friends after that then
> the child process will never know that the heap has been extended.  Then
> when the heap is copied from the parent by cygheap_fixup_in_child(),
> you'll likely be missing pieces of the parent's cygheap and pieces of
> the freed pool will end up pointing into blocks of memory which are not
> properly initialized.
Ouch... and those pieces that didn't get copied are exactly the ones the 
child tries to read first when loading dlls.

Sorry for the false alarm -- I always assumed that was done after the 
call to setjmp, on the parent's side. Should have checked.

BTW, while poring over the patch I noticed a couple irregularities which 
you might want to remove:

1. The declaration for populate_all_deps in dll_init.h is never defined 
or used
2. The incrementing of the (seemingly dead) variable 'tot' ended up in 
dll_list::append and should be moved back to dll_list::alloc where it 
belongs.

Ryan
