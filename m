Return-Path: <cygwin-patches-return-6047-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4784 invoked by alias); 22 Mar 2007 22:07:42 -0000
Received: (qmail 4686 invoked by uid 22791); 22 Mar 2007 22:07:41 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 22 Mar 2007 22:07:37 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Thu, 22 Mar 2007 22:07:34 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
References: <20070322210856.GV23239@flim.org>
Subject: RE: [PATCH] w32api: Correct Unicode/Ansi defines for GetMappedFileName
Date: Thu, 22 Mar 2007 22:07:00 -0000
Message-ID: <007401c76cce$7ebb37d0$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20070322210856.GV23239@flim.org>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00028.txt.bz2

On 22 March 2007 21:09, Matthew Gregan wrote:

> Hi,
> 
> Attached is a small patch to correct the Unicode and Ansi defines that
> expose the appropriate W/A variant of GetMappedFileName.

  Looks obviously correct to me.  There's no such thing as the -Ex version of
the function at all.  Wonder where that piece of urban mythology came from?


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
