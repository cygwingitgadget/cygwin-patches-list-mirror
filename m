Return-Path: <cygwin-patches-return-4137-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22362 invoked by alias); 29 Aug 2003 03:12:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22351 invoked from network); 29 Aug 2003 03:12:57 -0000
Date: Fri, 29 Aug 2003 03:12:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030829031256.GA18890@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030819024617.GA6581@redhat.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F43B482.AC7F68F4@phumblet.no-ip.org> <3.0.5.32.20030828205339.0081f920@incoming.verizon.net> <20030829011926.GA16898@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829011926.GA16898@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00153.txt.bz2

On Thu, Aug 28, 2003 at 09:19:26PM -0400, Christopher Faylor wrote:
>On Thu, Aug 28, 2003 at 08:53:39PM -0400, Pierre A. Humblet wrote:
>>I was planning to also eventually propose patches for the  following,
>>but it's more efficient to tell Chris while he is working on the code
>>and before I forget:
>>1) sigcatch_nosync could be an event instead of a semaphore. This 
>>   doesn't affect the logic and will cut down useless loops, mainly
>>   at high load with pending_signals set.
>
>Are you seeing a lot of loops through the signal handler due to
>semaphores being > 1?

As coincidence would have it, I was trying to investigate Corinna's
problem without much success.  She reported that resizing an xterm
that was logged into a cygwin ssh session would cause the session
to terminate.

I couldn't duplicate that, even on my slower machine at work.  So,
I thought I'd write a program which sent 100,000 SIGWINCH's to a zsh
process to see what would happen.

I was heartened to see that zsh did not crash when I sicc'ed this
program on it -- until I tried to type something at the zsh prompt and
saw that it was hung.  The reason was that the recursive signal call
stuff was still not right.  We were restoring the return address
incorrectly.  AFAICT, we really do have to use the stored
retaddr_on_stack to rectify setup_handler's inappropriate "fixup" of the
return address.  Restoring it to 36(%%esp) wasn't right.

Ok.  Problem solved.  So I run the program again.  Then I type 'ls' in
zsh.  Hmm.  No response.  So, I look at the stack trace of the "hung"
zsh in gdb and it looks very reasonable.  I exit gdb and go look at the
code.  When I return to my PC, zsh has executed the ls and it is
responding to input normally.

Conclusion: cygwin can't handle 100,000 signals very quickly (which we
knew).

So, since you (Pierre) just raised this issue, I decided to change the
nosync handler to an event to see if that made any difference.  I didn't
run a scientific study but I would have to say that it didn't.  Of
course, in retrospect, it shouldn't have anyway, since the delay in
processing must be due to repeated signal handler calls.  The excess
nosync loop would have only introduced a processor load but input should
have still been functional since the signal handler calls were probably
handled by the inner loop in wait_sig.

So, I ended up checking in the change to use events and am building
a snapshot now.  With luck, I've solved Corinna's problems and maybe
I can even release 1.5.3 this weekend.

cgf
