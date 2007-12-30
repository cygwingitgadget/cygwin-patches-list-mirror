Return-Path: <cygwin-patches-return-6225-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11004 invoked by alias); 30 Dec 2007 21:29:49 -0000
Received: (qmail 10994 invoked by uid 22791); 30 Dec 2007 21:29:49 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 30 Dec 2007 21:29:37 +0000
Received: from rainbow ([192.168.8.46] RDNS failed) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Sun, 30 Dec 2007 21:29:35 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
References: <050e01c84401$be876720$2e08a8c0@CAM.ARTIMI.COM> <20071221234102.GA23118@trixie.casa.cgf.cx> <071a01c84a0d$b1b79d50$2e08a8c0@CAM.ARTIMI.COM> <20071229170412.GA24999@ednor.casa.cgf.cx> <074201c84a3f$64bf8fd0$2e08a8c0@CAM.ARTIMI.COM> <20071229172937.GB24999@ednor.casa.cgf.cx> <074a01c84a44$5459ec30$2e08a8c0@CAM.ARTIMI.COM> <20071229181025.GF24999@ednor.casa.cgf.cx> <074f01c84a46$deab17e0$2e08a8c0@CAM.ARTIMI.COM> <07ba01c84b20$337a0310$2e08a8c0@CAM.ARTIMI.COM> <20071230201717.GB2942@ednor.casa.cgf.cx>
Subject: RE: Export fast *rint* functions
Date: Sun, 30 Dec 2007 21:29:00 -0000
Message-ID: <07c101c84b2b$12c20040$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20071230201717.GB2942@ednor.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00077.txt.bz2

On 30 December 2007 20:17, Christopher Faylor wrote:

> Looks good.  Please check in.
 
  Done, ta.  Next thing I plan on doing is to add fenv.h and the related
functions in newlib, starting with rounding modes and precision control.

[  I'm not working to any strict plan here, but the mplayer-vs-llrintf thing
made me look at the math library code closely, and I think we can replace the
slow soft float stuff from newlib with x87 fpu insns, which would be nice, and
user control over the fpu precision is required for one of the mitigating
workarounds for GCC PR323, which might be helpful as we have a number of
people who like using cygwin + g77 to do heavy-duty academic number crunching,
so I'm going to try and tidy up a few of these bits and pieces and hopefully
we'll get some modest performance improvements in application performance as
well as adding missing functionality.  ]

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
