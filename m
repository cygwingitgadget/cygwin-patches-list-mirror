Return-Path: <cygwin-patches-return-5755-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30927 invoked by alias); 16 Feb 2006 11:17:27 -0000
Received: (qmail 30917 invoked by uid 22791); 16 Feb 2006 11:17:27 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 16 Feb 2006 11:17:25 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 8447A544001; Thu, 16 Feb 2006 12:17:22 +0100 (CET)
Date: Thu, 16 Feb 2006 11:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add -p option to ps command
Message-ID: <20060216111722.GK26541@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20060214071213.fb30e530d17747c2b054d625b8945d88.fc30277bd8.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214071213.fb30e530d17747c2b054d625b8945d88.fc30277bd8.wbe@email.secureserver.net>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00064.txt.bz2

On Feb 14 07:12, Jerry D. Hedden wrote:
> Attached is a patch to add a -p option to the ps command to show
> information for only a single PID:  ps -p PID
> This option is available on other implementations of ps (e.g., Solaris).

Thanks for the patch.  It's barely short enough so that we decided to
put it in despite the fact that you have no copyright assignment
in place.  Please read http://cygwin.com/contrib.html for further
information about how to contribute.  Note especially the fact that
we need your copyright assignment for any substantial patch.

I applied your patch with some minor changes.  I fixed the wrongly set
curly braces at one point, I added the descriptive text to utils.sgml
(cygwin-ug-net.sgml is only a generated file) and, most important, I
added a ChangeLog entry.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
