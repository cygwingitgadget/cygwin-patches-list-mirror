Return-Path: <cygwin-patches-return-2554-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5153 invoked by alias); 1 Jul 2002 10:02:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5137 invoked from network); 1 Jul 2002 10:02:55 -0000
Message-ID: <04b901c220e6$bceb2850$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <Pine.LNX.4.33.0206291214370.4768-100000@this> <20020701100414.B17641@cygbert.vinschen.de> <006a01c220e0$6735afd0$1800a8c0@LAPTOP>
Subject: Re: Patch to pass file descriptors
Date: Mon, 01 Jul 2002 03:02:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00002.txt.bz2

"Robert Collins" <robert.collins@syncretize.net> wrote:
> "Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
> > A change in the concept would eliminate that.  The sender process
> > could start a thread and duplicate all file handlers/HANDLEs.  So
> > the main thread in the sender isn't blocked.  The receiver is
blocked
> > anyway since it has to wait until all file handle information has
> > been correctly transmitted/regenerated.
>
> This is still incomplete, the parent now cannot exit(). I think that
it is a
> reasonable fall-back position for when the cygserver isn't running
though.

If this is a problem, the sender could always create a new process to
hold the handles until the receiver collected them. That sounds a bit
too heavy just to send a file descriptor but I don't expect that it
would done often enough to be unacceptable.

I suppose the issue here is not one of full Posix compliance (as none
of the discussion so far has approached that: e.g. how about sending
the file descriptor of a process's entry in the /proc fs?) but of what
needs to be done to cover enough cases to be useful. Corinna mentioned
that she'd want to use this in sshd (as I understood it): what's the
requirement there? Presumably the daemon's not about to exit and it's
only sending socket file descriptors? (all just guesses). If that
covers most of the uses, a non-cygserver implementation will be good
enough; the cygserver version is just to claim full Posix compliance
(one day) :-)

I lost track in the discussion of why shared memory was needed to pass
information between sender and receiver: why can't the sender just
send the data directly via the socket rather than putting it in shared
memory? The only reason I can see is to get around security issues in
duplicating the handles (i.e. the receiver sending its pid back to the
sender if it can't duplicate them). But the idea of the sender
duplicating its process handle with the relevant permissions would get
around that (?). The information passed could also include (the name
of?) a mutex that (a thread in) the sender waits on to know when it
can close the handles. Or am I missing something?

// Conrad


