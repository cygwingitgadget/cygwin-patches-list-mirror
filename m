Return-Path: <cygwin-patches-return-5753-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11410 invoked by alias); 15 Feb 2006 10:43:06 -0000
Received: (qmail 11395 invoked by uid 22791); 15 Feb 2006 10:43:05 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 15 Feb 2006 10:43:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 36FFE544001; Wed, 15 Feb 2006 11:43:02 +0100 (CET)
Date: Wed, 15 Feb 2006 10:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
Message-ID: <20060215104302.GA13856@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de> <43D7E666.8080803@t-online.de> <20060126091944.GT8318@calimero.vinschen.de> <20060211103418.GM14219@calimero.vinschen.de> <43F0E145.6080109@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F0E145.6080109@t-online.de>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00062.txt.bz2

On Feb 13 20:43, Christian Franke wrote:
> you wrote:
> >your assignment has finally arrived and is signed.  Do you have a 
> >new version of your regtool patch available, after this discussion
> >took place?
> 
> No, sorry. Hope to find some time in about a week.
> 
> I'm still not sure how to handle binary registry values in a way most 
> useful inside of scripts.

By default, binary data should go as binary data over the pipe.  And
this is all what's needed, in theory, since tools like xxd exist.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
