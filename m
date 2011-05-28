Return-Path: <cygwin-patches-return-7405-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28511 invoked by alias); 28 May 2011 20:50:19 -0000
Received: (qmail 28498 invoked by uid 22791); 28 May 2011 20:50:18 -0000
X-SWARE-Spam-Status: No, hits=-0.1 required=5.0	tests=AWL,BAYES_50,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm6.bullet.mail.ne1.yahoo.com (HELO nm6.bullet.mail.ne1.yahoo.com) (98.138.90.69)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sat, 28 May 2011 20:50:03 +0000
Received: from [98.138.90.50] by nm6.bullet.mail.ne1.yahoo.com with NNFMP; 28 May 2011 20:50:02 -0000
Received: from [98.138.226.59] by tm3.bullet.mail.ne1.yahoo.com with NNFMP; 28 May 2011 20:50:02 -0000
Received: from [127.0.0.1] by smtp210.mail.ne1.yahoo.com with NNFMP; 28 May 2011 20:50:02 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp210.mail.ne1.yahoo.com with SMTP; 28 May 2011 13:50:01 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 446AF42804D;	Sat, 28 May 2011 16:50:01 -0400 (EDT)
Date: Sat, 28 May 2011 20:50:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com, Ryan Johnson <ryan.johnson@cs.utoronto.ca>
Subject: Problems with: Improvements to fork handling (2/5)
Message-ID: <20110528205000.GA30326@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Ryan Johnson <ryan.johnson@cs.utoronto.ca>
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
X-SW-Source: 2011-q2/txt/msg00171.txt.bz2

On Wed, May 11, 2011 at 02:31:37PM -0400, Ryan Johnson wrote:
>This patch has the parent sort its dll list topologically by 
>dependencies. Previously, attempts to load a DLL_LOAD dll risked pulling 
>in dependencies automatically, and the latter would then not benefit 
>from the code which "encourages" them to land in the right places. The 
>dependency tracking is achieved using a simple class which allows to 
>introspect a mapped dll image and pull out the dependencies it lists. 
>The code currently rebuilds the dependency list at every fork rather 
>than attempt to update it properly as modules are loaded and unloaded. 
>Note that the topsort optimization affects only cygwin dlls, so any 
>windows dlls which are pulled in dynamically (directly or indirectly) 
>will still impose the usual risk of address space clobbers.

Bad news.

I applied this patch and the one after it but then noticed that zsh started
producing:  "bad address: " errors.

path:4: bad address: /share/bin/dopath
term:1: bad address: /bin/tee

The errors disappear when I back this patch out.

FWIW, I was running "zsh -l".  I have somewhat complicated
.zshrc/.zlogin/.zshenv files.  I'll post them if needed.

Until this is fixed, this patch and the subsequent ones which rely on
it, can't go in.  I did commit this fix but it has been backed out now.

cgf
