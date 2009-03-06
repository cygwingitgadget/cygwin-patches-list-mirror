Return-Path: <cygwin-patches-return-6431-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4277 invoked by alias); 6 Mar 2009 15:56:34 -0000
Received: (qmail 4264 invoked by uid 22791); 6 Mar 2009 15:56:33 -0000
X-SWARE-Spam-Status: No, hits=2.1 required=5.0 	tests=AWL,BAYES_50,BOTNET
X-Spam-Check-By: sourceware.org
Received: from vms173003pub.verizon.net (HELO vms173003pub.verizon.net) (206.46.173.3)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 06 Mar 2009 15:56:28 +0000
Received: from PHUMBLETLAPXP ([12.6.244.148]) by vms173003.mailsrvcs.net  (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))  with ESMTPA id <0KG300L5BDLGAI9J@vms173003.mailsrvcs.net> for  cygwin-patches@cygwin.com; Fri, 06 Mar 2009 09:56:10 -0600 (CST)
Message-id: <02d701c99e74$10b71a40$4e0410ac@wirelessworld.airvananet.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
To: <cygwin-patches@cygwin.com>
References: <0KFW0072QPTQUMJ2@vms173001.mailsrvcs.net>  <20090303153801.GA17180@ednor.casa.cgf.cx>  <0b1b01c99c28$8a2c6540$4e0410ac@wirelessworld.airvananet.com>  <20090306054449.GA3971@ednor.casa.cgf.cx>  <029a01c99e69$94a1dbc0$4e0410ac@wirelessworld.airvananet.com>  <20090306144928.GA5418@ednor.casa.cgf.cx>
Subject: Re: [Patch] gethostbyname2  again
Date: Fri, 06 Mar 2009 15:56:00 -0000
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
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00029.txt.bz2


----- Original Message ----- 
From: "Christopher Faylor" <cgf-use-the-mailinglist-please>

| On Fri, Mar 06, 2009 at 09:41:00AM -0500, Pierre A. Humblet wrote:
| >
|| 
| This is ok with one very minor formatting nit.  Please check in with an
| appropriate changelog.
| 
| >+static inline hostent *
| >+realloc_ent (int sz, hostent * )
|                                ^
|                          extra space

OK. I can't do that before Mon eve. It would be easier if Corinna could merge this
patch and the previous one (she has the latest version) and apply the whole thing
at once, with one changelog  block. 

Pierre
