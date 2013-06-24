Return-Path: <cygwin-patches-return-7892-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24038 invoked by alias); 24 Jun 2013 09:46:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24026 invoked by uid 89); 24 Jun 2013 09:46:10 -0000
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.1
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Mon, 24 Jun 2013 09:46:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EFD595200DD; Mon, 24 Jun 2013 11:46:06 +0200 (CEST)
Date: Mon, 24 Jun 2013 09:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Export rawmemchr
Message-ID: <20130624094606.GA14391@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <51C7D660.6010509@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51C7D660.6010509@users.sourceforge.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q2/txt/msg00030.txt.bz2

Hi Yaakov,

On Jun 24 00:17, Yaakov (Cygwin/X) wrote:
> Patch for Cygwin, pending approval of my newlib patch, attached.

See my reply on the newlib list.  I would go with rawmemchr = strchr,
unless there's a really good reason not to.  The rest of the patch is
a no-brainer.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
