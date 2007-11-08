Return-Path: <cygwin-patches-return-6162-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23184 invoked by alias); 8 Nov 2007 12:07:14 -0000
Received: (qmail 22897 invoked by uid 22791); 8 Nov 2007 12:07:12 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 08 Nov 2007 12:07:08 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 82B7D6D4805; Thu,  8 Nov 2007 13:07:05 +0100 (CET)
Date: Thu, 08 Nov 2007 12:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Rewrite/fix cygwin1.dbg generation
Message-ID: <20071108120705.GA9237@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <472CB021.5040806@portugalmail.pt> <472CB37A.407FAE34@dessent.net> <20071104022028.GA6236@ednor.casa.cgf.cx> <472D43F5.4090700@portugalmail.pt> <472D7956.28174D88@dessent.net> <20071104175738.GA21828@ednor.casa.cgf.cx> <4732526F.4080501@portugalmail.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4732526F.4080501@portugalmail.pt>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00014.txt.bz2

On Nov  8 00:03, Pedro Alves wrote:
> Christopher Faylor wrote:
>
>> That would be fine with me.  OTOH, if the dllfixdbg isn't doing the
>> right thing for gdb couldn't it be adapted to include the required
>> sections?
>
> Yep.  Here is a patch that does that.
>
> Testsuite shows no changes, I could build cygwin in cygwin with
> this, and gdb doesn't complain anymore.
>
> Also tested that the cygheap can grow as much as the previous
> version.
>[...]
> 2007-11-07  Pedro Alves  <pedro_alves@portugalmail.pt>
> 
> 	* dllfixdbg: Pass --only-keep-debug to objcopy, instead of
> 	selecting the sections manually.

I applied the patch.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
