Return-Path: <cygwin-patches-return-6050-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3897 invoked by alias); 23 Mar 2007 12:44:20 -0000
Received: (qmail 3880 invoked by uid 22791); 23 Mar 2007 12:44:18 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 23 Mar 2007 12:44:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id CAD936D42F9; Fri, 23 Mar 2007 13:44:02 +0100 (CET)
Date: Fri, 23 Mar 2007 12:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] w32api: Correct Unicode/Ansi defines for GetMappedFileName
Message-ID: <20070323124402.GY4786@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20070322210856.GV23239@flim.org> <20070323092157.GA18589@calimero.vinschen.de> <20070323122717.GA2148@flim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070323122717.GA2148@flim.org>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00031.txt.bz2

On Mar 24 00:27, Matthew Gregan wrote:
> At 2007-03-23T10:21:57+0100, Corinna Vinschen wrote:
> > Thanks for the patch.  I've applied it.
> 
> Well, not quite.  The changes you've applied still have the incorrect case
> for GetMappedFileName (note the capital N).  My original patch was correct.

Oops, sorry.  I fixed that now (hopefully).


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
