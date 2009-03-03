Return-Path: <cygwin-patches-return-6426-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14941 invoked by alias); 3 Mar 2009 15:38:19 -0000
Received: (qmail 14923 invoked by uid 22791); 3 Mar 2009 15:38:17 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-111.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.111)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 03 Mar 2009 15:38:11 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id D038613C022 	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2009 10:38:01 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id C82522B385; Tue,  3 Mar 2009 10:38:01 -0500 (EST)
Date: Tue, 03 Mar 2009 15:38:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] gethostbyname2  again
Message-ID: <20090303153801.GA17180@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0KFW0072QPTQUMJ2@vms173001.mailsrvcs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0KFW0072QPTQUMJ2@vms173001.mailsrvcs.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00024.txt.bz2

On Mon, Mar 02, 2009 at 08:36:55PM -0500, Pierre A. Humblet wrote:
>    realloc_ent function, and call it from both dup_ent and the helper. That 
> caused minor
>    changes in the 4 versions of dup_ent, and I don't know exactly what 
> format to use in the ChangeLog

I would rather that you keep dup_ent as is so that there is no need to
do run-time checks on the type.  If you need to do something similar to
what is currently in dupent, then couldn't you still create a
realloc_ent but just pass in the destination pointer?  Or even just make
realloc_ent mimic realloc but do the rounding that seems to be the
impetus for your breaking this out into a separate function.

cgf
