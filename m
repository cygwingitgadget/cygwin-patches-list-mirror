Return-Path: <cygwin-patches-return-7398-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15730 invoked by alias); 24 May 2011 16:15:11 -0000
Received: (qmail 14859 invoked by uid 22791); 24 May 2011 16:14:45 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 24 May 2011 16:14:31 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CC8832CB9E4; Tue, 24 May 2011 18:14:28 +0200 (CEST)
Date: Tue, 24 May 2011 16:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (2/5)
Message-ID: <20110524161428.GA16774@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCAD609.70106@cs.utoronto.ca> <20110522014421.GB18936@ednor.casa.cgf.cx> <4DD958FE.5060208@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DD958FE.5060208@cs.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00164.txt.bz2

On May 22 14:42, Ryan Johnson wrote:
> On 21/05/2011 9:44 PM, Christopher Faylor wrote:
> >On Wed, May 11, 2011 at 02:31:37PM -0400, Ryan Johnson wrote:
> >>Hi all,
> >>
> >>This patch has the parent sort its dll list topologically by
> >>dependencies. Previously, attempts to load a DLL_LOAD dll risked pulling
> >>in dependencies automatically, and the latter would then not benefit
> >>from the code which "encourages" them to land in the right places.  The
> >>dependency tracking is achieved using a simple class which allows to
> >>introspect a mapped dll image and pull out the dependencies it lists.
> >>The code currently rebuilds the dependency list at every fork rather
> >>than attempt to update it properly as modules are loaded and unloaded.
> >>Note that the topsort optimization affects only cygwin dlls, so any
> >>windows dlls which are pulled in dynamically (directly or indirectly)
> >>will still impose the usual risk of address space clobbers.
> >This seems CPU and memory intensive during a time for which we already
> >know is very slow.  Is the benefit really worth it?  How much more robust
> >does it make forking?
> Topological sorting is O(n), so there's no asymptotic change in
> performance. Looking up dependencies inside a dll is *very* cheap

Btw., isn't the resulting dependency list identical to the list
maintained in the PEB_LDR_DATA member InInitializationOrderModuleList?
Or, in other words, can't we just use the data which is already
available?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
