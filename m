Return-Path: <cygwin-patches-return-4905-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6224 invoked by alias); 21 Aug 2004 13:55:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6212 invoked from network); 21 Aug 2004 13:55:23 -0000
Date: Sat, 21 Aug 2004 13:55:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Update for the testsuite, devdsp
Message-ID: <20040821135602.GD9451@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040816230955.0080fb30@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040816230955.0080fb30@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00057.txt.bz2

On Mon, Aug 16, 2004 at 11:09:55PM -0400, Pierre A. Humblet wrote:
>This patch is a merge of what Gerd sent on July 17 and of
>my changes to match the improved capability of the driver.
>
>This is the first time I run the testsuite, and it was on WinME. 
>There were more failures than I expected, e.g. in mmap. I don't
>know how this compares to NT.

I've run the test suite fairly recently and the failures are what I'd
expect.  I haven't run it on Win9x/Me for some time.

Please check this in, too.

cgf

>2004-08-17 Gerd Spalink <Gerd.Spalink@t-online.de>
>	    Pierre Humblet <Pierre.Humblet@ieee.org>
>
>	* devdsp.c: Outputs the names of the main test functions.
>	(forkrectest): Expect child success.
>	(forkplaytest): Ditto.
>	(syncwithchild): Output the child status and the desired value.
>	(sinegenw): Reduce volume of the beep.
>	(sinegenb): Ditto.
>	(dup_test): New test.
