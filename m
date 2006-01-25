Return-Path: <cygwin-patches-return-5728-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8939 invoked by alias); 25 Jan 2006 23:45:33 -0000
Received: (qmail 8926 invoked by uid 22791); 25 Jan 2006 23:45:32 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 25 Jan 2006 23:45:29 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.60) 	(envelope-from <brian@dessent.net>) 	id 1F1uKM-0006ny-BI 	for cygwin-patches@cygwin.com; Wed, 25 Jan 2006 23:45:26 +0000
Message-ID: <43D80D94.7A57C696@dessent.net>
Date: Wed, 25 Jan 2006 23:45:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de>  <Pine.GSO.4.63.0601250907210.2078@access1.cims.nyu.edu> <43D7EFBE.5010505@t-online.de>  <43D7FEF5.62A5A4D@dessent.net> <Pine.GSO.4.63.0601251753110.839@access1.cims.nyu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00037.txt.bz2

Igor Peshansky wrote:

> What if you want to redirect the hex dump to a file?  IMO, isatty() checks
> are only useful if the output won't change qualitatively on redirection
> (e.g., for coloring).  Otherwise, it's always better to use an explicit
> flag.

Good point.  Why don't we just emulate the behavior of 'cat' here?  If
isatty() is true and non-ascii characters are in the output, then prompt
first before possibly fubaring the user's terminal, otherwise just
output the raw data.

And just as 'cat' does not have any internal code for formatting binary
data as a hex dump, neither should regtool, since 'od' works perfectly
for that and already has the veritable kitchen sink of formatting
options.

Brian
