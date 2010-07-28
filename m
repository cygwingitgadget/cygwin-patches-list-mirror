Return-Path: <cygwin-patches-return-7045-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30617 invoked by alias); 28 Jul 2010 22:44:58 -0000
Received: (qmail 30545 invoked by uid 22791); 28 Jul 2010 22:44:35 -0000
Received: from pool-173-76-48-4.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.4)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 28 Jul 2010 22:44:35 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 7A2F013C061	for <cygwin-patches@cygwin.com>; Wed, 28 Jul 2010 18:44:33 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 750F22B352; Wed, 28 Jul 2010 18:44:33 -0400 (EDT)
Date: Wed, 28 Jul 2010 22:44:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix build warnings for functions without return value
Message-ID: <20100728224433.GA11483@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <004d01cb2e99$7567c500$60374f00$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004d01cb2e99$7567c500$60374f00$@gmail.com>
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
X-SW-Source: 2010-q3/txt/msg00005.txt.bz2

On Wed, Jul 28, 2010 at 02:11:33PM -0700, Daniel Colascione wrote:
>Stop warnings about function not returning a value; the value is meaningless
>anyway, but the compiler can't know that.

I don't see why this is needed.  Cygwin uses -Werror by default so, if
gcc 4.3.4 emitted warnings we wouldn't be able to build a release or
make a snapshot.

cgf
