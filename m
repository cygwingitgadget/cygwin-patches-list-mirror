Return-Path: <cygwin-patches-return-6149-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19747 invoked by alias); 3 Nov 2007 17:44:32 -0000
Received: (qmail 19736 invoked by uid 22791); 3 Nov 2007 17:44:32 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 03 Nov 2007 17:44:28 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1IoN2o-0003Us-Oy 	for cygwin-patches@cygwin.com; Sat, 03 Nov 2007 17:44:26 +0000
Message-ID: <472CB37A.407FAE34@dessent.net>
Date: Sat, 03 Nov 2007 17:44:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Rewrite/fix cygwin1.dbg generation
References: <472CB021.5040806@portugalmail.pt>
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
X-SW-Source: 2007-q4/txt/msg00001.txt.bz2

Pedro Alves wrote:

> The dllfixdbg hunk looks hard to read.  Here's what is looks
> like after patching:

I think that if whatever bugs used to exist in older binutils PE support
that necessitated this hackery are now gone, we can just do away with
dllfixdbg alltogether and just put this:

> ${STRIP} --strip-debug ${DLL} -o stripped-${DLL}
> ${STRIP} --only-keep-debug ${DLL} -o ${DBG}
> ${OBJCOPY} --add-gnu-debuglink=${DBG} stripped-${DLL} ${DLL}
> rm -f stripped-${DLL}

...in the Makefile.

Brian
