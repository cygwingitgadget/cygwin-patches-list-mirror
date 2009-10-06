Return-Path: <cygwin-patches-return-6719-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 688 invoked by alias); 6 Oct 2009 16:23:26 -0000
Received: (qmail 677 invoked by uid 22791); 6 Oct 2009 16:23:25 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 16:23:22 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 89BB86D5598; Tue,  6 Oct 2009 18:23:11 +0200 (CEST)
Date: Tue, 06 Oct 2009 16:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
Message-ID: <20091006162311.GU12789@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACA4323.5080103@cwilson.fastmail.fm> <20091005202722.GG12789@calimero.vinschen.de> <4ACA5BC7.6090908@cwilson.fastmail.fm> <20091006034229.GA12172@ednor.casa.cgf.cx> <4ACAC079.2020105@cwilson.fastmail.fm> <20091006074620.GA13712@calimero.vinschen.de> <4ACB56D5.4060606@cwilson.fastmail.fm> <20091006154519.GA24301@calimero.vinschen.de> <4ACB6D0A.1060307@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACB6D0A.1060307@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00050.txt.bz2

On Oct  6 12:15, Charles Wilson wrote:
> Corinna Vinschen wrote:
> > Looks good to me.  Let's wait for Chris, though.  I have just one question.
> 
> OK.
> 
> > Shouldn't exit_process be marked with attribute(noreturn) or is the
> > optimizing effect negligible?
> 
> It is already marked noreturn, in the declaration at the top of the
> file.

Sorry, I missed that.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
