Return-Path: <cygwin-patches-return-6275-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12116 invoked by alias); 9 Mar 2008 18:03:40 -0000
Received: (qmail 12106 invoked by uid 22791); 9 Mar 2008 18:03:39 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 09 Mar 2008 18:03:22 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JYPrl-0005QT-3Y 	for cygwin-patches@cygwin.com; Sun, 09 Mar 2008 18:03:21 +0000
Message-ID: <47D4266A.CE301EDE@dessent.net>
Date: Sun, 09 Mar 2008 18:03:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <20080309143819.GB8192@ednor.casa.cgf.cx> <20080309151440.GB18407@calimero.vinschen.de> <20080309162800.GB13754@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00049.txt.bz2

Christopher Faylor wrote:

> I guess I misunderstood.  I thought that the current working directory
> could be derived through some complicated combination of Nt*() calls.

I could be wrong here but the way I understood it, there is no concept
of a working directory at the NT level, that is something that is
maintained by the Win32 layer.

My question is, what does GetCurrentDirectoryW() return if the current
directory is greater than the 260 limit?  Does it choke or does it
switch to the \.\c:\foo syntax?

Brian
