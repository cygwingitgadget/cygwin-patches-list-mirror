Return-Path: <cygwin-patches-return-7389-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7752 invoked by alias); 23 May 2011 07:32:27 -0000
Received: (qmail 7617 invoked by uid 22791); 23 May 2011 07:32:03 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 23 May 2011 07:31:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E5BCA2CA0E6; Mon, 23 May 2011 09:31:39 +0200 (CEST)
Date: Mon, 23 May 2011 07:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (2/5)
Message-ID: <20110523073139.GA17244@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00155.txt.bz2

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
> (2-3 pointer dereferences per dep), and all of this only happens for
> dynamically-loaded dlls. Given the number of calls to
> Virtual{Alloc,Query,Free} and LoadDynamicLibraryEx which we make, I
> would be surprised if the topsort even registered.  That said, it is
> extra work and will slow down fork.
> 
> I have not been able to test how much it helps, but it should help
> with the test case Jon Turney reported with python a while back [1].
> In fact, it was that example which made me aware of the potential
> need for a topsort in the first place.
> 
> In theory, this should completely eliminate the case where us
> loading one DLL pulls in dependencies automatically (= uncontrolled
> and at Windows' whim). The problem would manifest as a DLL which
> "loads" in the same wrong place repeatedly when given the choice,
> and for which we would be unable to VirtualAlloc the offending spot
> (because the dll in question has non-zero refcount even after we
> unload it, due to the dll(s) that depend on it. 

There might be a way around this.  It seems to be possible to tweak
the module list the PEB points to so that you can unload a library
even though it has dependencies.  Then you can block the unwanted
space and call LoadLibrary again.  See (*) for a discussion how
you can unload the exe itself to reload another one.  Maybe that's
something we can look into as well.  ObNote:  Of course, if we
could influnce the address at which a DLL gets loaded right from the
start, it would be the preferrable solution.


Corinna

(*) http://www.blizzhackers.cc/viewtopic.php?p=4332690

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
