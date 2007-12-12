Return-Path: <cygwin-patches-return-6190-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25742 invoked by alias); 12 Dec 2007 18:57:34 -0000
Received: (qmail 25732 invoked by uid 22791); 12 Dec 2007 18:57:33 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 12 Dec 2007 18:57:19 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 927F76D4811; Wed, 12 Dec 2007 19:57:15 +0100 (CET)
Date: Wed, 12 Dec 2007 18:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] poll() return value is actually that of select()
Message-ID: <20071212185714.GD6618@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <55c2fd8a0712120959q7d8cec61vb37a24c569cfb0c2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c2fd8a0712120959q7d8cec61vb37a24c569cfb0c2@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00042.txt.bz2

On Dec 12 12:59, Craig MacGregor wrote:
> Attached is some goo which makes poll() work as expected.... compiled,
> tested, works... fyi, as of 9:30am EST string.h broke the build, i had
> to roll it back.

Works for me.  How does it break the build for you?  Patch?

> 2007-12-12  Craig MacGregor  <cmacgreg@gmail.com>
> 
> 	* poll.cc (poll): Return count of fds with events instead of total event count

Thanks for the patch.  It looks good to me, but I'll slightly reformat
it.  I'll rather have the `ir = 1' expressions standalone on a single
line and curly brackets.  I'll apply it tomorrow.

However, this patch is already almost beyond the upper bound (in terms
of patch size) which we can incorporate without having a signed
copyright assignment from you, see http://cygwin.com/contrib.html,
section "Before you get started".  I don't want to keep you from
providing more and bigger patches, of course, but we all had to go
through this legal stuff :}


Thanks again for the patch,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
