Return-Path: <cygwin-patches-return-5690-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25270 invoked by alias); 20 Dec 2005 09:12:31 -0000
Received: (qmail 25259 invoked by uid 22791); 20 Dec 2005 09:12:30 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 20 Dec 2005 09:12:29 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id E1548544005; Tue, 20 Dec 2005 10:12:26 +0100 (CET)
Date: Tue, 20 Dec 2005 09:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix /lib=/usr/lib alias in "cygcheck -f"
Message-ID: <20051220091226.GK2965@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.63.0512191131550.9894@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.0512191131550.9894@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2005-q4/txt/msg00032.txt.bz2

On Dec 19 11:34, Igor Pechtchanski wrote:
> Hi,
> 
> Due to a missing trailing "/", "cygcheck -f" did not recognize "/lib" as
> being the same as "/usr/lib".  The attached patch fixes this.  ChangeLog
> below.
> 	Igor
> ==============================================================================
> 2005-12-19  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
> 
> 	* dump_setup.cc (package_find): Fix is_alias computation for
> 	"/usr/lib".

Applied, thanks.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
