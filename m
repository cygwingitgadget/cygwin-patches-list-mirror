Return-Path: <cygwin-patches-return-5915-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28019 invoked by alias); 6 Jul 2006 11:30:20 -0000
Received: (qmail 28004 invoked by uid 22791); 6 Jul 2006 11:30:18 -0000
X-Spam-Check-By: sourceware.org
Received: from bay0-omc1-s26.bay0.hotmail.com (HELO bay0-omc1-s26.bay0.hotmail.com) (65.54.246.98)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Jul 2006 11:30:11 +0000
Received: from hotmail.com ([64.4.38.40]) by bay0-omc1-s26.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Thu, 6 Jul 2006 04:30:07 -0700
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC; 	 Thu, 6 Jul 2006 04:30:07 -0700
Message-ID: <BAY116-F30A7FAD6F54EE89A15115591770@phx.gbl>
Received: from 64.4.38.200 by by116fd.bay116.hotmail.msn.com with HTTP; 	Thu, 06 Jul 2006 11:30:03 GMT
X-Sender: esor_ekim@hotmail.com
From: "Mike Rose" <esor_ekim@hotmail.com>
To: cygwin-patches@cygwin.com
Bcc:
Subject: Command line argument to setup.exe for a package list to install
Date: Thu, 06 Jul 2006 11:30:00 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00010.txt.bz2

Hi,

We like cygwin for remotely managing windows computers using ssh. Therefore 
we like a command line install of cygwin sshd:
http://www.tcm.phy.cam.ac.uk/~mr349/cygwin_install.html

Here's the patch that my colleague did:
http://www.tcm.phy.cam.ac.uk/~mr349/cygwin.patch
It is definitely not the best code, but it works and meets our needs and 
maybe will be helpful to the cygwin project.

regards,

Mike.

