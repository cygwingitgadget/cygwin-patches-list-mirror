Return-Path: <cygwin-patches-return-5125-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3916 invoked by alias); 14 Nov 2004 05:11:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3882 invoked from network); 14 Nov 2004 05:11:43 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 14 Nov 2004 05:11:43 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 5978B1B3E5; Sun, 14 Nov 2004 00:11:58 -0500 (EST)
Date: Sun, 14 Nov 2004 05:11:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041114051158.GG7554@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00126.txt.bz2

On Thu, Nov 11, 2004 at 11:52:25PM -0500, Pierre A. Humblet wrote:
>At 11:33 PM 11/11/2004 -0500, Christopher Faylor wrote:
>>On Thu, Nov 11, 2004 at 10:48:57PM -0500, Pierre A. Humblet wrote:
>>>Now that 1.5.12 is out, here is a patch to fix the PROCESS_DUP_HANDLE
>>>security hole.  It uses a new approach to reparenting: the parent
>>>duplicates the exec'ed process handle when signaled by the child.
>>
>>Can you refresh my memory (a URL is fine) on "the PROCESS_DUP_HANDLE
>>security hole"?
>
>It starts with
>http://cygwin.com/ml/cygwin-developers/2003-09/msg00078.html
>
>Eventually things were broken down in several patches. The part 
>about the tty gave rise to your archetype and the abandon of vfork.
>Very long story.

Oh, right.  How could I forget this???

When you first mentioned this, I had an idea that maybe we could be
waiting on something else besides a process handle which would be
inherited by any subprocesses.  I thought that maybe we could somehow
use a mutex but there would always be a period when you'd have to do
some tricky synchronization to make sure that the child gets to lock the
mutex but the parent doesn't.

I don't know how many times I have wished for a non-process handle that
would become signalled when a process exits.

So, today, it occurred to me that pipes could come to the rescue again.
If we opened a pipe and put the write end in every child process, the
parent could wait on the read end of the pipe.  When the last child
process dies, the parent would wake up and do what it does now.

At first, I was hoping that pipes would work correctly when called
with WaitFor* and we could just drop pipe handles in there.  Of course,
it can't be that simple and I really should have known that wouldn't
work.  I think I have tried this technique about twice a year since
1998.

Instead, you have to use ReadFile in a thread.  So, the children would
gain an extra open handle, the parent would get some new threads.  But
the parent would be able to track A LOT more subprocesses than the
current 63.

I just implemented most of this and it seems to work ok.  One side
effect of this technique is that any subprocess created with
CreateProcess will also inherit the pipe and so, a parent cygwin process
will wait for all of the processes created with CreateProcess.  I'm not
sure if I really care about that, though.

The other negative side effect is the overhead of creating a pipe and a
thread.  I don't think this is noticeable and this technique eliminates
some overhead in cygwin, too.  It's not exactly a wash, but I'm hoping
it won't be too bad, regardless.

When I get the code to a point that it can run configure, I'll do a
benchmark and see how bad this technique is.  If there is not a
noticeable degradation, I think I'll probably duplicate the scenario of
last year and checkin this revamp which, I believe will eliminate the
security problem that you were talking about.

cgf
