Return-Path: <cygwin-patches-return-5560-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5512 invoked by alias); 6 Jul 2005 14:50:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5442 invoked by uid 22791); 6 Jul 2005 14:50:10 -0000
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 06 Jul 2005 14:50:10 +0000
Received: from mace ([192.168.1.25]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 6 Jul 2005 15:50:08 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: cygcheck exit status
Date: Wed, 06 Jul 2005 14:50:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
In-Reply-To:  <loom.20050706T160843-889@post.gmane.org>
Message-ID: <SERRANOZIHd0TlKn4ZH000003eb@SERRANO.CAM.ARTIMI.COM>
X-SW-Source: 2005-q3/txt/msg00015.txt.bz2

----Original Message----
>From: Eric Blake
>Sent: 06 July 2005 15:19


> 
> But I hate thinking in negative logic, hence my definition of cygcheck to
> return true on success.]

  Mneh.  I don't like boolean success-fail return values full stop.  They
convey too little information and then need to be supplanted with hideous
kludges such as global variables called errno or subsidiary function calls
called GetLastError.  The standard POSIX design of returning zero for
success or a non-zero error code for failure is now something that's so much
second nature I don't even think of it as negative logic.

  However this should not be taken as any opposition to your proposed patch!


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
