Return-Path: <cygwin-patches-return-2711-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17405 invoked by alias); 25 Jul 2002 10:27:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17389 invoked from network); 25 Jul 2002 10:27:20 -0000
Subject: Re: src/winsup/cygwin ChangeLog cygwin.din
From: Robert Collins <robert.collins@syncretize.net>
To: egor duda <cygwin-patches@cygwin.com>
In-Reply-To: <149608496601.20020725131913@logos-m.ru>
References: <20020724073803.17255.qmail@sources.redhat.com>
	<145518762130.20020724122337@logos-m.ru>
	<20020724153129.GE13558@redhat.com> 
	<149608496601.20020725131913@logos-m.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Jul 2002 03:27:00 -0000
Message-Id: <1027592838.31744.0.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00159.txt.bz2

On Thu, 2002-07-25 at 19:19, egor duda wrote:
> Hi!
> 
> Wednesday, 24 July, 2002 Christopher Faylor cgf@redhat.com wrote:
> 
> CF> On Wed, Jul 24, 2002 at 12:23:37PM +0400, egor duda wrote:
> >>How about this? The check is not a panacea, but at least it catches
> >>most typical cases.
> >>
> >>        * Makefile.in: Check if API version is updated when exports
> >>        from dll are changed and stop if not so.
> 
> CF> Great idea, Egor.  Please check it in.
> 
> Done.
> 
> CF> Hmm.  I wonder if we could automatically generate the version number
> CF> when cygwin.din changes.
> 
> Well, maybe. I'm not sure if we can say "accidental changes" such as
> touching cygwin.din or converting it from textmode to binmode or
> something like that from real changes in export table. Anyway, manual
> updating of version.h is not much work, if you're reminded about it.

It will never hurt to bump API minor, as that is a forwards
compatability flag, not a backwards one. Worst case: we have a few
never-released API versions.

Rob
