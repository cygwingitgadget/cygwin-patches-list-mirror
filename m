Return-Path: <cygwin-patches-return-4322-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13587 invoked by alias); 29 Oct 2003 08:43:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13466 invoked from network); 29 Oct 2003 08:43:39 -0000
Date: Wed, 29 Oct 2003 08:43:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: More stdint.h teaks
Message-ID: <20031029084338.GA22720@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20031028215934.31453.qmail@web21409.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031028215934.31453.qmail@web21409.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00041.txt.bz2

On Wed, Oct 29, 2003 at 08:59:34AM +1100, Danny Smith wrote:
> Hello
> 
> This gets rid of signed->unsigned warnings
> 
> Changelog
> 
> 2003-10-29  Danny Smith  <dannysmith@users.sourceforege.net>
> 
> 	include/stdint.h: Prevent signed->unsigned conversion
> 	for 32 and 64 bit min value constants.

Applied with a minor tweak to the ChangeLog entry.

Thanks.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
