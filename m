Return-Path: <cygwin-patches-return-5052-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10073 invoked by alias); 12 Oct 2004 22:31:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10055 invoked from network); 12 Oct 2004 22:31:06 -0000
Date: Tue, 12 Oct 2004 22:31:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygheap.cc: Allow _crealloc to shrink memory-block.
Message-ID: <20041012223130.GC847@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.ckhrjl.3vvankf.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ckhrjl.3vvankf.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00053.txt.bz2

On Wed, Oct 13, 2004 at 12:11:24AM +0200, Bas van Gompel wrote:
>Following (trivial IMO) patch, allows memory blocks on the cygheap to
>be shrunk.
>
>There are some issues with this:
>- The code is slightly slower.
>- This change is in a block of code marked ``copyright D. J. Delorie''.
>- I'm not sure _crealloc is ever called with a smaller size. (If it
>  isn't, this patch is useless.)
>
>(I did test this, and it WJFFM.)

Thanks, but I don't see any reason to go to the effort of allocating a
new block of memory in order to get a smaller block of memory.  The
overhead of allocating memory, which could actually cause a call to the
OS, shouldn't be worth it unless you're suffering from severe memory
constraints.  I don't believe that is normally the case for cygheap.

cgf
