Return-Path: <cygwin-patches-return-6205-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30944 invoked by alias); 21 Dec 2007 17:33:17 -0000
Received: (qmail 30934 invoked by uid 22791); 21 Dec 2007 17:33:16 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 21 Dec 2007 17:33:08 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Fri, 21 Dec 2007 17:33:05 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: "'Cygwin patches'" <cygwin-patches@cygwin.com>
References: <0b0d01c83bef$e9364690$2e08a8c0@CAM.ARTIMI.COM>
Subject: RE: Cygheap page boundary allocation bug.
Date: Fri, 21 Dec 2007 17:33:00 -0000
Message-ID: <050701c843f7$8b497790$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <0b0d01c83bef$e9364690$2e08a8c0@CAM.ARTIMI.COM>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00057.txt.bz2

On 11 December 2007 12:18, Dave Korn wrote:

>   Bug is present on, and patch applies cleanly to, both branch and trunk.
> 
> 2007-12-11  Dave Korn  <dave.korn>
> 
> 	* cygheap.cc (_csbrk):  Don't request zero bytes from VirtualAlloc,
> 	as windows treats that as an invalid parameter and returns an error.


  :-)  I just discovered this fixes

FAIL: pthread/cancel11.c (execute)


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
