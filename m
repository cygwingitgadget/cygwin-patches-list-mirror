Return-Path: <cygwin-patches-return-6154-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11255 invoked by alias); 4 Nov 2007 17:57:44 -0000
Received: (qmail 11243 invoked by uid 22791); 4 Nov 2007 17:57:43 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-70-20-17-24.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (70.20.17.24)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 04 Nov 2007 17:57:41 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 5D3582B353; Sun,  4 Nov 2007 12:57:39 -0500 (EST)
Date: Sun, 04 Nov 2007 17:57:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Rewrite/fix cygwin1.dbg generation
Message-ID: <20071104175738.GA21828@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <472CB021.5040806@portugalmail.pt> <472CB37A.407FAE34@dessent.net> <20071104022028.GA6236@ednor.casa.cgf.cx> <472D43F5.4090700@portugalmail.pt> <472D7956.28174D88@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472D7956.28174D88@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00006.txt.bz2

On Sun, Nov 04, 2007 at 12:48:38AM -0700, Brian Dessent wrote:
>Pedro Alves wrote:
>
>> 10 .cygheap      000a0000  611e0000  611e0000  00000000  2**2
>>                   ALLOC
>> 11 .gnu_debuglink 00000010  61280000  61280000  001d0a00  2**2
>>                   CONTENTS, READONLY, DEBUGGING
>> 
>> I'll come up with a different fix.
>
>Just thinking out loud here... what about teaching objcopy that when
>doing --add-gnu-debuglink if there'a already a section named
>.gnu_debuglink (and it's of sufficient length to hold the .dbg filename)
>that it can just rewrite its contents, rather than appending a new
>section?  That way we can continue to allocate the section in the link
>script (except without having to call it .gnu_debuglink_overlay) so that
>we can put the .cygheap last, but we don't have to do the dllfixdbg
>hackery to get the ordering correct.

That would be fine with me.  OTOH, if the dllfixdbg isn't doing the
right thing for gdb couldn't it be adapted to include the required
sections?

cgf
