Return-Path: <cygwin-patches-return-2555-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6498 invoked by alias); 1 Jul 2002 11:09:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6467 invoked from network); 1 Jul 2002 11:09:24 -0000
Date: Mon, 01 Jul 2002 04:09:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to pass file descriptors
Message-ID: <20020701130922.E20028@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.33.0206291214370.4768-100000@this> <20020701100414.B17641@cygbert.vinschen.de> <006a01c220e0$6735afd0$1800a8c0@LAPTOP> <04b901c220e6$bceb2850$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b901c220e6$bceb2850$6132bc3e@BABEL>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00003.txt.bz2

On Mon, Jul 01, 2002 at 11:04:49AM +0100, Conrad Scott wrote:
> "Robert Collins" <robert.collins@syncretize.net> wrote:
> > "Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
> > > A change in the concept would eliminate that.  The sender process
> > > could start a thread and duplicate all file handlers/HANDLEs.  So
> > > the main thread in the sender isn't blocked.  The receiver is
> blocked
> > > anyway since it has to wait until all file handle information has
> > > been correctly transmitted/regenerated.
> >
> > This is still incomplete, the parent now cannot exit(). I think that
> it is a
> > reasonable fall-back position for when the cygserver isn't running
> though.
> 
> If this is a problem, the sender could always create a new process to
> hold the handles until the receiver collected them. That sounds a bit
> too heavy just to send a file descriptor but I don't expect that it
> would done often enough to be unacceptable.
> 
> I suppose the issue here is not one of full Posix compliance (as none
> of the discussion so far has approached that: e.g. how about sending
> the file descriptor of a process's entry in the /proc fs?) but of what
> needs to be done to cover enough cases to be useful. Corinna mentioned
> that she'd want to use this in sshd (as I understood it): what's the
> requirement there? Presumably the daemon's not about to exit and it's
> only sending socket file descriptors? (all just guesses). If that
> covers most of the uses, a non-cygserver implementation will be good
> enough; the cygserver version is just to claim full Posix compliance
> (one day) :-)

You got it.  Therefore a thread is ok.  Calling another process is
basically too much effort, IMO.

Is POSIX compliance actually a problem at all?  I don't think so.
SUSv3 doesn't mention descriptor passing in sendmsg/recvmsg at all.
What we're trying to do is some sort of BSD compatibility.  I don't
even demand full compatibility (e. g. the Cygwin header still defines
the old style msghdr definition), I just want to pass descriptors
for the most typical class of problems.  Sshd passes pseudo tty
descriptors in the privsep code.  That, sockets, pipes and files
are the most important ones.  Everything else can follow later.

> I lost track in the discussion of why shared memory was needed to pass
> information between sender and receiver: why can't the sender just
> send the data directly via the socket rather than putting it in shared
> memory? The only reason I can see is to get around security issues in

The shared mem allows to perform any sort of black magic between
two process and I'm trying to minimize the probablity that sender
and receiver processes mess up the stream of data on the socket.

> duplicating the handles (i.e. the receiver sending its pid back to the
> sender if it can't duplicate them). But the idea of the sender
> duplicating its process handle with the relevant permissions would get
> around that (?). The information passed could also include (the name
> of?) a mutex that (a thread in) the sender waits on to know when it
> can close the handles. Or am I missing something?

Not really.  You can use the same name for both objects, the mutex and
the shmem.  One of the processes needs enough privileges to call a
OpenProcess(PROCESS_DUP_HANDLE) on the other process.  This can be
figured out by just exchanging the Windows PIDs.  If this isn't possible,
we're stuck anyway and it would require the cygserver solution.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
