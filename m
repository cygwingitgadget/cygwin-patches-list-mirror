Return-Path: <cygwin-patches-return-3870-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25723 invoked by alias); 21 May 2003 16:48:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25677 invoked from network); 21 May 2003 16:48:27 -0000
Date: Wed, 21 May 2003 16:48:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix for process virtual size display
Message-ID: <20030521164816.GA4885@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ICEBIHGCEJIPLNMBNCMKOEFACGAA.chris@atomice.net> <3EC953C6.7040908@hekimian.com> <3EC955FC.4BD6BB58@ieee.org> <3ECA200A.6060807@hekimian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ECA200A.6060807@hekimian.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00097.txt.bz2

On Tue, May 20, 2003 at 08:31:06AM -0400, Joe Buehler wrote:
>Pierre A. Humblet wrote:
>
>>MEM_RESERVE Reserves a range of the process's virtual address space 
>>without allocating any actual physical storage in memory or in the paging 
>>file on disk. Other memory allocation functions, such as malloc and 
>>LocalAlloc, cannot use a reserved range of memory until it is released.
>
>Yes -- I am wondering what Windows is really doing internally, though.
>
>What does it mean that no physical storage is allocated in memory?  
>Obviously
>no pages are allocated.  But do they allocate page tables so they can catch
>accesses to the reserved memory?  Or for performance reasons, so it can
>be changed to committed faster?
>
>They're keeping track of reserved memory somehow, the question is what
>amount of resource is being dedicated to the task.

If I understand this thread correctly, Chris is not comfortable with the
patch as is.  So, I'll wait for an updated patch given his suggestions?

cgf
