Return-Path: <cygwin-patches-return-7384-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11131 invoked by alias); 22 May 2011 01:44:38 -0000
Received: (qmail 11120 invoked by uid 22791); 22 May 2011 01:44:37 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm3.bullet.mail.bf1.yahoo.com (HELO nm3.bullet.mail.bf1.yahoo.com) (98.139.212.162)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sun, 22 May 2011 01:44:23 +0000
Received: from [98.139.212.150] by nm3.bullet.mail.bf1.yahoo.com with NNFMP; 22 May 2011 01:44:22 -0000
Received: from [98.139.211.192] by tm7.bullet.mail.bf1.yahoo.com with NNFMP; 22 May 2011 01:44:22 -0000
Received: from [127.0.0.1] by smtp201.mail.bf1.yahoo.com with NNFMP; 22 May 2011 01:44:22 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp201.mail.bf1.yahoo.com with SMTP; 21 May 2011 18:44:22 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 04F3742804C	for <cygwin-patches@cygwin.com>; Sat, 21 May 2011 21:44:22 -0400 (EDT)
Date: Sun, 22 May 2011 01:44:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (2/5)
Message-ID: <20110522014421.GB18936@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCAD609.70106@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DCAD609.70106@cs.utoronto.ca>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00150.txt.bz2

On Wed, May 11, 2011 at 02:31:37PM -0400, Ryan Johnson wrote:
>Hi all,
>
>This patch has the parent sort its dll list topologically by 
>dependencies. Previously, attempts to load a DLL_LOAD dll risked pulling 
>in dependencies automatically, and the latter would then not benefit 
>from the code which "encourages" them to land in the right places.  The 
>dependency tracking is achieved using a simple class which allows to 
>introspect a mapped dll image and pull out the dependencies it lists. 
>The code currently rebuilds the dependency list at every fork rather 
>than attempt to update it properly as modules are loaded and unloaded. 
>Note that the topsort optimization affects only cygwin dlls, so any 
>windows dlls which are pulled in dynamically (directly or indirectly) 
>will still impose the usual risk of address space clobbers.

This seems CPU and memory intensive during a time for which we already
know is very slow.  Is the benefit really worth it?  How much more robust
does it make forking?

cgf
