Return-Path: <cygwin-patches-return-5607-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1764 invoked by alias); 5 Aug 2005 14:17:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1755 invoked by uid 22791); 5 Aug 2005 14:17:04 -0000
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 05 Aug 2005 14:17:04 +0000
Received: from mace ([192.168.1.25]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 5 Aug 2005 15:17:20 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: fhandler_tty_slave::tcflush() in fhandler_tty.cc
Date: Fri, 05 Aug 2005 14:17:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <000e01c599bd$c0c19d30$0a7b2093@amber2>
Message-ID: <SERRANONFxvdmNs8iVE000000c4@SERRANO.CAM.ARTIMI.COM>
X-SW-Source: 2005-q3/txt/msg00062.txt.bz2

----Original Message----
>From: Vaclav Haisman
>Sent: 05 August 2005 14:01

> fhandler_tty_slave::tcflush() is IMHO still wrong. The result of
> comparison is bool and bool converted to int is either 1 or 0. The
> following patch should cure it.

  Just to enlarge upon that, the problem is not just that it's returning a
zero-or-one when it should be returning a zero-or-minus-one result, but that
the logical sense is inverted too: when flushing input, the test means that
it used to return zero for failure and non-zero for success.  Your patch
looks good to me.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
