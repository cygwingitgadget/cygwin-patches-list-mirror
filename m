Return-Path: <cygwin-patches-return-6323-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13524 invoked by alias); 22 Mar 2008 22:33:06 -0000
Received: (qmail 13512 invoked by uid 22791); 22 Mar 2008 22:33:06 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-32.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.32)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 22 Mar 2008 22:32:42 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 18AD755147; Sat, 22 Mar 2008 18:32:41 -0400 (EDT)
Date: Sat, 22 Mar 2008 22:33:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] QueryDosDevice in handle_to_fn
Message-ID: <20080322223241.GA22747@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47DCF310.2E2CA04A@dessent.net> <20080316152213.GD29148@calimero.vinschen.de> <20080316153607.GB27448@ednor.casa.cgf.cx> <20080322210528.GA22407@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080322210528.GA22407@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00097.txt.bz2

On Sat, Mar 22, 2008 at 05:05:28PM -0400, Christopher Faylor wrote:
>On Sun, Mar 16, 2008 at 11:36:07AM -0400, Christopher Faylor wrote:
>>This is basically my function.  I'll try to convert it to use Unicode
>>today.
>
>I've checked in changes which move handle_to_fn closer to being totally
>32-bit aware and fixed one pipe and one tty problem in the process.

Sorry.  I meant "unicode" not 32-bit.

cgf
