Return-Path: <cygwin-patches-return-6353-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18285 invoked by alias); 15 Sep 2008 23:03:02 -0000
Received: (qmail 18226 invoked by uid 22791); 15 Sep 2008 23:03:01 -0000
X-Spam-Check-By: sourceware.org
Received: from smtprelay0215.hostedemail.com (HELO smtprelay.hostedemail.com) (216.40.44.215)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 15 Sep 2008 23:02:22 +0000
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254]) 	by smtprelay03.hostedemail.com (Postfix) with SMTP id 4A7BE674E79 	for <cygwin-patches@cygwin.com>; Mon, 15 Sep 2008 23:02:20 +0000 (UTC)
X-SpamScore: 1
X-Spam-Summary: 2,0,0,dda2b130aa5ccf03,bf0254f9ba4fff7a,cygwin@jason-gouger.com,,RULES_HIT:10:355:379:541:542:599:601:945:967:973:982:988:989:1155:1160:1261:1277:1311:1313:1314:1345:1358:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1766:1792:2393:2525:2551:2553:2559:2563:2682:2685:2693:2857:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3027:3352:3622:3865:3866:3867:3868:3869:3870:3871:3874:3934:3936:3938:3941:3944:3947:3950:3953:4250:5007:6117:6119:7679:7688:7903:8957:9025:9040,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:none,DNSBL:none
Received: from FISION1330 (nat-wv.mentorg.com [192.94.38.34]) 	(Authenticated sender: mail@jason-gouger.com) 	by omf07.hostedemail.com (Postfix) with ESMTP 	for <cygwin-patches@cygwin.com>; Mon, 15 Sep 2008 23:02:20 +0000 (UTC)
From: "Jason" <cygwin@jason-gouger.com>
To: <cygwin-patches@cygwin.com>
References: <003801c9177a$5debc030$19c34090$@com> <20080915222831.GA10709@ednor.casa.cgf.cx>
In-Reply-To: <20080915222831.GA10709@ednor.casa.cgf.cx>
Subject: RE: [PATCH] fix unlink for Cygwin 1.5.25-15 -- unintended data 	loss with symbolic file links
Date: Mon, 15 Sep 2008 23:03:00 -0000
Message-ID: <003c01c91787$0b69b2b0$223d1810$@com>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-us
X-session-marker: 6D61696C406A61736F6E2D676F756765722E636F6D
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00016.txt.bz2

On Monday, September 15, 2008 3:29 PM, Christopher Faylor wrote:
> On Mon, Sep 15, 2008 at 02:31:07PM -0700, Jason wrote:
> >Please consider the patch below for inclusion in the Cygwin 1.5 branch
which
> >corrects the deletion of symbolic link file types (Vista file reparse
> >points).
> >
> >The problem is that CreateFile will open the target and not the link.
See
> >the MSDN page
> >http://msdn.microsoft.com/en-us/library/aa365682(VS.85).aspx#CreateFile
for
> >a more detailed description of Vista's symbolic link handling.
>
> Sorry but we're not anticipating any new releases of Cygwin 1.5.x.
>
> cgf 

Okay, I thought I'd submit the trivial patch just in case someone else runs
into the problem.  The bug has very interesting side effects if someone does
a "rm -rf" of a directory which may contain such symbolic links.  Luckily I
had a backup.  I look forward to the 1.7 release!

