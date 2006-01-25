Return-Path: <cygwin-patches-return-5726-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11468 invoked by alias); 25 Jan 2006 22:43:10 -0000
Received: (qmail 11451 invoked by uid 22791); 25 Jan 2006 22:43:10 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 25 Jan 2006 22:43:08 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.60) 	(envelope-from <brian@dessent.net>) 	id 1F1tLz-0006XF-AK 	for cygwin-patches@cygwin.com; Wed, 25 Jan 2006 22:43:05 +0000
Message-ID: <43D7FEF5.62A5A4D@dessent.net>
Date: Wed, 25 Jan 2006 22:43:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de> <Pine.GSO.4.63.0601250907210.2078@access1.cims.nyu.edu> <43D7EFBE.5010505@t-online.de>
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
X-SW-Source: 2006-q1/txt/msg00035.txt.bz2

Christian Franke wrote:

> At least when regtool is used interactively, it is IMO not very useful
> to have
> modem-line-noise-like output for REG_BINARY, but human readable output for
> the other value types.
> But this is the current behavior of "regtool get ...".

Instead of an explicit -b flag, perhaps it should just call isatty() and
if being run interactively, output human readable hex dump, otherwise
output raw binary.

Brian
