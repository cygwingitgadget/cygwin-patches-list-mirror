Return-Path: <cygwin-patches-return-2282-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5679 invoked by alias); 1 Jun 2002 23:21:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5665 invoked from network); 1 Jun 2002 23:21:58 -0000
Message-ID: <07f601c209c3$4b212010$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <06eb01c209b9$11c491d0$6132bc3e@BABEL> <20020601223846.GB8326@redhat.com> <07ee01c209be$f395c430$6132bc3e@BABEL> <20020601225943.GA2561@redhat.com>
Subject: Re: strace -f fix
Date: Sat, 01 Jun 2002 16:21:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00265.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> I normally  use XP and I just tried it on Windows 95 and Windows 98.
Perhaps
> it is OS dependent.
>
> If you read the MSDN description of DEBUG_ONLY_THIS_PROCESS, it sounds
like
> strace shouldn't even be using it at all:
>
> If this flag is not set and the calling process is being debugged, the
> new process becomes another process being debugged by the calling
> process's debugger.  If the calling process is not a process being
> debugged, no debugging-related actions occur.
>
> Since strace.exe isn't normally being debugged, it doesn't sound like
> this setting would have any effect.  Interestingly, it looks like I've
> recently changed gdb to use the scheme that you propose.  I don't think
> I did it on purpose, though.  I think it was just the result of a rewrite.

The documentation is wierd for this flag: I've just looked it up all over
MSDN and it's more complicated than I thought. Perhaps it has changed from
one release to the next? But then again, the documentation for the same
version of Windows also seems to contradict itself (see the CE .NET stuff).
Also, *none* of these comments agree with the one you found elsewhere in
MSDN.

From "Windows Developement: Windows Base Services":

> If the DEBUG_PROCESS and DEBUG_ONLY_THIS_PROCESS flags are
> specified for fdwCreate, a debugger debugs the new process but none of its
> descendants.

From Windows CE 3.0 and CE .NET (agreeing with the above):

> DEBUG_PROCESS
> Creates a process to be debugged by the calling process.
>
> DEBUG_ONLY_THIS_PROCESS
> Creates a process to be debugged by the calling process, but doesn't debug
> any child processes that are launched by the process being debugged. This
> flag must be used in conjunction with DEBUG_PROCESS.

From CE .NET again (but contradicting the above?):

> DEBUG_PROCESS
> If this flag is set, the calling process is treated as a debugger, and the
new
> process is a process being debugged. Child processes of the new process
> are also debugged. The system notifies the debugger of all debug events
that
> occur in the process being debugged.
>
> DEBUG_ONLY_THIS_PROCESS
> If this flag is set, the calling process is treated as a debugger, and the
new
> process is a process being debugged. No child processes of the new process
> are debugged. The system notifies the debugger of all debug events that
> occur in the process being debugged.

From WIN98 (as per the previous one?):

> DEBUG_PROCESS
> The parent receives debugging information about the child and any of its
> children.
>
> DEBUG_ONLY_THIS_PROCESS
> The parent receives debugging information about the child but not about
any
> of the child's children.

I'm well confused and it's obviously more complex than I realised. Maybe
we'll be lucky and there'll be one set of flags that does work on all
platforms?

Fingers crossed.

// Conrad

