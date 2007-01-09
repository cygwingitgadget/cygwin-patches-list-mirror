Return-Path: <cygwin-patches-return-6031-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18832 invoked by alias); 9 Jan 2007 12:20:21 -0000
Received: (qmail 18821 invoked by uid 22791); 9 Jan 2007 12:20:20 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 09 Jan 2007 12:20:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 7E8D76D42F9; Tue,  9 Jan 2007 13:20:12 +0100 (CET)
Date: Tue, 09 Jan 2007 12:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygpath -O and -F options (was: Two short scripts for Cygwin-Windows  interoperation)
Message-ID: <20070109122012.GA29493@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20070104T172439-137@post.gmane.org> <Pine.GSO.4.63.0701041220120.15041@access1.cims.nyu.edu> <459D5852.8010407@t-online.de> <Pine.GSO.4.63.0701041641350.15041@access1.cims.nyu.edu> <459D822A.103@t-online.de> <20070105093149.GA28768@calimero.vinschen.de> <45A15636.9000109@t-online.de> <20070108094743.GA22258@calimero.vinschen.de> <45A28E57.1040301@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A28E57.1040301@t-online.de>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00012.txt.bz2

On Jan  8 19:32, Christian Franke wrote:

Applied.  However, may I ask you to do the patch against current CVS
instead of the release the next time?

It would also be nice if you could create the ChangeLog entry so that
it's just a copy/paste job:

> 2007-01-07    Christian Franke <franke@computer.org>
            ^^                  ^^
            Two spaces here     and two spaces here
> 
>   * cygpath.cc (usage): Add -O and -F, remove tabs.
>   (get_special_folder): New function.
>   (get_user_folder): New function.
>   (dowin): Add -O and -F, better -D, -P error handling.
>   (main): Add -O and -F.
>   * utils.sgml (cygpath): Document -O and -F.
 ^^^
 One TAB here.


Thanks,
Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
