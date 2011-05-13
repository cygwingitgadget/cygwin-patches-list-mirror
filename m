Return-Path: <cygwin-patches-return-7362-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13611 invoked by alias); 13 May 2011 06:52:12 -0000
Received: (qmail 13396 invoked by uid 22791); 13 May 2011 06:51:45 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 13 May 2011 06:51:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D99662C0577; Fri, 13 May 2011 08:51:27 +0200 (CEST)
Date: Fri, 13 May 2011 06:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110513065127.GA5636@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de> <20110512121012.GB18135@calimero.vinschen.de> <20110512150910.GE18135@calimero.vinschen.de> <4DCC0B5C.4040901@cs.utoronto.ca> <20110512165520.GB3020@calimero.vinschen.de> <4DCC1E7C.2060804@cs.utoronto.ca> <20110512184233.GE3020@calimero.vinschen.de> <4DCC354F.3030900@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DCC354F.3030900@cs.utoronto.ca>
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
X-SW-Source: 2011-q2/txt/msg00128.txt.bz2

On May 12 15:30, Ryan Johnson wrote:
> On 12/05/2011 2:42 PM, Corinna Vinschen wrote:
> >On May 12 13:53, Ryan Johnson wrote:
> >>On 12/05/2011 12:55 PM, Corinna Vinschen wrote:
> >>>>>    heap *heaps;
> >>>>This is a misnomer now -- it's really a list of heap regions/blocks.
> >>>I don't think so.  The loop stores only the blocks which constitute
> >>>the original VirtualAlloc'ed memory regions.  They are not the real
> >>>heap blocks returned by Heap32First/Heap32Next.  These are filtered
> >>>out by checking for flags&   2 (**).
> >>Sorry, I cut too much context out of the diff. That's
> >>heap_info::heaps, which indeed refers to heap regions which we
> >>identified by checking flags&2 (that's why it needs the heap_id
> >>inside it now, where it didn't before) (++)
> >So you think something like heap_chunks is better?
> Maybe. I actually only noticed because the code snippet you
> originally sent also used 'heaps' as an identifier and the two
> clashed when I pasted it in ;)

I've renamed it to heap_vm_chunks and checked my patch in.

I'm going to follow up on the cygwin-developers list.  Now that we have
your excellent maps output, it's pretty easy to see where the potential
problems for fork are.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
