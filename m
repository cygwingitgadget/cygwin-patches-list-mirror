Return-Path: <cygwin-patches-return-2782-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29607 invoked by alias); 7 Aug 2002 09:51:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29593 invoked from network); 7 Aug 2002 09:51:27 -0000
Message-ID: <006401c23df8$0f932340$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <01e501c23d74$400b2c90$6132bc3e@BABEL> <20020806220731.GG1386@redhat.com> <013b01c23d99$a180f930$6132bc3e@BABEL> <20020807012331.GJ1386@redhat.com>
Subject: Re: init_cheap and _csbrk
Date: Wed, 07 Aug 2002 02:51:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00230.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> And even if I got the slop working there would still
> be a call to VirtualAlloc.  It shouldn't matter since it will
just
> be allocating allocated memory but that means it probably isn't
> really worth it anyway.  So, I've reorganized things one more
time.
> And, no more slop.

Good point: I hadn't quite got as far as thinking too clearly
about what was being optimised.  I bet a call to VirtualAlloc to
commit an already committed page is cheap and so some optimization
might be possible, but without instrumenting a few test programs
who knows what difference it would make.

> In the reorganization our aesthetic sense merged so I moved the
> cygheap_max setting back into init_cheap.

Beauty will out :-)

// Conrad


