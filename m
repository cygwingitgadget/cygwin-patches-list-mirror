Return-Path: <cygwin-patches-return-6202-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11291 invoked by alias); 21 Dec 2007 02:00:09 -0000
Received: (qmail 11279 invoked by uid 22791); 21 Dec 2007 02:00:08 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 21 Dec 2007 01:59:59 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Fri, 21 Dec 2007 01:59:55 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
References: <836045.82708.qm@web33207.mail.mud.yahoo.com> <476A726D.50100@byu.net> <476A78EF.2322FB0A@dessent.net> <476A8729.5C05B169@dessent.net> <20071220211130.GA28771@ednor.casa.cgf.cx>
Subject: RE: [patch] un-NT-ify cygcheck (was: cygwin 1.5.25-7: cygcheck 	does not   work?)
Date: Fri, 21 Dec 2007 02:00:00 -0000
Message-ID: <047a01c84375$2f2cf810$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20071220211130.GA28771@ednor.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00054.txt.bz2

On 20 December 2007 21:12, Christopher Faylor wrote:

> On Thu, Dec 20, 2007 at 07:15:53AM -0800, Brian Dessent wrote:
>> The attached patch un-NT-ifies bloda.cc but sadly a similar cleanup is
>> still required for cygpath as well if we are to support 9x/ME out of the
>> 1.5 branch. In that case I suppose you could just revert cygpath.cc to
>> an older revision before the native APIs were added.

> I had something similar in my sandbox but 1) you beat me to it and 2)
> yours is better.  So, please check this into the trunk.  I don't have
> any problem with cygcheck being Windows 9x aware since it could help us
> track down problems with people who are trying to run Cygwin 1.7.x on
> older systems.
> 
> Unless Corinna says differently, I think she wants to be in control of
> what goes into the branch so I don't want to suggest that you should
> check it in there too.

  But it only belongs on the branch at all, doesn't it?  When I wrote bloda.cc, I
didn't bother with 9x compat, because I was only writing it for HEAD, where we have
stopped supporting 9x.

  Surely there are many other reasons why HEAD won't work on 9x, so the only benefit
would be in applying this patch to the branch?

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
