Return-Path: <cygwin-patches-return-2427-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21742 invoked by alias); 14 Jun 2002 04:37:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21717 invoked from network); 14 Jun 2002 04:37:15 -0000
Message-ID: <017a01c2135d$64f74c50$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: "Robert Collins" <robert.collins@syncretize.net>
Cc: <cygwin-patches@cygwin.com>
References: <009901c212de$5bdb8cf0$0200a8c0@lifelesswks> <037601c212e7$8a9f8290$6132bc3e@BABEL>
Subject: Re: cygserver debug output patch
Date: Thu, 13 Jun 2002 21:37:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00410.txt.bz2

"Conrad Scott" <Conrad.Scott@dsl.pipex.com> wrote:
> "Robert Collins" <robert.collins@syncretize.net> wrote:
> > "IPC_RMID Remove the shared memory identifier specified by shmid
> > from the system and destroy the shared memory segment and shmid_ds data
> > structure associated with it. IPC_RMID can only be executed by a process
> > that has an effective user ID equal to either that of a process with
> > appropriate privileges or to the value of shm_perm.cuid or shm_perm.uid
> > in the shmid_ds data structure associated with shmid."
> >
> > It seems fairly clear: the shm id is immediately removed from the
> > system, along with the shm segment and shmid_ds data structure.
>
> So, yes, what's required is perfectly clear.

I've gone and looked around and it's not perfectly clear :-)

That paragraph is unchanged from the SVID (I've got ed'n 2 sitting here) and
it seems that it's always been interpreted as meaning that the segment
disappears on the last detach. At least, that's how both Linux and NetBSD do
it, w/ the Linux code giving an explicit reference to the SVID:

> The SVID states that the block remains until the last person
> detaches from it, then is deleted

Mind you, I can't find that said anywhere in my copy of the SVID; presumably
it's a clarification added in a subsequent version (SVR4?). The (current)
Linux man page for shmctl(2), which claims SVID & SVR4 conformance,
explicitly states:

>       IPC_RMID    is  used  to mark the segment as destroyed. It
>                   will actually  be  destroyed  after  the  last
>                   detach.   (I.e., when the shm_nattch member of
>                   the associated structure  shmid_ds  is  zero.)

The SVID and the Linux/NetBSD implementations also provide an errno (EIDRM),
which is returned by shmat(2) when attempting to attach to a deleted segment
(i.e. "identifier removed"). This presumably can only be returned during
this pending period, as otherwise you would get EINVAL, which supports this
interpretation.

So, it seems we're back where we started, which is lucky 'cos it's probably
easier to implement on win32 :-)

So unless there is something in Posix / Open Group / Single Unix / ... that
explicitly changes this behaviour, I guess we should go with the traditional
interpretation of the SVID definition. Seem okay?

// Conrad


