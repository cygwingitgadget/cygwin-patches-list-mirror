Return-Path: <cygwin-patches-return-2608-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32039 invoked by alias); 5 Jul 2002 17:08:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32023 invoked from network); 5 Jul 2002 17:08:58 -0000
Date: Fri, 05 Jul 2002 10:08:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: printfs in cygserver?
Message-ID: <20020705170912.GA31040@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020705030630.GA24255@redhat.com> <008301c22411$7cfc7900$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008301c22411$7cfc7900$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00056.txt.bz2

On Fri, Jul 05, 2002 at 11:48:24AM +0100, Conrad Scott wrote:
>"Christopher Faylor" <cgf@redhat.com> write:
>> There seems to be a lot of of "printfs" in cygserver code that
>is
>> apparently linked into cygwin.  I specifically noticed it it
>> cygserver_transport_pipes.cc and cygserver_transport_sockets.cc.
>> Is this being corrected?  We don't use raw printf in cygwin
>code.
>
>I've fixed this on the cygwin_daemon branch.  In case it's
>something you'd like fixed immediately, attached is a (slightly
>updated) copy of a patch I previously submitted to Rob that, among
>other things, changes the cygserver code to use the xxx_printf
>calls from "strace.h".  I'd be happy for this to go into HEAD;
>it's not a functionality patch, more of a brisk clean-up and
>rub-down patch :-)

You're the maintainer now so the decision of what goes into head
is pretty much yours.  If you think it should be checked in, go
for it.

cgf
