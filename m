Return-Path: <cygwin-patches-return-3863-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29947 invoked by alias); 20 May 2003 12:31:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29918 invoked from network); 20 May 2003 12:31:07 -0000
Message-ID: <3ECA200A.6060807@hekimian.com>
Date: Tue, 20 May 2003 12:31:00 -0000
X-Sybari-Trust: 4f70824f 36b09be0 523a3db8 00000109
From: Joe Buehler <jbuehler@hekimian.com>
Reply-To:  jbuehler@hekimian.com
Organization: Spirent Communications, Inc.
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
CC:  cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix for process virtual size display
References: <ICEBIHGCEJIPLNMBNCMKOEFACGAA.chris@atomice.net> <3EC953C6.7040908@hekimian.com> <3EC955FC.4BD6BB58@ieee.org>
In-Reply-To: <3EC955FC.4BD6BB58@ieee.org>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00090.txt.bz2

Pierre A. Humblet wrote:

> MEM_RESERVE Reserves a range of the process's virtual address space without 
> allocating any actual physical storage in memory or in the paging file on disk. 
> Other memory allocation functions, such as malloc and LocalAlloc, cannot use a 
> reserved range of memory until it is released.

Yes -- I am wondering what Windows is really doing internally, though.

What does it mean that no physical storage is allocated in memory?  Obviously
no pages are allocated.  But do they allocate page tables so they can catch
accesses to the reserved memory?  Or for performance reasons, so it can
be changed to committed faster?

They're keeping track of reserved memory somehow, the question is what
amount of resource is being dedicated to the task.
-- 
Joe Buehler
