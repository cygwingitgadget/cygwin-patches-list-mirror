Return-Path: <cygwin-patches-return-2296-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18865 invoked by alias); 3 Jun 2002 18:00:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18766 invoked from network); 3 Jun 2002 18:00:01 -0000
Date: Mon, 03 Jun 2002 11:00:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: passwd help/version patch
Message-ID: <20020603195959.I30892@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0205302054340.1492-200000@iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0205302054340.1492-200000@iocc.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00279.txt.bz2

On Thu, May 30, 2002 at 09:12:24PM -0500, Joshua Daniel Franklin wrote:
> After working on it a while, I think that exporting a
> cygwin_extract_nt_dom_user() would be best.

Chris suggested to export it slightly different.  Include sys/cygwin.h
and call

  cygwin_internal (CW_EXTRACT_DOMAIN_AND_USER, pw, domain, user);

instead of

  cygwin_extract_nt_dom_user (pw, domain, user);

Advantage: If passwd is running under an older Cygwin DLL, the
cygwin_internal() call just returns -1 and passwd can handle that
case cleanly while the other way would pop up a box, telling that
the procedure entry point couldn't be found.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
