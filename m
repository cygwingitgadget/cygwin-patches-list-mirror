Return-Path: <cygwin-patches-return-5406-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4194 invoked by alias); 6 Apr 2005 08:36:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3676 invoked from network); 6 Apr 2005 08:36:33 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 6 Apr 2005 08:36:33 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DJ5xi-0008Kc-Mo
	for cygwin-patches@cygwin.com; Wed, 06 Apr 2005 08:32:35 +0000
Message-ID: <4253A07B.A527DE74@dessent.net>
Date: Wed, 06 Apr 2005 08:36:00 -0000
From: Brian Dessent <brian@dessent.net>
Organization: My own little world...
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] dup_ent does not set dst when src is NULL
References: <4253768A.8711D94@dessent.net> <20050406055116.GA10047@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q2/txt/msg00002.txt.bz2

Christopher Faylor wrote:

> Thanks for the patch, but I went out of my way to avoid freeing the
> buffer when I maded changes to dup_ent a couple of weeks ago.  I don't
> want to revert to doing that again, so I've just used the return value
> in all cases.

Thanks for taking care of that.  My original fix did more or less what
you have done, by checking the return value, but I submitted the other
way because it was much shorter and I didn't want to send anything
non-trivial.  Hmm, maybe if my printer had some ink in it I could print
out that copyright assignment form...

Brian
