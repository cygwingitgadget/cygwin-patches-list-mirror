Return-Path: <cygwin-patches-return-4229-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23731 invoked by alias); 22 Sep 2003 13:14:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23722 invoked from network); 22 Sep 2003 13:14:15 -0000
Message-ID: <02fe01c3810b$6883d740$0901010a@cefey.local>
From: "Artem Khodush" <greenkaa@mail.ru>
To: <cygwin-patches@cygwin.com>
References: <E1A0doP-0008SO-00.greenkaa-mail-ru@f23.mail.ru> <20030920160547.GB24929@redhat.com>
Subject: Re: O_NONBLOCK for pipes
Date: Mon, 22 Sep 2003 13:14:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Spam: Not detected
X-SW-Source: 2003-q3/txt/msg00245.txt.bz2

> >I have straightforward patch, containing about 20 lines of new code,
> >which implements O_NONBLOCK fcntl for pipes using
> >SetNamedPipeHandleState NT API call.
> >
> >Two questions before I send it:
> >
> >Will it be considered trivial, so that copyright assignement is not
> >required?
> 
> No, sorry.

OK, then it will take some time..

> >Is there some deep reason, which I don't see, why this was not
> >implemented before?
> 
> What does it buy you?  O_NONBLOCK is already implemented for pipes
> without this call, AFAIK.

Long story short: I've got a testcase which deadlocks on cygwin, 
but works on linux and with my patch on cygwin too. 
It's distilled from one of the tests for IPC::Run perl module, 
namely t/run.t, one which contains the line    
$r = run [ $perl, qw{-e print"-"x20000;<STDIN>;} ], \$in, \$out ;

The test forks a child which writes 20k of data to stdout then reads stdin,
then goes into the select loop in which writes (in a single call)
20k of data to child's stdin, and reads child's stdout until child exits.
If the amount of data written to child's stdin in a single call 
is longer then the size of cygwin's pipe buffer, you've got a deadlock.

That's why I decided that O_NONBLOCK for pipes on cygwin was 
not implemented.

Artem.

