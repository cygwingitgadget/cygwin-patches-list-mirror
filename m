Return-Path: <cygwin-patches-return-5294-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6865 invoked by alias); 31 Dec 2004 18:41:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6848 invoked from network); 31 Dec 2004 18:41:16 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 31 Dec 2004 18:41:16 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 778531B401; Fri, 31 Dec 2004 13:41:21 -0500 (EST)
Date: Fri, 31 Dec 2004 18:41:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Large processes shared.cc fix
Message-ID: <20041231184121.GB8874@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.56.0412311549120.20233@inferno-01.cs.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0412311549120.20233@inferno-01.cs.huji.ac.il>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00295.txt.bz2

On Fri, Dec 31, 2004 at 03:58:20PM +0200, Eizenberg Ariel wrote:
>Hi,
>
>This patch fixes a problem I have with running large fortran programs
>(actually most programs with a very large image size in memory). The
>problem occurs on Windows 2000, XP and 2003.
>
>The problem occurs when a process is large enough so when open_shared()
>tries to map the shared memory section to 0x0A000000, it fails, since
>0x0A000000 is occupied by the program. Since the
>MapViewOfFileEx(h,...,NULL) is preformed on a region smaller than the full
>region required for offsets[SH_TOTAL_SIZE], MapViewOfFileEx might allocate
>a region at a location which does not have enough free space after it,
>so the VirtualAlloc's at the end of open_shared() silently fail
>(in my case MapViewOfFileEx() returns 0x3d0000).

So, why is this a problem?  Why doesn't the "if (!shared)" immediately after
the first MapViewOfFileEx just avoid allocating the other non SH_CYGWIN_SHARED
shared memory regions at a fixed location?  That is what that code is there
to handle.

cgf
