Return-Path: <cygwin-patches-return-3862-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16754 invoked by alias); 19 May 2003 22:08:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14788 invoked from network); 19 May 2003 22:07:33 -0000
Message-ID: <3EC955FC.4BD6BB58@ieee.org>
Date: Mon, 19 May 2003 22:08:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: jbuehler@hekimian.com
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix for process virtual size display
References: <ICEBIHGCEJIPLNMBNCMKOEFACGAA.chris@atomice.net> <3EC953C6.7040908@hekimian.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00089.txt.bz2

Joe Buehler wrote:
>
> 
> Does anyone on the list know what "reserved" memory means in Windows?  What
> does the kernel actually allocate?  Is there just a few bytes indicating the
> the memory range is "reserved"?  Or are page tables allocated for the reserved
> memory?  Or????
> --
> Joe Buehler

<http://msdn.microsoft.com/library/default.asp?url=/library/en-us/memory/base/virtualalloc.asp>

MEM_RESERVE Reserves a range of the process's virtual address space without 
allocating any actual physical storage in memory or in the paging file on disk. 
Other memory allocation functions, such as malloc and LocalAlloc, cannot use a 
reserved range of memory until it is released.

Pierre
