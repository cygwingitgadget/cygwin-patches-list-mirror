Return-Path: <cygwin-patches-return-2281-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1296 invoked by alias); 1 Jun 2002 22:59:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1282 invoked from network); 1 Jun 2002 22:59:46 -0000
Date: Sat, 01 Jun 2002 15:59:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: strace -f fix
Message-ID: <20020601225943.GA2561@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <06eb01c209b9$11c491d0$6132bc3e@BABEL> <20020601223846.GB8326@redhat.com> <07ee01c209be$f395c430$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ee01c209be$f395c430$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00264.txt.bz2

On Sat, Jun 01, 2002 at 11:52:04PM +0100, Conrad Scott wrote:
>"Christopher Faylor" <cgf@redhat.com> wrote:
>> On Sat, Jun 01, 2002 at 11:09:57PM +0100, Conrad Scott wrote:
>> >I've been playing around with the strace program some more and noticed a
>> >minor glitch: it's only meant to trace forked children if the -f flag is
>> >given on the command line. Unfortunately it currently always traces
>> >children, and the this flag has no effect.
>>
>> What are you trying to fix?  AFAICT, the -f option is working correctly.
>
>Well, it doesn't work on my machine without the patch I sent in. That is,
>strace *always* traces child processes for me regardless of the -f flag.
>This is true of both the last release (1.3.10) and the current cvs source.
>I've also got a test program that shows exactly the same behaviour unless
>the CreateProcess() debug flags are used as per the patch I appended to the
>last email message. And I've checked that that patch does change the
>behaviour of strace with child processes (for me, on my machine, etc.).
>
>If it's working for you, I'm not quite sure where that leaves us: I'm
>running w2k (w/ latest service packs etc.), on a Pentium something-or-other
>box, nothing too wacky.
>
>Have you any idea? I'm befuddled now.

I normally  use XP and I just tried it on Windows 95 and Windows 98.  Perhaps
it is OS dependent.

If you read the MSDN description of DEBUG_ONLY_THIS_PROCESS, it sounds like
strace shouldn't even be using it at all:

If this flag is not set and the calling process is being debugged, the
new process becomes another process being debugged by the calling
process's debugger.  If the calling process is not a process being
debugged, no debugging-related actions occur.

Since strace.exe isn't normally being debugged, it doesn't sound like
this setting would have any effect.  Interestingly, it looks like I've
recently changed gdb to use the scheme that you propose.  I don't think
I did it on purpose, though.  I think it was just the result of a rewrite.

So, I'm not sure what to do.  Sounds like we need someone to check it on
NT4, maybe.

cgf
