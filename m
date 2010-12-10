Return-Path: <cygwin-patches-return-7136-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1835 invoked by alias); 8 Dec 2010 10:25:10 -0000
Received: (qmail 1601 invoked by uid 22791); 8 Dec 2010 10:24:56 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 08 Dec 2010 10:24:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AF11C6D4272; Wed,  8 Dec 2010 11:24:48 +0100 (CET)
Date: Fri, 10 Dec 2010 22:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix permissions of DEF_CLASS_OBJ ACL entry
Message-ID: <20101208102448.GA25028@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4CFE9EE6.8010902@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4CFE9EE6.8010902@t-online.de>
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
X-SW-Source: 2010-q4/txt/msg00015.txt.bz2

On Dec  7 21:53, Christian Franke wrote:
> Cygwin returns permissions 0777 in the DEF_CLASS_OBJ
> ("default:mask:") ACL entry. This patch changes this to 07. The
> upper bits 0770 probably do not make any sense here.
> 
> The value 0777 is one reason why rsync may set bogus permissions.
> (The other reason is that rsync always expects a DEF_OTHER_OBJ
> entry. This is likely a rsync bug which should be fixed upstream)
> See http://cygwin.com/ml/cygwin/2010-11/msg00429.html
> 
> Christian
> 

> 2010-12-07  Christian Franke
> 
> 	* sec_acl.cc (getacl): Set DEF_CLASS_OBJ permissions
> 	to 07 instead of 0777.

Thanks for catching this.  Applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
