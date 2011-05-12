Return-Path: <cygwin-patches-return-7351-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24704 invoked by alias); 12 May 2011 16:57:54 -0000
Received: (qmail 24609 invoked by uid 22791); 12 May 2011 16:57:35 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 12 May 2011 16:57:21 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 340162C0577; Thu, 12 May 2011 18:57:19 +0200 (CEST)
Date: Thu, 12 May 2011 16:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110512165719.GC3020@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de> <4DCC0CBB.1030803@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DCC0CBB.1030803@cs.utoronto.ca>
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
X-SW-Source: 2011-q2/txt/msg00117.txt.bz2

On May 12 12:37, Ryan Johnson wrote:
> On 11/05/2011 3:31 PM, Corinna Vinschen wrote:
> >On May 11 13:46, Ryan Johnson wrote:
> >>Also, the cygheap isn't a normal windows heap, is it? I thought it
> >>was essentially a statically-allocated array (.cygheap) that gets
> >>managed as a heap. I guess since it's part of cygwin1.dll we already
> >>do sort of report it...
> >The cygheap is the last section in the DLL and gets allocated by the
> >Windows loader.  The memory management is entirely in Cygwin (cygheap.cc).
> >Cygwin can raise the size of the cygheap, but only if the blocks right
> >after the existing cygheap are not already allocated.
> Would it make sense to give that section, and the one(s) which
> immediately follow it, the tag "[cygheap]" rather than
> "/usr/bin/cygwin1.dll" and nothing? It would require struct pefile
> to identify the section, plus some trickery in format_process_maps
> to treat the cygwin dll and adjacent succeeding allocation(s)
> specially.

I wouldn't do that.  Just because there's a allocated block right
after the cygheap doesn't mean it's part of the cygheap.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
