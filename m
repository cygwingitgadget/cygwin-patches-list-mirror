Return-Path: <cygwin-patches-return-5845-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21143 invoked by alias); 4 May 2006 20:47:32 -0000
Received: (qmail 21131 invoked by uid 22791); 4 May 2006 20:47:32 -0000
X-Spam-Check-By: sourceware.org
Received: from palrel11.hp.com (HELO palrel11.hp.com) (156.153.255.246)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 04 May 2006 20:47:26 +0000
Received: from smtp2.ptp.hp.com (smtp2.ptp.hp.com [15.1.28.240]) 	by palrel11.hp.com (Postfix) with ESMTP id 83C283875A 	for <cygwin-patches@cygwin.com>; Thu,  4 May 2006 13:47:25 -0700 (PDT)
Received: from hpsje.cup.hp.com (hpsje.cup.hp.com [16.89.92.85]) 	by smtp2.ptp.hp.com (Postfix) with ESMTP id 6668E24EA0E 	for <cygwin-patches@cygwin.com>; Thu,  4 May 2006 20:47:25 +0000 (UTC)
Received: (from sje@localhost) by hpsje.cup.hp.com (8.9.3 (PHNE_24419+JAGae58098)/8.7.3 TIS Messaging 5.0) id NAA19831 for cygwin-patches@cygwin.com; Thu, 4 May 2006 13:47:25 -0700 (PDT)
Date: Thu, 04 May 2006 20:47:00 -0000
From: Steve Ellcey <sje@cup.hp.com>
Message-Id: <200605042047.NAA19831@hpsje.cup.hp.com>
To: cygwin-patches@cygwin.com
Subject: Using newer autoconf in src/winsup directory
Reply-To: sje@cup.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00033.txt.bz2


I have been working to move the src tree at soureware.org to a newer
version of autoconf.  The reason for this is so that we can, in turn,
move to a newer version of libtool.  Would it be possible to rebuild the
configure scripts in src/winsup with a recent version of autoconf, like
autoconf 2.59?  Most parts of the src tree have already moved to this
version.

Steve Ellcey
sje@cup.hp.com
