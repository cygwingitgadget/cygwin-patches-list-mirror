Return-Path: <cygwin-patches-return-2771-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4928 invoked by alias); 6 Aug 2002 03:38:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4914 invoked from network); 6 Aug 2002 03:38:25 -0000
Message-ID: <027301c23cfb$108b7cf0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <023c01c23cf4$823d56e0$6132bc3e@BABEL> <026301c23cf5$eabeebb0$6132bc3e@BABEL> <20020806030558.GB19362@redhat.com>
Subject: Re: add_handle and malloc
Date: Mon, 05 Aug 2002 20:38:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00219.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> Go ahead and check this in.

On its way.

> You weren't actually seeing the malloc
> code being hit, were you?

Umm . . . yes :-) (he says innocently).  There's a handle leak
somewhere in the DLL at the moment, and I was running a test that
recursively forked, until death as it turned out.  I'm still
looking for the handle leak: once I've found that I can go back to
testing the socket code I was working on.

// Conrad


