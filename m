Return-Path: <cygwin-patches-return-2777-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29985 invoked by alias); 6 Aug 2002 22:07:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29971 invoked from network); 6 Aug 2002 22:07:35 -0000
Date: Tue, 06 Aug 2002 15:07:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: init_cheap and _csbrk
Message-ID: <20020806220731.GG1386@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01e501c23d74$400b2c90$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e501c23d74$400b2c90$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00225.txt.bz2

On Tue, Aug 06, 2002 at 07:08:21PM +0100, Conrad Scott wrote:
>I stumbled over this last night but I thought it better to wait
>until I'd had both sleep and pizza before posting it off :-)
>
>The _csbrk function, from "cygheap.cc", is rounding up the first
>allocation to a multiple of a page size, which seems unnecessary
>since VirtualAlloc does that anyway (i.e., if you reserve/commit a
>single byte on a page, it reserves/commits the whole page).  More
>importantly, it can't be right to add the allocation request size
>to the return value for the first allocation (except that the
>first "allocation" is probably always 0, so actually it's
>alright).
>
>And while I was there I moved one initialization about for the
>usual "aesthetic" reasons :-)

I've checked in a modified version of this.  I actually wanted to
allocate some slop for the cygheap but the pagetrunc made sure that
I actually didn't do that.  So, I've changed things so that an extra
couple of pages are allocated.  It would be nice to find out what the
minimal amount of memory used during a small program would be and
just allocate that at the start to minimize calls to VirtualAlloc.

Also my aesthetic sense differs from yours so I didn't apply that part.

Thanks,
cgf
