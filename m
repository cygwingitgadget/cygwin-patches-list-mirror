Return-Path: <cygwin-patches-return-5580-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9224 invoked by alias); 21 Jul 2005 15:34:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9209 invoked by uid 22791); 21 Jul 2005 15:34:00 -0000
Received: from service.sh.cvut.cz (HELO service.sh.cvut.cz) (147.32.127.214)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Thu, 21 Jul 2005 15:34:00 +0000
Received: from localhost (localhost [127.0.0.1])
	by service.sh.cvut.cz (Postfix) with ESMTP id 956411A3312
	for <cygwin-patches@cygwin.com>; Thu, 21 Jul 2005 17:33:51 +0200 (CEST)
Received: from service.sh.cvut.cz ([127.0.0.1])
	by localhost (service [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22807-04 for <cygwin-patches@cygwin.com>;
	Thu, 21 Jul 2005 17:33:50 +0200 (CEST)
Received: from logout.sh.cvut.cz (logout.sh.cvut.cz [147.32.127.203])
	by service.sh.cvut.cz (Postfix) with ESMTP id EA3C11A3359
	for <cygwin-patches@cygwin.com>; Thu, 21 Jul 2005 17:33:50 +0200 (CEST)
Received: from logout (logout [147.32.127.203])
	by logout.sh.cvut.cz (Postfix) with ESMTP id ADF923C306
	for <cygwin-patches@cygwin.com>; Thu, 21 Jul 2005 17:33:52 +0200 (CEST)
Date: Thu, 21 Jul 2005 15:34:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Use of %E in system_printf().
Message-ID: <20050721172727.E38147@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q3/txt/msg00035.txt.bz2


I've been looking around Cygwin again and found this:

system_printf ("couldn't get memory info, %E");

Now I am curious where does the %E get handled? Is it supposed to print
GetLastError()? I looked into strace.h and strace.cc but I don't see anything
that would handle it. Besides that, %E is afaik also format for printing
doubles.


VH
