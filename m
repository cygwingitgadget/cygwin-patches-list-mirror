Return-Path: <cygwin-patches-return-2786-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29648 invoked by alias); 7 Aug 2002 13:57:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29626 invoked from network); 7 Aug 2002 13:57:21 -0000
Date: Wed, 07 Aug 2002 06:57:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: init_cheap and _csbrk
Message-ID: <20020807135719.GB2326@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01e501c23d74$400b2c90$6132bc3e@BABEL> <20020806220731.GG1386@redhat.com> <013b01c23d99$a180f930$6132bc3e@BABEL> <20020807012331.GJ1386@redhat.com> <006401c23df8$0f932340$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006401c23df8$0f932340$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00234.txt.bz2

On Wed, Aug 07, 2002 at 10:51:53AM +0100, Conrad Scott wrote:
>"Christopher Faylor" <cgf@redhat.com> wrote:
>> And even if I got the slop working there would still
>> be a call to VirtualAlloc.  It shouldn't matter since it will
>just
>> be allocating allocated memory but that means it probably isn't
>> really worth it anyway.  So, I've reorganized things one more
>time.
>> And, no more slop.
>
>Good point: I hadn't quite got as far as thinking too clearly
>about what was being optimised.  I bet a call to VirtualAlloc to
>commit an already committed page is cheap and so some optimization
>might be possible, but without instrumenting a few test programs
>who knows what difference it would make.

I was toying with doing something like:

_cfree (cmalloc (HEAP_STR, 2 * page_size))

which would have the effect that I was looking for but decided that
there was no clear win in doing that.

cgf
