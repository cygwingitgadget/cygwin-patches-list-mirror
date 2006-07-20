Return-Path: <cygwin-patches-return-5937-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22896 invoked by alias); 20 Jul 2006 07:45:00 -0000
Received: (qmail 22884 invoked by uid 22791); 20 Jul 2006 07:44:59 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 20 Jul 2006 07:44:55 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 4F4DC6D42F4; Thu, 20 Jul 2006 09:44:53 +0200 (CEST)
Date: Thu, 20 Jul 2006 07:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: 1.5.20: Fix for parsing ACL entries with aclfromtext32() in sec_acl.cc
Message-ID: <20060720074453.GJ8056@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <44BF3023.9060707@data-al.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BF3023.9060707@data-al.de>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00032.txt.bz2

Hi Silvio,

On Jul 20 09:26, Silvio Laguzzi wrote:
> Hi, all
> 
> when parsing ACL entries from an input string with aclfromtext32() the
> ACL rights follow at different position after the ACL entry tags like 
> default:user, user, group, mask and so on. For almost all of the tags 
> this position was not handled correctly.

Thanks for the patch, but this patch is beyond the "trivial patch rule".
Please read http://cygwin.com/contrib.html, especially the "Before you
get started" section, print and fill out the copyright assignment form
http://cygwin.com/assign.txt, and send it by snail mail to the address
given in the form.  When the copyright assignment has reached us, we can
look further into this.


Thanks in advance,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
