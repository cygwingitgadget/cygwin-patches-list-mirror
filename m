Return-Path: <cygwin-patches-return-1987-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8692 invoked by alias); 14 Mar 2002 12:43:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8641 invoked from network); 14 Mar 2002 12:43:14 -0000
Date: Thu, 14 Mar 2002 06:24:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: mkgroup usage/version patch
Message-ID: <20020314134312.R29574@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020313212632.11925.qmail@web20008.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020313212632.11925.qmail@web20008.mail.yahoo.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00344.txt.bz2

On Wed, Mar 13, 2002 at 01:26:32PM -0800, Joshua Daniel Franklin wrote:
> This patch generalizes the usage function to allow output to stdout in
> addition to stderr, and fixes an apparent typo where the help option
> is listed as -?,--help, while in reality the code supports -h,--help.
> It also adds a -v,--version option with Chris' print_version function.

While I'm going with the decision to add a version information
I don't understand why you changed 

- the usage output method.  I don't like to have a big multiline format
  string in fprintf.

- the function usage() to exit instead of returning the exitcode.

I don't see an advantage and I'd like you to keep the patch less
intrusive if possible.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
