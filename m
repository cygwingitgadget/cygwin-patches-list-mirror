Return-Path: <cygwin-patches-return-6344-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8675 invoked by alias); 1 Aug 2008 14:30:51 -0000
Received: (qmail 8658 invoked by uid 22791); 1 Aug 2008 14:30:48 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-37-80.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (96.233.37.80)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 01 Aug 2008 14:30:16 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id A5B8545F004; Fri,  1 Aug 2008 10:30:14 -0400 (EDT)
Date: Fri, 01 Aug 2008 14:30:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for pformat.c in winsup/mingw CVS
Message-ID: <20080801143014.GA16731@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <200808011353.m71DrjsI011717@StraightRunning.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200808011353.m71DrjsI011717@StraightRunning.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00007.txt.bz2

On Fri, Aug 01, 2008 at 02:53:53PM +0100, Colin Harrison wrote:
>The latest CVS winsup/mingw runtime caused a crash, for me, in strlen()
>when testing previously 'good' code built with it in the toolchain.  I
>found this patch fixed the problem for me, so it may be of help to
>others...

You should send mingw changes to the MinGW project following the
guidelines set forth here:

http://www.mingw.org/MinGWiki/index.php/SubmitPatches

cgf
