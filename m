Return-Path: <cygwin-patches-return-6207-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5014 invoked by alias); 21 Dec 2007 19:05:29 -0000
Received: (qmail 4975 invoked by uid 22791); 21 Dec 2007 19:05:25 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 21 Dec 2007 19:05:16 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Fri, 21 Dec 2007 19:05:13 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: "'Cygwin patches'" <cygwin-patches@cygwin.com>
References: <050e01c84401$be876720$2e08a8c0@CAM.ARTIMI.COM>
Subject: RE: Export fast *rint* functions
Date: Fri, 21 Dec 2007 19:05:00 -0000
Message-ID: <051501c84404$6a8f8e10$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <050e01c84401$be876720$2e08a8c0@CAM.ARTIMI.COM>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00059.txt.bz2

On 21 December 2007 18:46, Dave Korn wrote:

>     Hi gang,
> 
>   This patch exports all the new _f_*rint* functions from newlib

  Doh.  I sorted the list wrong, _f_lrint* and _f_llrint* are swapped over.  Take it
as read that I'll put them the other way round before committing anything.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
