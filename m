Return-Path: <cygwin-patches-return-2650-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6657 invoked by alias); 14 Jul 2002 22:27:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6643 invoked from network); 14 Jul 2002 22:27:26 -0000
Date: Sun, 14 Jul 2002 15:27:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Protect handle issue-ettes
Message-ID: <20020714222738.GA607@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <002a01c22b2f$07f9bda0$6132bc3e@BABEL> <20020714161750.GA26964@redhat.com> <005301c22b64$56c7e4e0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005301c22b64$56c7e4e0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00098.txt.bz2

On Sun, Jul 14, 2002 at 07:29:06PM +0100, Conrad Scott wrote:
>"Christopher Faylor" <cgf@redhat.com> wrote:
>>
>> Huh?  The code in dll_crt0_1 is supposed to be called
>> on a fork or an exec.  That's why I renamed it to
>> debug_fixup_after_fork_exec.
>> As far as I can tell it *is* called on a fork.
>> strace confirms that.
>
>Sorry Chris, I've obviously misunderstood something then.  I tried
>calling setclexec() for one of the handles that was causing
>trouble (the title_mutex) but it didn't change anything, while
>removing the ProtectHandle call for it removed a whole lot of
>warnings (as far as I can remember from this morning).

Did you look at the changes to add_handle?  A CVS diff might be
instructive.  Here are the bulk of the changes:

http://cygwin.com/ml/cygwin-cvs/2002-q3/msg00074.html

The default case for a handle is not to be inherited.  That hasn't
changed.  Calling setclexec on most of the handles that cygwin uses for
its own purposes should be a no-op -- this hasn't changed either.

What has changed is the use of the new macro ProtecHandle*INH.  This is
now used on those rare handles that are supposed to be inherited.

>One thing that is confusing me is that if you call fcntl() to set
>the close-on-exec flag for a file descriptor, this ends up calling
>setclexec().  But if the clexec flag is honoured on fork (as well
>as exec) how can this be right?

It shouldn't matter.  The clexec is basically a "This handle is not
inherited" flag.  It's possible that the logic is wrong and an fd with
clexec set will disappear from the debug list of handles inappropriately
but that's not going to cause collisions AFAICT.

*pause*

Actually, on checking this, it seems obvious that I either never
completed the clexec for fds stuff or wiped it out for some reason.  So,
a normal fd doesn't show up on the list of protected handles anyway.
I've removed the setclexec code from the DLL.

>I'll go have another look at the code sometime soon and write some
>test programs, since the volume of warnings in the cygserver
>branch is a little distracting.

I just tried it with a branch DLL and a branch cygserver.  Still no
warnings.  I didn't see any warnings.

A branch server and trunk DLL just errored out.

It almost sounds like you are not running with the most recent sources.

cgf
