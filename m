Return-Path: <cygwin-patches-return-4548-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4858 invoked by alias); 1 Feb 2004 21:58:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4838 invoked from network); 1 Feb 2004 21:58:25 -0000
Message-Id: <3.0.5.32.20040201165730.007f5b30@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 01 Feb 2004 21:58:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: ciresrv.parent
In-Reply-To: <20040201183904.GA23376@redhat.com>
References: <3.0.5.32.20040131141848.008138b0@incoming.verizon.net>
 <3.0.5.32.20040131141848.008138b0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q1/txt/msg00038.txt.bz2

At 01:39 PM 2/1/2004 -0500, Christopher Faylor wrote:
>On Sat, Jan 31, 2004 at 02:18:48PM -0500, Pierre A. Humblet wrote:
>>Fortunately it is never used in the case of spawn: all handles are
>>inherited, or the parent does the work (sockets). 
>
>The one placed the handle is actually used is in
>fhandler_socket::fixup_after_exec.  I'd like Corinna's confirmation
>before this patch is checked in.

Good idea. FWIW, I checked that one carefully. That's why I found
the secret_event bug a while back. I also tested on Win95 with an
old winsock. 
It looks like the handle might be used, but the tests for close
on exec always block the paths where it is actually used. 

Pierre
