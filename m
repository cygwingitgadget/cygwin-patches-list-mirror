Return-Path: <cygwin-patches-return-2774-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23755 invoked by alias); 6 Aug 2002 05:39:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23727 invoked from network); 6 Aug 2002 05:39:06 -0000
Message-ID: <030b01c23d0b$ec59d500$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <023c01c23cf4$823d56e0$6132bc3e@BABEL> <026301c23cf5$eabeebb0$6132bc3e@BABEL> <20020806030558.GB19362@redhat.com> <027301c23cfb$108b7cf0$6132bc3e@BABEL> <20020806045937.GA23281@redhat.com>
Subject: Re: add_handle and malloc
Date: Mon, 05 Aug 2002 22:39:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00222.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> If there is a handle leak then the thread^Wdebug code
> should be a good clue where it is.
> If you look at the cygheap->debug.freeh table it should
> be filled with a repeating handle, I would think.

Thanks for the pointer.  That's roughly where I've just reached: I
kept getting distracted (mainly by breaking the DLL w/ some
stoopid debugging hack).  It looks like it's cygwin_mount_h, at
memory_init():155.  I'll go and zap something.

I'll pick up your latest cygthread update soon.

// Conrad


