Return-Path: <cygwin-patches-return-6696-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16522 invoked by alias); 5 Oct 2009 15:16:40 -0000
Received: (qmail 16507 invoked by uid 22791); 5 Oct 2009 15:16:38 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 15:16:35 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 5AE386D55B9; Mon,  5 Oct 2009 17:16:24 +0200 (CEST)
Date: Mon, 05 Oct 2009 15:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] --std=c89 error in sys/signal.h
Message-ID: <20091005151624.GA3452@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC2732D.5090304@users.sourceforge.net> <20090929223320.GA8901@ednor.casa.cgf.cx> <4AC2A7B5.3070105@users.sourceforge.net> <4AC2B02E.7010805@users.sourceforge.net> <4AC94F6F.60308@users.sourceforge.net> <20091005083759.GA12170@calimero.vinschen.de> <4ACA0043.6070504@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACA0043.6070504@users.sourceforge.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00027.txt.bz2

On Oct  5 09:18, Yaakov S wrote:
> On 05/10/2009 03:37, Corinna Vinschen wrote:
>> Newlib, methinks.
>
> OK, I'll send a patch there.
>
>> I think the newlib kill declaration should be changed to pid_t, since
>> that's simply correct per POSIX.
>>
>> I can;t believe the RTEMS people have a problem with that.
>
> Did you forget about the ESTRPIPE episode already?

Actually, yes.  However, in this case you're fixing the header to be
more standards-compliant.  Anyway, good luck ;)


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
