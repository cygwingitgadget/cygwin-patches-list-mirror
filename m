Return-Path: <cygwin-patches-return-5737-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7444 invoked by alias); 2 Feb 2006 17:47:24 -0000
Received: (qmail 7421 invoked by uid 22791); 2 Feb 2006 17:47:23 -0000
X-Spam-Check-By: sourceware.org
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 02 Feb 2006 17:47:23 +0000
Received: from rainbow ([192.168.1.165]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830); 	 Thu, 2 Feb 2006 17:47:19 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Cc: <gdb-patches@sourceware.org>
Subject: RE: [patch] fix spurious SIGSEGV faults under Cygwin
Date: Thu, 02 Feb 2006 17:47:00 -0000
Message-ID: <009501c62820$b6aaf700$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <43E24462.67E8F280@dessent.net>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00046.txt.bz2

On 02 February 2006 17:42, Brian Dessent wrote:

> Dave Korn wrote:
> 
>>   I'm having a conceptual difficulty here: Under what circumstances
>> would you expect there *not* to be a debugger attached to the inferior
>> to which the debugger is attached?  That's a bit zen, isn't it? 
> 
> The code in question here runs many times in the normal course of any
> Cygwin program -- debugger or no.  The idea behind guarding the call to 
> OutputDebugString() with "if (being_debugged())" was that the call to
> IsDebuggerPresent() was cheaper than the call to OutputDebugString(), and
> that a well-behaived, non-debug build of a binary should not needlessly
> send tons and tons of nonsense to OutputDebugString unless it's actually
> being debugged and there is something there to interpret the nonsense.   


  Um, that's two people now who thought I was referring to the cygwin side of the patch.

  No, this is the bit of your post that I was replying to:

"then gdb could simply read that variable in the process' memory before deciding whether to handle the fault. "

  Is it the case that IsDebuggerPresent doesn't detect when gdb is attached?

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
