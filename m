Return-Path: <cygwin-patches-return-1805-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8407 invoked by alias); 28 Jan 2002 19:03:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8390 invoked from network); 28 Jan 2002 19:03:45 -0000
Date: Mon, 28 Jan 2002 11:03:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: include/sys/strace.h
Message-ID: <20020128190330.GB5721@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020128170312.GB3669@redhat.com> <Pine.NEB.4.30.0201280938420.5761-100000@cesium.clock.org> <20020128181639.GB4930@redhat.com> <117546176069.20020128213346@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117546176069.20020128213346@logos-m.ru>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00162.txt.bz2

On Mon, Jan 28, 2002 at 09:33:46PM +0300, egor duda wrote:
>Hi!
>
>Monday, 28 January, 2002 Christopher Faylor cgf@redhat.com wrote:
>
>>>> >Chris, I'd actually kinda like to see this included, I can see it being
>>>> >handy from time to time.
>>>>
>>>> I don't agree.  It seems to me that this is easy enough to do with gdb.
>>>> I don't see any reason for it.
>>>
>>>The use case I see is when gdb hangs/crashes or the entire cygwin DLL
>>>hangs/crashes. In those instances, having a non-cygwin program that can
>>>monitor debug output would be highly useful.
>
>CF> However, your example doesn't make any sense to me.  I use the techniques
>CF> in how-to-debug-cygwin.txt and I've never had any problems.  There should
>CF> never issue of a hanging cygwin if you use these techniques.
>
>Ditto. Actually, strace is fully functional substitute for DbgView
>here. I know only of one more feature that may be useful: We may want
>to add one more type of *_printf, say private_printf, that is never
>used in main source tree. If someone has pinpointed the bug but
>suffers from "bug disappears under strace" problem, s/he just adds
>that private_printf()s to the code in question and sets strace mask to 
>catch only those "private" debug messages. That is, one can guarantee
>that strace won't be flooded with "ordinary" strace output. Does this
>make sense? I used this technique some time ago and can produce a
>patch if needed. 

I think this is what "minimal_printf" was supposed to accomplish but I
like the idea of a private_printf for this use.

We also need to resurrect the "attach to running process" capabilities
that you (Egor) submitted a patch for, IIRC.

I think I'll do that now.  I'm about to go into a boring meeting.

cgf
