Return-Path: <cygwin-patches-return-2121-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13261 invoked by alias); 29 Apr 2002 10:24:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13240 invoked from network); 29 Apr 2002 10:24:11 -0000
Date: Mon, 29 Apr 2002 03:24:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for mkpasswd
Message-ID: <20020429122410.E11549@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <001901c1ee0e$61f789d0$0100a8c0@world9t3igycu7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001901c1ee0e$61f789d0$0100a8c0@world9t3igycu7>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00105.txt.bz2

On Sat, Apr 27, 2002 at 12:10:03PM -0500, Joshua Daniel Franklin wrote:
> Here is a patch for mkpasswd. It brings mkpasswd up to date with the
> changes already made to mkgroup.
> 
> Changelog:
> 
> 2001-03-19  Joshua Daniel Franklin  joshuadfranklin@yahoo.com
>     * mkpasswd.c (usage): Simplify usage output.  Generalize to allow use
>     for help. Correct '?' typo to 'h'.
>     (longopts): Add version option.
>     (opts): Add 'v' version option.
>     (print_version): New function.
>     (main): Accommodate new version option.  Accommodate usage parameter
>     changes. 

Applied.  Additionally I've changed all exit() calls in main() to return
statements.

However, did you have a look into your ChangeLog entry?  Its format
is somewhat disappointing... and it's interesting that you've hold back
your changes more than a year now ;-)

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
