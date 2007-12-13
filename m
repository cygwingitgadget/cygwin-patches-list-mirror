Return-Path: <cygwin-patches-return-6194-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4009 invoked by alias); 13 Dec 2007 10:59:43 -0000
Received: (qmail 3998 invoked by uid 22791); 13 Dec 2007 10:59:42 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 13 Dec 2007 10:59:37 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id CAEA06D426E; Thu, 13 Dec 2007 11:59:33 +0100 (CET)
Date: Thu, 13 Dec 2007 10:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] poll() return value is actually that of select()
Message-ID: <20071213105933.GC32462@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <55c2fd8a0712120959q7d8cec61vb37a24c569cfb0c2@mail.gmail.com> <20071212185714.GD6618@calimero.vinschen.de> <A6F1FD53-63C9-4137-A491-3A3E0475542D@zooko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A6F1FD53-63C9-4137-A491-3A3E0475542D@zooko.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00046.txt.bz2

On Dec 12 16:06, zooko wrote:
> By the way, there is currently a patch pending in Python to work-around 
> this bug in cygwin poll [1].
>
> If you guys are accepting this patch to fix cygwin poll then I'll let the 
> python developers know that.

As soon as Craig made a sanity check of my solution, I'll apply the
patch to 1.5.25 as well.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
