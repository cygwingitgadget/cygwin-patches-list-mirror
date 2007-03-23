Return-Path: <cygwin-patches-return-6048-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27862 invoked by alias); 23 Mar 2007 09:22:07 -0000
Received: (qmail 27831 invoked by uid 22791); 23 Mar 2007 09:22:05 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 23 Mar 2007 09:22:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 4B74C6D42F9; Fri, 23 Mar 2007 10:21:57 +0100 (CET)
Date: Fri, 23 Mar 2007 09:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] w32api: Correct Unicode/Ansi defines for GetMappedFileName
Message-ID: <20070323092157.GA18589@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20070322210856.GV23239@flim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070322210856.GV23239@flim.org>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00029.txt.bz2

Hi Matthew,

On Mar 23 09:08, Matthew Gregan wrote:
> Hi,
> 
> Attached is a small patch to correct the Unicode and Ansi defines that
> expose the appropriate W/A variant of GetMappedFileName.
> 
> 2007-03-23  Matthew Gregan  <kinetik@flim.org>
> 
>        * include/psapi.h (GetMappedFileName): Rename from GetMappedFilenameEx.
> 

Thanks for the patch.  I've applied it.

Btw., the w32api is officially maintained by the MinGW folks, see the
README.w32api file.  Patches to w32api are better off in the appropriate
mingw mailing list.


Thanks again,
Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
