Return-Path: <cygwin-patches-return-6286-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9957 invoked by alias); 11 Mar 2008 17:09:31 -0000
Received: (qmail 9946 invoked by uid 22791); 11 Mar 2008 17:09:30 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 11 Mar 2008 17:07:19 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JZ7wb-00078q-R5 	for cygwin-patches@cygwin.com; Tue, 11 Mar 2008 17:07:17 +0000
Message-ID: <47D6BC47.75284EB7@dessent.net>
Date: Tue, 11 Mar 2008 17:09:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <47D6A6E1.F8C89DFF@dessent.net> <20080311160116.GH18407@calimero.vinschen.de>
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
X-SW-Source: 2008-q1/txt/msg00060.txt.bz2

Corinna Vinschen wrote:

> Btw., you don't need to make the buffers MAX_PATH + 1.  MAX_PATH is
> defined including the trailing NUL.  Existing code shows a lot of
> irritation about this...

Oh, I wasn't even thinking of that... the reason I used MAX_PATH + 1 was
because earlier I had written

+      static char tmp[SYMLINK_MAX + 1];

so that the following sizes would not need to be SYMLINK_MAX - 1, 

+      if (!readlink (fh, tmp, SYMLINK_MAX))

+	  strncpy (tmp, cygpath (papp, NULL), SYMLINK_MAX);

+	  strncpy (lastsep+1, ptr, SYMLINK_MAX - (lastsep-tmp));


I.e. pure lazyness of wanting to type the least necessary.  But now that
you mention it, it makes more sense to have the "- 1" than the "+ 1"
form, so I'll change that.

Brian
