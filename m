Return-Path: <cygwin-patches-return-5299-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14149 invoked by alias); 1 Jan 2005 20:50:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14120 invoked from network); 1 Jan 2005 20:50:24 -0000
Received: from unknown (HELO cs1.cs.huji.ac.il) (132.65.16.10)
  by sourceware.org with SMTP; 1 Jan 2005 20:50:24 -0000
Received: from inferno-01.cs.huji.ac.il ([132.65.32.101])
	by cs1.cs.huji.ac.il with esmtp
	id 1CkqCX-0001jD-Jv
	for cygwin-patches@cygwin.com; Sat, 01 Jan 2005 22:50:17 +0200
Received: from arielez by inferno-01.cs.huji.ac.il with local (Exim 3.36 #1)
	id 1CkqCX-00087e-00
	for cygwin-patches@cygwin.com; Sat, 01 Jan 2005 22:50:17 +0200
Date: Sat, 01 Jan 2005 20:50:00 -0000
From: Eizenberg Ariel <arielez@cs.huji.ac.il>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Large processes shared.cc fix
In-Reply-To: <20050101172057.GC10993@trixie.casa.cgf.cx>
Message-ID: <Pine.LNX.4.56.0501012249570.31170@inferno-01.cs.huji.ac.il>
References: <Pine.LNX.4.56.0412311549120.20233@inferno-01.cs.huji.ac.il>
 <20041231184121.GB8874@trixie.casa.cgf.cx> <Pine.LNX.4.56.0412312318350.8480@inferno-01.cs.huji.ac.il>
 <20050101172057.GC10993@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q1/txt/msg00002.txt.bz2

This fixes the problem!

Thanks.

On Sat, 1 Jan 2005, Christopher Faylor wrote:

|  On Fri, Dec 31, 2004 at 11:28:15PM +0200, Eizenberg Ariel wrote:
|  >The original code in open_shared() runs as follows:
|  >Hope this clears it up.
|
|  Since the situation which triggers this invalidates the assumption
|  that the shared memory will be loaded in the same place in cygwin children,
|  it doesn't seem like there is any reason to use offsets after the failure.
|
|  So, something like the below would be less intrusive, I think.
|
|  Does this have the desired effect?
|
|  cgf
|
|  Index: shared.cc
|  ===================================================================
|  RCS file: /cvs/src/src/winsup/cygwin/shared.cc,v
|  retrieving revision 1.84
|  diff -u -p -r1.84 shared.cc
|  --- shared.cc	3 Dec 2004 02:00:37 -0000	1.84
|  +++ shared.cc	1 Jan 2005 17:20:03 -0000
|  @@ -79,7 +79,7 @@ open_shared (const char *name, int n, HA
|     void *shared;
|
|     void *addr;
|  -  if (!wincap.needs_memory_protection ())
|  +  if (!wincap.needs_memory_protection () && offsets[0])
|       addr = NULL;
|     else
|       {
|  @@ -116,12 +116,13 @@ open_shared (const char *name, int n, HA
|         if (wincap.is_winnt ())
|   	system_printf ("relocating shared object %s(%d) from %p to %p on Windows NT", name, n, addr, shared);
|   #endif
|  +      offsets[0] = NULL;
|       }
|
|     if (!shared)
|       api_fatal ("MapViewOfFileEx '%s'(%p), %E.  Terminating.", name, shared_h);
|
|  -  if (m == SH_CYGWIN_SHARED && wincap.needs_memory_protection ())
|  +  if (m == SH_CYGWIN_SHARED && offsets[0] && wincap.needs_memory_protection ())
|       {
|         unsigned delta = (char *) shared - offsets[0];
|         offsets[0] = (char *) shared;
|
|
