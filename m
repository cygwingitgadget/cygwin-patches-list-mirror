Return-Path: <cygwin-patches-return-5298-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2979 invoked by alias); 1 Jan 2005 17:20:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2965 invoked from network); 1 Jan 2005 17:20:48 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 1 Jan 2005 17:20:48 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 22AC71B401; Sat,  1 Jan 2005 12:20:57 -0500 (EST)
Date: Sat, 01 Jan 2005 17:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Large processes shared.cc fix
Message-ID: <20050101172057.GC10993@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.56.0412311549120.20233@inferno-01.cs.huji.ac.il> <20041231184121.GB8874@trixie.casa.cgf.cx> <Pine.LNX.4.56.0412312318350.8480@inferno-01.cs.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0412312318350.8480@inferno-01.cs.huji.ac.il>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2005-q1/txt/msg00001.txt.bz2

On Fri, Dec 31, 2004 at 11:28:15PM +0200, Eizenberg Ariel wrote:
>The original code in open_shared() runs as follows:
>Hope this clears it up.

Since the situation which triggers this invalidates the assumption
that the shared memory will be loaded in the same place in cygwin children,
it doesn't seem like there is any reason to use offsets after the failure.

So, something like the below would be less intrusive, I think.

Does this have the desired effect?

cgf

Index: shared.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/shared.cc,v
retrieving revision 1.84
diff -u -p -r1.84 shared.cc
--- shared.cc	3 Dec 2004 02:00:37 -0000	1.84
+++ shared.cc	1 Jan 2005 17:20:03 -0000
@@ -79,7 +79,7 @@ open_shared (const char *name, int n, HA
   void *shared;
 
   void *addr;
-  if (!wincap.needs_memory_protection ())
+  if (!wincap.needs_memory_protection () && offsets[0])
     addr = NULL;
   else
     {
@@ -116,12 +116,13 @@ open_shared (const char *name, int n, HA
       if (wincap.is_winnt ())
 	system_printf ("relocating shared object %s(%d) from %p to %p on Windows NT", name, n, addr, shared);
 #endif
+      offsets[0] = NULL;
     }
 
   if (!shared)
     api_fatal ("MapViewOfFileEx '%s'(%p), %E.  Terminating.", name, shared_h);
 
-  if (m == SH_CYGWIN_SHARED && wincap.needs_memory_protection ())
+  if (m == SH_CYGWIN_SHARED && offsets[0] && wincap.needs_memory_protection ())
     {
       unsigned delta = (char *) shared - offsets[0];
       offsets[0] = (char *) shared;
