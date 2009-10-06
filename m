Return-Path: <cygwin-patches-return-6713-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28922 invoked by alias); 6 Oct 2009 07:46:35 -0000
Received: (qmail 28906 invoked by uid 22791); 6 Oct 2009 07:46:34 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 07:46:31 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id B89086D5598; Tue,  6 Oct 2009 09:46:20 +0200 (CEST)
Date: Tue, 06 Oct 2009 07:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
Message-ID: <20091006074620.GA13712@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACA4323.5080103@cwilson.fastmail.fm> <20091005202722.GG12789@calimero.vinschen.de> <4ACA5BC7.6090908@cwilson.fastmail.fm> <20091006034229.GA12172@ednor.casa.cgf.cx> <4ACAC079.2020105@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACAC079.2020105@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00044.txt.bz2

On Oct  5 23:58, Charles Wilson wrote:
> Christopher Faylor wrote:
> > On Mon, Oct 05, 2009 at 04:49:11PM -0400, Charles Wilson wrote:
> >> hmm...probably
> >>     cygwin_internal (CW_TERMINATE_PROCESS, HANDLE, UINT)
> >>     cygwin_internal (CW_EXIT_PROCESS, UINT)
> >> right?
> > 
> > Do we really have to provide the ability to kill some other process?
> > Maybe we really only need one call with two arguments - one which is the
> > exit value and one which indicates whether to exit with prejudice.
> > 
> > cygwin_internal (CW_EXIT_PROCESS, UINT, bool);
> > 
> > where the bool argument is true if we want to call TerminateProcess on
> > this process.
> 
> Fine with me. The two-function version was just a derivative of my
> earlier "just wrap [Exit|Terminate]Process" approach, trying to mimic
> the w32api.
> 
> However
> 
> by going the cgywin_internal route, there's really no point in slavishly
> following the w32api. And besides, the implementation of
> cygwin_internal(CW_TERMINATE_PROCESS,...) really does nothing special if
> called with a HANDLE to a different process -- you might as well call
> TerminateProcess() itself, in that case.
> 
> I'll wait for other comments, before taking any additional action, tho.

I can live with both variations, though I like the one entry point idea
as in `cygwin_internal (CW_EXIT_PROCESS, UINT, bool)'  more.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
