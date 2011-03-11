Return-Path: <cygwin-patches-return-7200-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3616 invoked by alias); 11 Mar 2011 11:56:12 -0000
Received: (qmail 3579 invoked by uid 22791); 11 Mar 2011 11:56:01 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 11 Mar 2011 11:55:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7485C2C0243; Fri, 11 Mar 2011 12:55:53 +0100 (CET)
Date: Fri, 11 Mar 2011 11:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure that the default ACL contains the standard entries
Message-ID: <20110311115553.GF7064@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D02A41C.8030406@t-online.de> <20101211204653.GA26611@calimero.vinschen.de> <4D07E02A.2020202@t-online.de> <20101215141149.GW10566@calimero.vinschen.de> <4D090D12.6020407@t-online.de> <20101216111024.GX10566@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20101216111024.GX10566@calimero.vinschen.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00055.txt.bz2

Hi Christian,

On Dec 16 12:10, Corinna Vinschen wrote:
> On Dec 15 19:46, Christian Franke wrote:
> > BTW: Are there any long term plans to actually implement the acl "mask" ?
> > Should be possible by mapping the "mask" restrictions to deny acl
> > entries for each named entry:
> 
> There are no such plans, but that doesn't mean I wouldn't take patches
> which implement this.  In fact I would be *very* happy to get patches
> which improve ACL handling, and I'm not finicky in terms of the type
> of enhancement.  Various ideas come to mind:
> 
> - Fix acl(2) by handling deny ACEs at all.
> 
> - Implement the POSIX 1003.1e functions (maybe simply in terms of
>   the existing Solaris API).
> 
> - Add missing Solaris ACL functions (acl_get, facl_get, acl_set, facl_set,
>   acl_fromtext, acl_totext, acl_free, acl_strip, acl_trivial).
> 
> - Add Solaris NFSv4 ACLs, which, coincidentally, are almost equivalent
>   to Windows ACLs.  This would work nicely for NTFS ACLs, of course.
>   See http://docs.sun.com/app/docs/doc/819-2252/acl-5?l=en&a=view
> 
> - Last but not least:  Actually handle "mask".

did you have any further look into any of these points?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
