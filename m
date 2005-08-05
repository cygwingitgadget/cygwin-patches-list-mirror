Return-Path: <cygwin-patches-return-5608-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4718 invoked by alias); 5 Aug 2005 16:12:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3892 invoked by uid 22791); 5 Aug 2005 16:11:40 -0000
Received: from pd95b12ea.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (217.91.18.234)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 05 Aug 2005 16:11:40 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 88C03544123; Fri,  5 Aug 2005 18:11:37 +0200 (CEST)
Date: Fri, 05 Aug 2005 16:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_tty_slave::tcflush() in fhandler_tty.cc
Message-ID: <20050805161137.GG14783@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000e01c599bd$c0c19d30$0a7b2093@amber2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000e01c599bd$c0c19d30$0a7b2093@amber2>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00063.txt.bz2

On Aug  5 15:01, Vaclav Haisman wrote:
> 2005-08-05  Vaclav Haisman  <v.haisman@sh.cvut.cz>
> 
> * fhandler_tty.cc (fhandler_tty_slave::tcflush): Return either 0
> or -1.

Thanks,
applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
