Return-Path: <cygwin-patches-return-7361-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23975 invoked by alias); 12 May 2011 21:13:11 -0000
Received: (qmail 23589 invoked by uid 22791); 12 May 2011 21:12:51 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 12 May 2011 21:12:32 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CA7682C0577; Thu, 12 May 2011 23:12:29 +0200 (CEST)
Date: Thu, 12 May 2011 21:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110512211229.GK3020@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de> <20110512121012.GB18135@calimero.vinschen.de> <20110512150910.GE18135@calimero.vinschen.de> <4DCC0B5C.4040901@cs.utoronto.ca> <20110512165520.GB3020@calimero.vinschen.de> <4DCC1E7C.2060804@cs.utoronto.ca> <20110512184233.GE3020@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110512184233.GE3020@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00127.txt.bz2

On May 12 20:42, Corinna Vinschen wrote:
> As for the big blocks, they are apparently identified by the value in
> the "Unknown" member of the DEBUG_HEAP_BLOCK structure.  Here's what I
> figured out so far as far as "Unknown" is concerned:

Scratch that.  I finally *really* figured out what the unknown field
contains.  It's just the number of committed bytes in the block.  So
there's no special identification for subsequent blocks.  They are
simply another start block in the heap block list.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
