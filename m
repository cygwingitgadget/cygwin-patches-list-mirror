Return-Path: <cygwin-patches-return-5708-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10984 invoked by alias); 12 Jan 2006 11:32:16 -0000
Received: (qmail 10974 invoked by uid 22791); 12 Jan 2006 11:32:16 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 12 Jan 2006 11:32:14 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 7542B544001; Thu, 12 Jan 2006 12:32:10 +0100 (CET)
Date: Thu, 12 Jan 2006 11:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Ignore CVS directories when building documentation
Message-ID: <20060112113210.GA6179@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.63.0601112129230.9317@access1.cims.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.0601112129230.9317@access1.cims.nyu.edu>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00017.txt.bz2

On Jan 11 21:32, Igor Peshansky wrote:
> 	* doctool.c (scan_directory): Ignore "CVS" directories.

Thanks, applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
