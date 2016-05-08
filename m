Return-Path: <cygwin-patches-return-8558-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54336 invoked by alias); 8 May 2016 20:43:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54313 invoked by uid 89); 8 May 2016 20:43:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KAM_LOTSOFHASH,SPF_HELO_PASS,SPF_PASS,TVD_RCVD_IP autolearn=no version=3.3.2 spammy=Hood, INFINITE, closehandle, CloseHandle
X-HELO: glup.org
Received: from 216-15-121-172.c3-0.smr-ubr2.sbo-smr.ma.static.cable.rcn.com (HELO glup.org) (216.15.121.172) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Sun, 08 May 2016 20:43:03 +0000
Received: from minipixel.i.glup.org (unknown [198.206.215.1])	by glup.org (Postfix) with ESMTPSA id BD722854CE;	Sun,  8 May 2016 16:43:00 -0400 (EDT)
Authentication-Results: glup.org; dmarc=none header.from=glup.org
Subject: Re: [PATCH] Re: Cygwin select() issues and improvements
To: cygwin-patches@cygwin.com
References: <20160215125703.GE8374@calimero.vinschen.de> <56C66DDE.9070509@glup.org> <20160219104641.GA5574@calimero.vinschen.de> <20160304085843.GB8296@calimero.vinschen.de> <56E5DD8D.7060302@glup.org> <20160314101257.GE3567@calimero.vinschen.de> <56EA78DC.3040201@glup.org> <56EADD32.4010802@redhat.com> <56EDD62E.3040309@glup.org> <20160320150034.GE24954@calimero.vinschen.de> <20160329124939.GB3793@calimero.vinschen.de>
From: john hood <cgull@glup.org>
Message-ID: <b45c2cb3-4c76-7213-cfc7-de4e2af79eb4@glup.org>
Date: Sun, 08 May 2016 20:43:00 -0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0) Gecko/20100101 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <20160329124939.GB3793@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SW-Source: 2016-q2/txt/msg00033.txt.bz2

On 3/29/16 8:49 AM, Corinna Vinschen wrote:
> John, ping?

Sorry it took so long to reply, but I finally got around to cleaning up
the patchset, I've mailed it separately.  I was pretty frustrated at my
slow Windows machine and the friction in dealing with the project, and
also sick for a while.

> On Mar 20 16:00, Corinna Vinschen wrote:
>> On Mar 19 18:43, john hood wrote:
>>> From c805552cdc9e673ef2330388ddb8b7a0da741766 Mon Sep 17 00:00:00 2001
>>> From: John Hood <cgull@glup.org>
>>> Date: Thu, 28 Jan 2016 17:08:39 -0500
>>> Subject: [PATCH 1/5] Use high-resolution timebases for select().
>>>
>>> 	* cygwait.h: Add cygwait_us() methods.
>>> 	* select.h: Change prototype for select_stuff::wait() for larger
>>> 	microsecond timeouts.
>>> 	* select.cc (pselect): Convert from old cygwin_select().
>>> 	Implement microsecond timeouts.
>>> 	(cygwin_select): Rewrite as a wrapper on pselect().
>>> 	(select): Implement microsecond timeouts.
>>> 	(select_stuff::wait): Implement microsecond timeouts with a timer
>>> 	object.
>>
>> I have a bit of a problem with patch 1 and 4.  In the same patchset
>> you add cygwait_us and remove it again.  That doesn't really look
>> useful to me.  Can you create the patches so that this part is skipped,
>> please?  The rest of the patch should work as is with the existing version
>> of cygwait.

The issue here is that patch 1 changed the structure of the code and
added the requirement for a cygwait_us(), but patch 4 couldn't be moved
above patch 1 without writing/testing new code to get a good patch
series.  I avoided the issue by simply changing 'cygwait_us(...,
microsecond_timeout)' to 'cygwait(..., microsecond_timeout * 1000)',
which makes patch 1 actually not microsecond resolution anymore, but did
allow me to get rid of the add/revert of 'cygwait_us()'.  The final code
is still the same and has the intended high time resolution capability.

>> Two general style issues:
>>
>> - Please don't use Microsofts variable naming convention.  It's used in
>>   kernel.cc to use the same names as in the documentation and there are
>>   a few rare cases where class members are using this convention, but
>>   other than that we usually use lowercase and underscores only.  Please
>>   use that as well.

Fixed.

>> - Always prepend a space to an opening bracket in function or macro calls,
>>   gnu-style.  There are a couple of cases where you missed that.  If you find
>>   such cases prior to your patch, pleae change them while you're at it.

Fixed.

