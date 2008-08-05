Return-Path: <cygwin-patches-return-6347-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15885 invoked by alias); 5 Aug 2008 14:04:19 -0000
Received: (qmail 15606 invoked by uid 22791); 5 Aug 2008 14:04:17 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 05 Aug 2008 14:03:18 +0000
Received: from ALBATROSS ([192.168.1.150]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Tue, 5 Aug 2008 15:03:15 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
References: <4897E0E8.AB669CAC@dessent.net> <4897E4C7.88A64A3C@dessent.net>
Subject: RE: [PATCH] fix profiling
Date: Tue, 05 Aug 2008 14:04:00 -0000
Message-ID: <004801c8f704$0131cd30$9601a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <4897E4C7.88A64A3C@dessent.net>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00010.txt.bz2

Brian Dessent wrote on 05 August 2008 06:28:

> Brian Dessent wrote:
> 
>> Since this code is lifted from the BSDs I did check that this change was
>> made there as well, e.g.
>>
<http://www.openbsd.org/cgi-bin/cvsweb/src/sys/arch/i386/include/profile.h?r
ev=1.10&content-type=text/x-cvsweb-markup>.

  Adding 'volatile' to asms that didn't need it could never do any harm,
anyway, apart from the minor missed-optimisation opportunities it implies,
but correctness is more important here!
 
> Actually, I also missed that the above version uses +r instead of =r for
> the second constraint.  I guess we should make that change too.

  I think that change is wrong.  The register is written, not read; the
input value is not used.  (The fact it is used as a source operand in the
second instruction doesn't matter, because it's not the input value being
used there but the previously-written value that just clobbered the input
value).  It looks like a misunderstanding of what read-write means in terms
of gcc constraints.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
