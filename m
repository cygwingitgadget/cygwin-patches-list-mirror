Return-Path: <cygwin-patches-return-6250-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19702 invoked by alias); 22 Feb 2008 08:30:19 -0000
Received: (qmail 19690 invoked by uid 22791); 22 Feb 2008 08:30:18 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 22 Feb 2008 08:29:44 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JSTHn-0006Us-Rb; Fri, 22 Feb 2008 08:29:41 +0000
Message-ID: <47BE881B.6DA856E@dessent.net>
Date: Fri, 22 Feb 2008 08:30:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: Noel Burton-Krahn <noel@burton-krahn.com>
CC: cygwin-patches@cygwin.com
Subject: Re: PATCH: avoid system shared memory version mismatch detected by   versioning shared memory name
References: <674fdff20802211641p19f7b3a1pb3f843ba262dfde6@mail.gmail.com> 	 <674fdff20802211701u1a866d2fw2bb21047ecc5e8ea@mail.gmail.com> 	 <20080222050020.GA17196@ednor.casa.cgf.cx> <674fdff20802212117k1936a3bcrb79175546d973ce3@mail.gmail.com>
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
X-SW-Source: 2008-q1/txt/msg00024.txt.bz2

Noel Burton-Krahn wrote:

> The problem is there are several installable apps built on Cygwin,
> like EAC, ClamAV, and one I just found which is a
> Cygwin-on-a-thumbdrive.  The problem is they can't all coexist because
> they're distributed with different versions of the cygwin dlls.
> Making them work with the current cygwin means hand-copying cygwin
> dlls into application directories, and repeating that every time you
> upgrade. People used to give Windows a hard time for DLL hell!  I
> don't see the benefit of forcing users to hand-maintain cygwin dlls
> across multiple applications.

But we go to great pains to make the DLL binary backwards compatible
always.  So in this case all you have to do is maintain one copy in the
PATH and make sure it's the most recent, deleting all others.  This
should be a job for the installers of those 3PPs.

Besides, the shared memory region is only one of a whole bunch of IPC
objects that would need their own namespace if you wanted the true
ability to insulate two versions of Cygwin.  Fire up process explorer,
click on the handle search, and enter cygwin1S4 to get a rough list.  To
truly make this work you'd need to change shared_prefix.  And the
registry key for the mount table.  And probably other things too.

Brian
