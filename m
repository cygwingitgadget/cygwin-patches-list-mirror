Return-Path: <cygwin-patches-return-5208-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12248 invoked by alias); 16 Dec 2004 13:21:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12179 invoked from network); 16 Dec 2004 13:20:54 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.119.93)
  by sourceware.org with SMTP; 16 Dec 2004 13:20:54 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 64E5E5808D; Thu, 16 Dec 2004 14:23:02 +0100 (CET)
Date: Thu, 16 Dec 2004 13:21:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] bug # 514 (cygwin console handling) - update
Message-ID: <20041216132302.GA13898@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <E1CeJAV-0007GT-00@mrelayng.kundenserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CeJAV-0007GT-00@mrelayng.kundenserver.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00209.txt.bz2

On Dec 14 06:02, Thomas Wolff wrote:
> This is an update of my "trivial patch" that fixes
>  http://sourceware.org/bugzilla/show_bug.cgi?id=514
> 
> > I guess the patch is pretty much ok and I'm inclined to let it pass
> > under the trivial patch rule... iff you change it so that the #ifdef
> > goes away.  Which alternative seems more appropriate resp. which one
> > results in the more readable output?  It's the one we should choose
> > (since any choice will result in complains anyway).
> OK, I kept the alternative that was selected by #ifdef before. 
> It's the more consistent one anyway.
> 
> > And please shorten the ChangeLog entry to about one sentence.
> OK.

Well done, just the layout of the ChangeLog needed some reworking
(the whole entry should be tabbified).


Thanks for the patch,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
