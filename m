Return-Path: <cygwin-patches-return-2331-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29051 invoked by alias); 6 Jun 2002 01:57:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29037 invoked from network); 6 Jun 2002 01:57:20 -0000
Message-ID: <025201c20cfd$b5bf5670$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <01c501c20cf6$987d45b0$6132bc3e@BABEL> <20020606013422.GA851@redhat.com>
Subject: Re: Make CW_STRACE_TOGGLE toggle
Date: Wed, 05 Jun 2002 18:57:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00314.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> On Thu, Jun 06, 2002 at 02:07:57AM +0100, Conrad Scott wrote:
> >Currently calls to:
> >
> >    cygwin_internal (CW_STRACE_TOGGLE, pid)
> >
> >doesn't toggle the stracing of pid but simply turns it on again, i.e. a
> >no-op after the first call.
>
> Did you look at strace::hello?  This is supposed to toggle but, since
> the "inited" field in the strace class is never set, it never toggles.

I saw that code at the start of strace::hello but I hadn't stopped to work
out what was meant to be happening there (except that something seemed to be
adrift). Now you mention it, it is pretty obvious :-) And your patch is much
the better.

> >I've got a small program that makes this call for a given process, so you
> >can turn stracing on and off around events of interest etc. I'll send it
> >along once I've thought of a good name for it (strtoggle? stroggle?
> >stronoff? . . . ) Any suggestions?
>
> I don't understand what this program does.  Are you saying that you run
this
> other program while stracing a running program?


Yes: you call this other program (or, strace with some relevant option) to
toggle tracing in a program that's being straced at the time.

> I've never had a real use for this myself, but it sounds like this is an
> strace option, not another program.

I've been using this with XEmacs so that I can get strace output just for
some particular action. The strace log is so huge otherwise I can never find
the output that corresponds to what I was trying to test.

If this was to be another option to strace.exe, it would save the effort of
thinking up a name for a new program :-)

Anyhow, I can send a patch to do just that but it'll have to be tomorrow.

Good night for now.

// Conrad


