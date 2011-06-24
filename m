Return-Path: <cygwin-patches-return-7423-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28636 invoked by alias); 24 Jun 2011 07:58:21 -0000
Received: (qmail 28570 invoked by uid 22791); 24 Jun 2011 07:58:02 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 24 Jun 2011 07:57:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 737A42CB3E9; Fri, 24 Jun 2011 09:57:43 +0200 (CEST)
Date: Fri, 24 Jun 2011 07:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Prevent restart of crashing non-Cygwin exe
Message-ID: <20110624075743.GR3437@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E037D68.6090907@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4E037D68.6090907@t-online.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00189.txt.bz2

Hi Christian,

On Jun 23 19:52, Christian Franke wrote:
> If a non-Cygwin .exe started from a Cygwin shell window segfaults,
> Cygwin restarts the .exe 5 times.
> [...l]
> 	* sigproc.cc (child_info::sync): Add exit_code to debug
> 	message.
> 	(child_info::proc_retry): Don't retry on unknown exit_code
> 	from non-cygwin programs.

This looks ok to me, but cgf should have a say here.  He's on vacation
for another week, though.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
