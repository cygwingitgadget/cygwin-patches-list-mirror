Return-Path: <cygwin-patches-return-2312-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18379 invoked by alias); 5 Jun 2002 13:09:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18359 invoked from network); 5 Jun 2002 13:09:13 -0000
Date: Wed, 05 Jun 2002 06:09:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] minor pthread fixes
Message-ID: <20020605150912.X30892@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0206051439420.218-100000@algeria.intern.net> <016601c20c8e$cb6a5cf0$0200a8c0@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016601c20c8e$cb6a5cf0$0200a8c0@lifelesswks>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00295.txt.bz2

On Wed, Jun 05, 2002 at 10:44:54PM +1000, Robert Collins wrote:
> Ok, Chris, whats the guideline in nuber-of-line before we need an
> assignment? Do I need to back out this patch (it's very few lines, just
> spread over a few functions).

I'm not Chris, sorry, but the answer is basically something below
10 changed lines is treated as "nonsignificant".  There's no hard
rule, though.  Basically, if a change is not only fixing a bug but
introduces new functionality, it's a "significant" patch, even if
it's changing less than 10 lines.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
