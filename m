Return-Path: <cygwin-patches-return-2772-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3231 invoked by alias); 6 Aug 2002 04:59:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3213 invoked from network); 6 Aug 2002 04:59:41 -0000
Date: Mon, 05 Aug 2002 21:59:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: add_handle and malloc
Message-ID: <20020806045937.GA23281@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <023c01c23cf4$823d56e0$6132bc3e@BABEL> <026301c23cf5$eabeebb0$6132bc3e@BABEL> <20020806030558.GB19362@redhat.com> <027301c23cfb$108b7cf0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027301c23cfb$108b7cf0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00220.txt.bz2

On Tue, Aug 06, 2002 at 04:40:52AM +0100, Conrad Scott wrote:
>"Christopher Faylor" <cgf@redhat.com> wrote:
>> Go ahead and check this in.
>
>On its way.
>
>> You weren't actually seeing the malloc
>> code being hit, were you?
>
>Umm . . . yes :-) (he says innocently).  There's a handle leak
>somewhere in the DLL at the moment, and I was running a test that
>recursively forked, until death as it turned out.  I'm still
>looking for the handle leak: once I've found that I can go back to
>testing the socket code I was working on.

If there is a handle leak then the thread code should be a good clue
where it is.  If you look at the cygheap->debug.freeh table it should
be filled with a repeating handle, I would think.

cgf