>> Btw., it would be helpful to get a patch series the way git format-patch/
>> send-email generates them.  It allows easier review to have every patch
>> in a single mail.  I changed the text on https://cygwin.com/contrib.html
>> to be a bit more clear about this.  Well, hopefully a bit more clear.
>>
>>> @@ -362,13 +362,50 @@ err:
>>>  /* The heart of select.  Waits for an fd to do something interesting. */
>>>  select_stuff::wait_states
>>>  select_stuff::wait (fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
>>> -		    DWORD ms)
>>> +		    LONGLONG us)
>>>  {
>>>    HANDLE w4[MAXIMUM_WAIT_OBJECTS];
>>>    select_record *s = &start;
>>>    DWORD m = 0;
>>>  
>>> +  /* Always wait for signals. */
>>>    wait_signal_arrived here (w4[m++]);
>>> +
>>> +  /* Set a timeout, or not, for WMFO. */
>>> +  DWORD dTimeoutMs;
>>> +  if (us == 0)
>>> +    {
>>> +      dTimeoutMs = 0;
>>> +    }
>>> +  else
>>> +    {
>>> +      dTimeoutMs = INFINITE;
>>> +    }
>>
>> Please, no braces for oneliners.  Also, this entire statement can be
>> folded into a oneliner:
>>
>>      ms = us ? INFINITE : 0;

In my experience brace-less conditional blocks are dangerous, but this
does collapse fine into a ternary conditional.

>>> +  status = NtCreateTimer(&hTimeout, TIMER_ALL_ACCESS, NULL, NotificationTimer);
>>
>> Does it really make sense to build up and break down a timer per each
>> call to select_stuff::wait?  This function is called in a loop.  What
>> about creating the timer in the caller and only arm and disarm it in the
>> wait call?

Not fixed.  Managing the resource gets more complicated if you hoist it
up to the caller with its various exit conditions.  Plus, doing that
doesn't make the minimum or typical cost of select any less, it only
makes the handling of events that select ignores slightly more
efficient.  As I see it, ignored mouse events on the console are the
only case where we're likely to see many ignored events, correct me if
I'm wrong.

>>> +  if (dTimeoutMs == INFINITE)
>>> +    {
>>> +      CancelWaitableTimer (hTimeout);
>>> +      CloseHandle (hTimeout);
>>> +    }
>>
>> For clarity, since the timer has been created and armed using native
>> functions, please use NtCancelTimer and NtClose here.

Fixed.

>>> From 225f852594d9ff6a1231063ece3d529b9cc1bf7f Mon Sep 17 00:00:00 2001
>>> From: John Hood <cgull@glup.org>
>>> Date: Sat, 30 Jan 2016 17:33:36 -0500
>>> Subject: [PATCH 2/5] Move get_nonascii_key into fhandler_console.
>>>
>>> 	* fhandler.h (fhandler_console): Move get_nonascii_key() from
>>> 	select.c into this class.
>>> 	* select.cc (peek_console): Move get_nonascii_key() into
>>> 	fhandler_console class.
>>
>> Patch applied.
>>
>>> From b2e2b5ac1d6b62610c51a66113e5ab97b1d43750 Mon Sep 17 00:00:00 2001
>>> From: John Hood <cgull@glup.org>
>>> Date: Sat, 30 Jan 2016 17:37:33 -0500
>>> Subject: [PATCH 3/5] Debug printfs.
>>>
>>> 	* fhandler.cc (fhandler_base::get_readahead): Add debug code.
>>> 	* fhandler_console.cc (fhandler_console::read): Add debug code.
>>> 	* select.cc (pselect): Add debug code.
>>> 	(peek_console): Add debug code.
>>
>> Why?  It's a lot of additional debug output.  Was that only required for
>> developing or does it serve a real purpose for debugging user bug reports
>> in future?  If so, I wouldn't mind to have a bit of additional description
>> in the git log to explain the debug statements...

Split out into a separate patch, apply or discard as you please.  I
think it's useful for user bugs (when select is breaking, it really
helps to see what's going on inside) but I don't feel strongly about it.

>>> From cf2db014fefd4a8488316cf9313325b79e25518d Mon Sep 17 00:00:00 2001
>>> From: John Hood <cgull@glup.org>
>>> Date: Thu, 4 Feb 2016 00:44:56 -0500
>>> Subject: [PATCH 4/5] Improve and simplify select().
>>>
>>> 	* cygwait.h (cygwait_us) Remove; this reverts previous changes.
>>> 	* select.h: Eliminate redundant select_stuff::select_loop state.
>>> 	* select.cc (select): Eliminate redundant
>>
>> See above.
>>
>>> @@ -182,30 +181,7 @@ select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
>>>  	  }
>>>        select_printf ("sel.always_ready %d", sel.always_ready);
>>>  
>>> -      /* Degenerate case.  No fds to wait for.  Just wait for time to run out
>>> -	 or signal to arrive. */
>>> -      if (sel.start.next == NULL)
>>> -	switch (cygwait_us (us))
>>> -	  {
>>> -	  case WAIT_SIGNALED:
>>> -	    select_printf ("signal received");
>>> -	    /* select() is always interrupted by a signal so set EINTR,
>>> -	       unconditionally, ignoring any SA_RESTART detection by
>>> -	       call_signal_handler().  */
>>> -	    _my_tls.call_signal_handler ();
>>> -	    set_sig_errno (EINTR);
>>> -	    wait_state = select_stuff::select_signalled;
>>> -	    break;
>>> -	  case WAIT_CANCELED:
>>> -	    sel.destroy ();
>>> -	    pthread::static_cancel_self ();
>>> -	    /*NOTREACHED*/
>>> -	  default:
>>> -	    /* Set wait_state to zero below. */
>>> -	    wait_state = select_stuff::select_set_zero;
>>> -	    break;
>>> -	  }
>>> -      else if (sel.always_ready || us == 0)
>>
>> This obviously allows to fold everything into select_stuff::wait, but
>> the more it seems like a good idea to move the timer creation into the
>> caller for this case, doesn't it?
>>
>> Alternatively, we could add a per-thread timer handle to the cygtls
>> area.  It could be created on first use and deleted when the thread
>> exits.  But that's just an idea for a future improvement, never
>> mind for now.

These are things that can be fixed/improved with more effort, but I have
other things I'd rather be working on.

>>> From 3f3f7112f948d70c15046641cf3cc898a9ca4c71 Mon Sep 17 00:00:00 2001
>>> From: John Hood <cgull@glup.org>
>>> Date: Fri, 18 Mar 2016 04:31:16 -0400
>>> Subject: [PATCH 5/5] 	* winsup/testsuite/configure: chmod a+x
>>
>> Applied.

regards,

  --jh
