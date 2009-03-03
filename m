Return-Path: <cygwin-patches-return-6423-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24034 invoked by alias); 3 Mar 2009 15:05:37 -0000
Received: (qmail 24024 invoked by uid 22791); 3 Mar 2009 15:05:36 -0000
X-SWARE-Spam-Status: Yes, hits=5.4 required=5.0 	tests=AWL,BARRACUDA_BRBL,BAYES_50,BOTNET
X-Spam-Check-By: sourceware.org
Received: from vms173011pub.verizon.net (HELO vms173011pub.verizon.net) (206.46.173.11)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 03 Mar 2009 15:05:28 +0000
Received: from PHUMBLETLAPXP ([70.88.219.194]) by vms173011.mailsrvcs.net  (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))  with ESMTPA id <0KFX00CXKR8SZTCF@vms173011.mailsrvcs.net> for  cygwin-patches@cygwin.com; Tue, 03 Mar 2009 09:05:21 -0600 (CST)
Message-id: <0acf01c99c11$790c34f0$4e0410ac@wirelessworld.airvananet.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
To: <cygwin-patches@cygwin.com>
References: <0KFW0072QPTQUMJ2@vms173001.mailsrvcs.net>  <20090303120134.GR10046@calimero.vinschen.de>
Subject: Re: [Patch] gethostbyname2  again
Date: Tue, 03 Mar 2009 15:05:00 -0000
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00021.txt.bz2


----- Original Message ----- 
From: "Corinna Vinschen" 
To: <cygwin-patches>
Sent: Tuesday, March 03, 2009 7:01 AM
Subject: Re: [Patch] gethostbyname2 again


| [| 
| I attached the entire patch again with my changes.  I had to change the
| gethostby_helper function to define some of the variables at the start
| of the function, othewise gcc complained about jumps to a label crossing
| variable initializations.  The bump of the API minor number in
| include/cygwin/version.h was missing.  I also tweaked the formatting a bit.
| 
| The ChangeLog entry is the same as in the OP, except for the additional
| reference to include/cygwin/version.h.  Please have a look.
| 

Hello Corinna,

Thanks for fixing up the nits. The new patch looks good. I didn't find the new
Changelog entry but I trust you.

Pierre
 
