Return-Path: <cygwin-patches-return-4182-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24695 invoked by alias); 8 Sep 2003 21:59:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24686 invoked from network); 8 Sep 2003 21:59:46 -0000
Message-ID: <3F5CFBCC.C2EF0E7E@phumblet.no-ip.org>
Date: Mon, 08 Sep 2003 21:59:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Radu Greab <rgreab@fx.ro>
CC: cygwin-patches@cygwin.com
Subject: Re: fix getpwuid_r() and getpwnam_r()
References: <20030909.003617.40718540.radu@primIT.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00198.txt.bz2

Radu Greab wrote:
> 
> I have not rebuilt cygwin to test this patch, but I think that the
> problem and the fix are obvious: pw_comment is not returned or
> initialized by these reentrant functions. The problem was discovered
> when debugging a perl test failure on cygwin:
> 
> http://www.xray.mpe.mpg.de/mailing-lists/perl5-porters/2003-09/msg00500.html
> 
> Thanks,
> Radu Greab

It's true that member "comment" should be initialized.
However it is always NULL in Cygwin, so your code is likely to crash. 
Just set comment to NULL.

Pierre
