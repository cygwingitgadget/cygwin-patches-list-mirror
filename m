Return-Path: <cygwin-patches-return-7406-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31867 invoked by alias); 28 May 2011 20:59:43 -0000
Received: (qmail 31854 invoked by uid 22791); 28 May 2011 20:59:43 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm16-vm3.bullet.mail.ne1.yahoo.com (HELO nm16-vm3.bullet.mail.ne1.yahoo.com) (98.138.91.146)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sat, 28 May 2011 20:59:29 +0000
Received: from [98.138.90.52] by nm16.bullet.mail.ne1.yahoo.com with NNFMP; 28 May 2011 20:59:28 -0000
Received: from [98.138.226.58] by tm5.bullet.mail.ne1.yahoo.com with NNFMP; 28 May 2011 20:59:28 -0000
Received: from [127.0.0.1] by smtp209.mail.ne1.yahoo.com with NNFMP; 28 May 2011 20:59:28 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp209.mail.ne1.yahoo.com with SMTP; 28 May 2011 13:59:28 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 4B6BD42804D	for <cygwin-patches@cygwin.com>; Sat, 28 May 2011 16:59:27 -0400 (EDT)
Date: Sat, 28 May 2011 20:59:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (3/5)
Message-ID: <20110528205927.GA30578@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCAD629.8010803@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DCAD629.8010803@cs.utoronto.ca>
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
X-SW-Source: 2011-q2/txt/msg00172.txt.bz2

On Wed, May 11, 2011 at 02:32:09PM -0400, Ryan Johnson wrote:
>This patch fixes a bug in the reserve_at function which caused it to 
>sometimes reserve space needed by the dll it was supposed to help land. 
>This happens when the dll tries to land in a free region which overlaps 
>the desired location. The new code exploits the image introspection 
>(patch #2) to get the dll's image size and avoids the corner cases.

I've installed this patch, eliminating any depencencies on patch 2/5.

Btw, please reread the guidelines for ChangeLogs and model your changelog
entries on what you see in the current ChangeLog and the submissions you
see here.

The ChangeLog shouldn't be sent as an attachment.  It should have the
"header" including your name and date.  The tense shouldn't be "Changed
x" but "Change X".  Start entries after the colon with an uppercase
letter.  The changelog shouldn't be excessively wordy (that's for
comments:

http://www.gnu.org/prep/standards/html_node/Change-Logs.html

Thanks for the patch.

cgf
