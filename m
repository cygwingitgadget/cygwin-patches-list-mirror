Return-Path: <cygwin-patches-return-6309-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20144 invoked by alias); 19 Mar 2008 00:35:29 -0000
Received: (qmail 20132 invoked by uid 22791); 19 Mar 2008 00:35:28 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 19 Mar 2008 00:35:11 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JbmGr-0001ik-SS 	for cygwin-patches@cygwin.com; Wed, 19 Mar 2008 00:35:10 +0000
Message-ID: <47E05FBE.B57EF4A2@dessent.net>
Date: Wed, 19 Mar 2008 00:35:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] better stackdumps
References: <47E05D34.FCC2E30A@dessent.net>
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
X-SW-Source: 2008-q1/txt/msg00083.txt.bz2

Brian Dessent wrote:

> Of course the labeling works for any module/dll, not just cygwin1.dll,
> but I didn't have a more elaborate testcase to demonstrate.

Forgot to mention... 

The symbols are just tacked on on the right hand side there for now.  I
wasn't really sure how to handle that.  I didn't want to remove display
of the actual EIP for each frame as that could be removing useful info,
but I wasn't quite sure where to put everything or how to align it... so
as it is now it wraps wider than 80 chars which is probably pretty ugly
on a default size terminal.

Brian
