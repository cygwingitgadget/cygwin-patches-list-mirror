Return-Path: <cygwin-patches-return-3888-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14180 invoked by alias); 24 May 2003 19:06:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14156 invoked from network); 24 May 2003 19:06:39 -0000
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] fix for process virtual size display
Date: Sat, 24 May 2003 19:06:00 -0000
Message-ID: <ICEBIHGCEJIPLNMBNCMKCEKACGAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20030521164816.GA4885@redhat.com>
Importance: Normal
X-SW-Source: 2003-q2/txt/msg00115.txt.bz2

> On Tue, May 20, 2003 at 08:31:06AM -0400, Joe Buehler wrote:
> >Pierre A. Humblet wrote:
> >
> >>MEM_RESERVE Reserves a range of the process's virtual address space
> >>without allocating any actual physical storage in memory or in
> the paging
> >>file on disk. Other memory allocation functions, such as malloc and
> >>LocalAlloc, cannot use a reserved range of memory until it is released.
> >
> >Yes -- I am wondering what Windows is really doing internally, though.
> >
> >What does it mean that no physical storage is allocated in memory?
> >Obviously
> >no pages are allocated.  But do they allocate page tables so
> they can catch
> >accesses to the reserved memory?  Or for performance reasons, so it can
> >be changed to committed faster?
> >
> >They're keeping track of reserved memory somehow, the question is what
> >amount of resource is being dedicated to the task.
>
> If I understand this thread correctly, Chris is not comfortable with the
> patch as is.  So, I'll wait for an updated patch given his suggestions?

I did some more reading around this and found that a lot of Unix systems
don't actually have a concept of reserved memory. Given that a large amount
of memory is reserved, but never comitted by Cygwin processes, this reserved
memory skews the vmsize quite a bit. With this patch, the values are a lot
more like Linux, therefore I'm actually for this patch being committed.

Chris
