Return-Path: <cygwin-patches-return-5736-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4570 invoked by alias); 2 Feb 2006 17:43:56 -0000
Received: (qmail 4552 invoked by uid 22791); 2 Feb 2006 17:43:55 -0000
X-Spam-Check-By: sourceware.org
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 02 Feb 2006 17:43:54 +0000
Received: from rainbow ([192.168.1.165]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830); 	 Thu, 2 Feb 2006 17:43:51 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: "'Daniel Jacobowitz'" <drow@false.org>
Cc: <cygwin-patches@cygwin.com>, 	<gdb-patches@sourceware.org>
Subject: RE: [patch] fix spurious SIGSEGV faults under Cygwin
Date: Thu, 02 Feb 2006 17:43:00 -0000
Message-ID: <009401c62820$3ab87730$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20060202173806.GA5349@nevyn.them.org>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00045.txt.bz2

On 02 February 2006 17:38, Daniel Jacobowitz wrote:

> On Thu, Feb 02, 2006 at 05:30:23PM -0000, Dave Korn wrote:
>>   ?????!
>> 
>>   I'm having a conceptual difficulty here: Under what circumstances
>> would you expect there *not* to be a debugger attached to the inferior
>> to which the debugger is attached?  That's a bit zen, isn't it?
> 
> You missed that half the patch was for Cygwin - you even sent your reply
> to cygwin-patches. 


  Nope, I didn't miss that bit.  I can see the point in the cygwin side of the patch, for when there _isn't_ a debugger attached,
and the cygwin library has to know whether the exception will be handled by a debugger or whether it has to wrap the access in a
SEH.

  What I can't see is any point in gdb reading a variable from the inferior that tells gdb if there is a debugger attached to the
inferior, because I can't see how gdb could read that variable except by attaching to the inferior, at which point the value in the
variable should always be 'true', shouldn't it? 


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
