Return-Path: <cygwin-patches-return-5761-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12673 invoked by alias); 17 Feb 2006 11:18:49 -0000
Received: (qmail 12662 invoked by uid 22791); 17 Feb 2006 11:18:49 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 17 Feb 2006 11:18:48 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id B50FB544001; Fri, 17 Feb 2006 12:18:45 +0100 (CET)
Date: Fri, 17 Feb 2006 11:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add -p option to ps command
Message-ID: <20060217111845.GS26541@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20060216104607.fb30e530d17747c2b054d625b8945d88.ac8efb9ae7.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216104607.fb30e530d17747c2b054d625b8945d88.ac8efb9ae7.wbe@email.secureserver.net>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00070.txt.bz2

On Feb 16 10:46, Jerry D. Hedden wrote:
> > -------- Original Message --------
> > Subject: Re: [PATCH] Add -p option to ps command
> > From: Corinna Vinschen <corinna-cygwin@XXXXXXX.XXX)


Would you please don't copy raw email addresses in your replies?

http://cygwin.com/acronyms/#PCYMTNQREAIYR


> 2006-02-16  Jerry D. Hedden  <jerry@hedden.us>
> 
> 	* ps.cc (main): -p implies -a

I've applied the patch, but your ChangeLog entry is a bit short.
I've changed it to "Set aflag if -p option is given."


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
