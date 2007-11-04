Return-Path: <cygwin-patches-return-6153-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31647 invoked by alias); 4 Nov 2007 07:48:48 -0000
Received: (qmail 31635 invoked by uid 22791); 4 Nov 2007 07:48:48 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 04 Nov 2007 07:48:45 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1IoaDn-0007dI-98; Sun, 04 Nov 2007 07:48:39 +0000
Message-ID: <472D7956.28174D88@dessent.net>
Date: Sun, 04 Nov 2007 07:48:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: Pedro Alves <pedro_alves@portugalmail.pt>
CC: cygwin-patches@cygwin.com
Subject: Re: Rewrite/fix cygwin1.dbg generation
References: <472CB021.5040806@portugalmail.pt> <472CB37A.407FAE34@dessent.net> <20071104022028.GA6236@ednor.casa.cgf.cx> <472D43F5.4090700@portugalmail.pt>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00005.txt.bz2

Pedro Alves wrote:

> 10 .cygheap      000a0000  611e0000  611e0000  00000000  2**2
>                   ALLOC
> 11 .gnu_debuglink 00000010  61280000  61280000  001d0a00  2**2
>                   CONTENTS, READONLY, DEBUGGING
> 
> I'll come up with a different fix.

Just thinking out loud here... what about teaching objcopy that when
doing --add-gnu-debuglink if there'a already a section named
.gnu_debuglink (and it's of sufficient length to hold the .dbg filename)
that it can just rewrite its contents, rather than appending a new
section?  That way we can continue to allocate the section in the link
script (except without having to call it .gnu_debuglink_overlay) so that
we can put the .cygheap last, but we don't have to do the dllfixdbg
hackery to get the ordering correct.

The downside here would be that if we rely on this feature of objcopy
then we'd need to either require bleeding edge binutils to build Cygwin
or do some kind of autoconf runtime test to test for behavior.  Still,
it would be nice to lay the groundwork for being able to one day retire
the hackery.

Brian
