Return-Path: <cygwin-patches-return-2846-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29795 invoked by alias); 17 Aug 2002 01:53:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29776 invoked from network); 17 Aug 2002 01:53:13 -0000
Date: Fri, 16 Aug 2002 18:53:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: [PATCH suggestion] exceptions.cc, interrupt_setup ()
Message-ID: <20020817015324.GA23893@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin@cygwin.com, cygwin-patches@cygwin.com
References: <119122398409.20020816203409@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119122398409.20020816203409@gmx.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00294.txt.bz2

On Fri, Aug 16, 2002 at 08:34:09PM +0200, Pavel Tsekov wrote:
>I suggest the following very simple patch. Since I may have not
>understand all the specifics of the signal handling mechanism I offer
>it for discussion. Just for the record - this patch solves that
>outstanding problem with MC.

It looks like you've understood enough of the signal processing to
uncover a pretty basic problem.  I can only assume that similar code was
in exceptions.cc at some point and that I fat fingered it at some point.

I have applied your patch.

Thanks very much for tracking this down.

cgf
