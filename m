Return-Path: <cygwin-patches-return-5296-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16201 invoked by alias); 31 Dec 2004 21:28:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16167 invoked from network); 31 Dec 2004 21:28:18 -0000
Received: from unknown (HELO cs1.cs.huji.ac.il) (132.65.16.10)
  by sourceware.org with SMTP; 31 Dec 2004 21:28:18 -0000
Received: from inferno-01.cs.huji.ac.il ([132.65.32.101])
	by cs1.cs.huji.ac.il with esmtp
	id 1CkUJj-0004KK-QA
	for cygwin-patches@cygwin.com; Fri, 31 Dec 2004 23:28:15 +0200
Received: from arielez by inferno-01.cs.huji.ac.il with local (Exim 3.36 #1)
	id 1CkUJj-0002Ic-00
	for cygwin-patches@cygwin.com; Fri, 31 Dec 2004 23:28:15 +0200
Date: Fri, 31 Dec 2004 21:28:00 -0000
From: Eizenberg Ariel <arielez@cs.huji.ac.il>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Large processes shared.cc fix
In-Reply-To: <20041231184121.GB8874@trixie.casa.cgf.cx>
Message-ID: <Pine.LNX.4.56.0412312318350.8480@inferno-01.cs.huji.ac.il>
References: <Pine.LNX.4.56.0412311549120.20233@inferno-01.cs.huji.ac.il>
 <20041231184121.GB8874@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q4/txt/msg00297.txt.bz2

The original code in open_shared() runs as follows:

  shared = (shared_info*)MapViewOfFileEx(shared_h, ..., addr);
-> this fails

  if(!shared)
  {
     shared = (shared_info*)MapViewOfFileEx(shared_h, ..., NULL);
->  this returns 0x3d0000
  }

  if(m == SH_CYGWIN_SHARED && ...)
  {
    unsigned delta = ...;
    ...
    for(int i = SH_CYGWIN_SHARED + 1 ; i < SH_TOTAL_SIZE; i ++)
    {
       unsigned size = ...;
       offsets[i] += delta;
-> for i >= 3, offsets[i] >= 0x400000, which is the image base address
       if(!VirtualAlloc(offsets[i], size, ...))
            continue;
-> so for i >= 3, this fails
  }

now, when pinfo::init() requests
    mapaddr = open_shared(NULL, 0, hdummy, 0, SH_MYSELF)

open_shared() returns and address at 0x420000 because of:
   addr = offsets[m];
   if(!size)
     return addr;

altough addr might be illegal.

Now when pinfo::init() continues,
  procinfo = (_pinfo *)MapViewOfFileEx(h, ...., mapaddr);

which fails, and we get an api_fatal().

So the purpose of my patch is to make sure offsets[i] is always a
valid address for allocation.

Hope this clears it up.

Thanks.


On Fri, 31 Dec 2004, Christopher Faylor wrote:

|  On Fri, Dec 31, 2004 at 03:58:20PM +0200, Eizenberg Ariel wrote:
|  >Hi,
|  >
|  >This patch fixes a problem I have with running large fortran programs
|  >(actually most programs with a very large image size in memory). The
|  >problem occurs on Windows 2000, XP and 2003.
|  >
|  >The problem occurs when a process is large enough so when open_shared()
|  >tries to map the shared memory section to 0x0A000000, it fails, since
|  >0x0A000000 is occupied by the program. Since the
|  >MapViewOfFileEx(h,...,NULL) is preformed on a region smaller than the full
|  >region required for offsets[SH_TOTAL_SIZE], MapViewOfFileEx might allocate
|  >a region at a location which does not have enough free space after it,
|  >so the VirtualAlloc's at the end of open_shared() silently fail
|  >(in my case MapViewOfFileEx() returns 0x3d0000).
|
|  So, why is this a problem?  Why doesn't the "if (!shared)" immediately after
|  the first MapViewOfFileEx just avoid allocating the other non SH_CYGWIN_SHARED
|  shared memory regions at a fixed location?  That is what that code is there
|  to handle.
|
|  cgf
|
|
