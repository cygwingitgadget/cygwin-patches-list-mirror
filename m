Return-Path: <cygwin-patches-return-2558-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22207 invoked by alias); 1 Jul 2002 11:48:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22190 invoked from network); 1 Jul 2002 11:48:00 -0000
Message-ID: <052401c220f5$6bd4a6d0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <Pine.LNX.4.33.0206291214370.4768-100000@this> <20020701100414.B17641@cygbert.vinschen.de> <006a01c220e0$6735afd0$1800a8c0@LAPTOP> <04b901c220e6$bceb2850$6132bc3e@BABEL> <20020701130922.E20028@cygbert.vinschen.de>
Subject: Re: Patch to pass file descriptors
Date: Mon, 01 Jul 2002 04:48:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00006.txt.bz2

"Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
> > If that
> > covers most of the uses, a non-cygserver implementation will be
good
> > enough; the cygserver version is just to claim full Posix
compliance
> > (one day) :-)
>
> You got it.  Therefore a thread is ok.  Calling another process is
> basically too much effort, IMO.

I suppose that was what I was working towards: we don't need to get
that hung up about some of the more remote possibilities, so possible
"solutions", like creating a new process, aren't worth considering
(for the non-cygserver implementation) since they aren't needed for
the common cases.

> Is POSIX compliance actually a problem at all?  I don't think so.
> SUSv3 doesn't mention descriptor passing in sendmsg/recvmsg at all.

Doh! Of course.

> What we're trying to do is some sort of BSD compatibility.

That's what I meant! Well, it's what I would have meant had I thought
about it a bit more :-)

> I don't
> even demand full compatibility (e. g. the Cygwin header still
defines
> the old style msghdr definition), I just want to pass descriptors
> for the most typical class of problems.  Sshd passes pseudo tty
> descriptors in the privsep code.  That, sockets, pipes and files
> are the most important ones.  Everything else can follow later.

Understood.

> One of the processes needs enough privileges to call a
> OpenProcess(PROCESS_DUP_HANDLE) on the other process.
> This can be
> figured out by just exchanging the Windows PIDs.  If this isn't
possible,
> we're stuck anyway and it would require the cygserver solution.

I've got to look at this whole issue of getting hold of process
handles to get a handle (pun! pun!) on the security issues in
cygserver. Exactly which privileges are required for what is still a
black art to me. Time for some more reading.

// Conrad


