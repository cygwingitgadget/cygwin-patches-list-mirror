Return-Path: <cygwin-patches-return-4152-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14005 invoked by alias); 31 Aug 2003 20:21:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13996 invoked from network); 31 Aug 2003 20:21:51 -0000
Date: Sun, 31 Aug 2003 20:21:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030831202150.GA7225@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F43B482.AC7F68F4@phumblet.no-ip.org> <3.0.5.32.20030828205339.0081f920@incoming.verizon.net> <20030829011926.GA16898@redhat.com> <20030829031256.GA18890@redhat.com> <3F4F60EA.4DBB8A51@phumblet.no-ip.org> <3.0.5.32.20030830152207.007bde60@incoming.verizon.net> <3.0.5.32.20030831112352.008161c0@incoming.verizon.net> <3.0.5.32.20030831161147.008294d0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030831161147.008294d0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00168.txt.bz2

On Sun, Aug 31, 2003 at 04:11:47PM -0400, Pierre A. Humblet wrote:
>At 02:39 PM 8/31/2003 -0400, you wrote:
>>On Sun, Aug 31, 2003 at 11:23:52AM -0400, Pierre A. Humblet wrote:
>>>thanks for your quick response to the ftp crash.
>>
>>It would have been much quicker if I'd clued into the fact that an
>>address like a0dc018 != a0dc01c.  It took my 127 attempts at running ftp
>>to finally see what was going on.
>>
>>I can't believe that this hasn't caused problems for other programs.
>>It's a pretty serious problem.  Every time I think I've got this fixed
>>another corner case occurs to me which has to be dealt with.
>
>I had the feeling I had seen mails on gethostbyname before.
>So I suspected it wasn't trivial and I spent the evening on 
>other kind of activities !
>
>>>writev (const int fd, const struct iovec *const iov, const int iovcnt)
>>>{
>>>  sig_dispatch_pending ();
>>>  sigframe thisframe (mainthread);
>>>
>>>The call to sig_dispatch_pending is meant for the case where
>>>there is a pending signal. Assume there indeed is one.
>>>The call to sig_dispatch_pending will setup an interrupt in sigsave. 
>>>The return address on the stack will be the first interruptible return 
>>>address above sig_dispatch_pending, i.e. the return address of writev.
>>>The handler will not be entered until writev returns.
>>
>>Ok.  I see what you mean but the old code was not actually right either.
>>I wrote a test case (enclosed) which sent a signal to a process running
>>a modified version of cygwin1.dll after the call to sigframe
>>("guaranteed" with the judicious use of Sleep) in sig_dispatch_pending.
>>The 'ouch' wasn't triggered by the either the old or new cygwin code.
>>So, I've checked in new code in sig_dispatch_pending.
>
>Why would the ouch be triggered? The parent is long dead when
>the child kills its ppid, which by that time is 1.

`a modified version of cygwin1.dll...  ("guaranteed" with the judicious
use of Sleep)'

cgf
