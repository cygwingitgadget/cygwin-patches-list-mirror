Return-Path: <cygwin-patches-return-2227-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32458 invoked by alias); 27 May 2002 01:27:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32437 invoked from network); 27 May 2002 01:27:39 -0000
Message-ID: <024701c2051d$e13cbdc0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <FE045D4D9F7AED4CBFF1B3B813C85337676295@mail.sandvine.com> <20020527011013.GA15710@redhat.com>
Subject: Re: [PATCH] improve performance of stat() operations (e.g. ls -lR )
Date: Sun, 26 May 2002 18:27:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00211.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
>
> Hmm.  Interesting.  It seems like -E and -X should just be defaulting
> to doing query_open.  I think that the only reason that query_open
> is not the default is that the file has to be opened for reading if
> the executable state is not known.
>
> Or, maybe it's actually possible not to do an open at all in those
> cases.
>
> Hmm, again.
>
> cgf
>

A (possibly related) note, it occurred to me the other day (as I looked at
some strace output) that opening the file during stat() --- so that you can
call GetFileInformationByHandle() --- will be slow if you've got an
anti-virus program running since they tend to intercept file opens. Then
again, I don't understand enough about cygwin *or* win32 to understand
whether you can get the same information without opening the file. Thus it
might be a win to avoid opening the file if possible on ntsf too (w/ ntsec).

// Conrad


