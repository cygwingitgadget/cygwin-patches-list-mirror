Return-Path: <cygwin-patches-return-6379-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6790 invoked by alias); 8 Dec 2008 23:04:26 -0000
Received: (qmail 6772 invoked by uid 22791); 8 Dec 2008 23:04:25 -0000
X-Spam-Check-By: sourceware.org
Received: from vms042pub.verizon.net (HELO vms042pub.verizon.net) (206.46.252.42)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 08 Dec 2008 23:03:46 +0000
Received: from PHUMBLETLAPXP ([12.6.244.148])  by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006)) with ESMTPA id <0KBK00C9XYPOPE70@vms042.mailsrvcs.net> for  cygwin-patches@cygwin.com; Mon, 08 Dec 2008 17:03:24 -0600 (CST)
Date: Mon, 08 Dec 2008 23:04:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: <resolv.h> requires <netinet/in.h>
To: "Yaakov \(Cygwin/X\)" <yselkowitz@users.sourceforge.net>, 	<cygwin-patches@cygwin.com>
Message-id: <024501c95989$2c07cc70$940410ac@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
References: <493DA370.30006@users.sourceforge.net>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00023.txt.bz2


----- Original Message ----- 
From: "Yaakov (Cygwin/X)" 
To: <cygwin-patches>
Sent: Monday, December 08, 2008 5:45 PM
Subject: <resolv.h> requires <netinet/in.h>


| -----BEGIN PGP SIGNED MESSAGE-----
| Hash: SHA256
| 
| This affects both minires-1.02 and Cygwin 1.7.0-34.  STC based on a
| configure test:

**************

This is far from the 1st time that this issue comes up.
resolv.h is completely standard, it comes from a bind distribution.

Every version of man resolver that I have ever seen specifies:

SYNOPSIS 
     #include <sys/types.h>
     #include <netinet/in.h>
     #include <arpa/nameser.h>
     #include <resolv.h>

So it's up to the user to include the right files.
Sure we can make an exception for Cygwin, but the same program can then fail elsewhere.

Pierre
