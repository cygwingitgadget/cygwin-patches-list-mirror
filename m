Return-Path: <cygwin-patches-return-4901-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 527 invoked by alias); 17 Aug 2004 12:13:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 504 invoked from network); 17 Aug 2004 12:13:30 -0000
Date: Tue, 17 Aug 2004 12:13:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Update for the testsuite, devdsp
Message-ID: <20040817121351.GH1689@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040816230955.0080fb30@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040816230955.0080fb30@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00053.txt.bz2

On Aug 16 23:09, Pierre A. Humblet wrote:
> This patch is a merge of what Gerd sent on July 17 and of
> my changes to match the improved capability of the driver.

Applied.  Thanks!

> This is the first time I run the testsuite, and it was on WinME. 
> There were more failures than I expected, e.g. in mmap. I don't
> know how this compares to NT.

I guess it might make sense to discuss this on cygwin-developers.
Could you send your results?  Chris and I both ran the testsuite on
XP and the FAIL count is 0.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
