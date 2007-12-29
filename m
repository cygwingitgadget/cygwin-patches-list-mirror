Return-Path: <cygwin-patches-return-6220-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3102 invoked by alias); 29 Dec 2007 18:16:09 -0000
Received: (qmail 3092 invoked by uid 22791); 29 Dec 2007 18:16:09 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 29 Dec 2007 18:16:05 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Sat, 29 Dec 2007 18:16:02 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
References: <050e01c84401$be876720$2e08a8c0@CAM.ARTIMI.COM> <20071221234102.GA23118@trixie.casa.cgf.cx> <071a01c84a0d$b1b79d50$2e08a8c0@CAM.ARTIMI.COM> <20071229170412.GA24999@ednor.casa.cgf.cx> <074201c84a3f$64bf8fd0$2e08a8c0@CAM.ARTIMI.COM> <20071229172937.GB24999@ednor.casa.cgf.cx> <074a01c84a44$5459ec30$2e08a8c0@CAM.ARTIMI.COM> <20071229181025.GF24999@ednor.casa.cgf.cx>
Subject: RE: Export fast *rint* functions
Date: Sat, 29 Dec 2007 18:16:00 -0000
Message-ID: <074f01c84a46$deab17e0$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20071229181025.GF24999@ednor.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00072.txt.bz2

On 29 December 2007 18:10, Christopher Faylor wrote:

> Since we're still tinkering with 1.7.x, I think it's ok to check these in
> even if things may change eventually.

  That's my thinking too; glad you agree.
 
> So check this in but you do also have to bump CYGWIN_VERSION_API_MINOR
> and document what you're exporting in include/cygwin/version.h along with
> these changes.

  Ach, right, I'm not au fait with the SOP.  I'll add those changes and
resend.

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
