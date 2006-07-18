Return-Path: <cygwin-patches-return-5928-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 660 invoked by alias); 18 Jul 2006 14:16:25 -0000
Received: (qmail 650 invoked by uid 22791); 18 Jul 2006 14:16:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 18 Jul 2006 14:16:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 9461354C004; Tue, 18 Jul 2006 16:16:17 +0200 (CEST)
Date: Tue, 18 Jul 2006 14:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: 1.5.20: acltotext32 - fix of error when handling default ACL types
Message-ID: <20060718141617.GD27029@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <44BCD49A.10701@data-al.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BCD49A.10701@data-al.de>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00023.txt.bz2

On Jul 18 14:31, Silvio Laguzzi wrote:
> I tracked down the problem to the implementation of
> acltotext32 (__aclent32_t *aclbufp, int aclcnt) in
> src/winsup/cygwin/sec_acl.cc.
> 
> The prefix "default" was correctly added to the output string in buf for
> a default ACL entry type.
> But the following switch(aclbuf[pos].a_type) statement did not handle
> these default ACL entry types and stopped with EINVAL.
> 
> I changed line 731 in sec_acl.cc to
> 
> switch(aclbuf[pos].a_type & ~ACL_DEFAULT)
> 
> and everything went fine.
> 
> An unified diff for the code, the output of the 'cygcheck -s -v -r'
> command and the corresponding ChangeLog is included in this message.
> 
> I hope that this fix may contribute to improve Win32 ACL handling under
> Cygwin.
> [...]
> --- cygwin-snapshot-20060714-1/winsup/cygwin/sec_acl-orig.cc	2005-06-07 21:42:06.000000000 +0200
> +++ cygwin-snapshot-20060714-1/winsup/cygwin/sec_acl.cc	2006-07-18 12:50:47.812500000 +0200
> @@ -728,7 +728,7 @@ acltotext32 (__aclent32_t *aclbufp, int 
>        first = false;
>        if (aclbufp[pos].a_type & ACL_DEFAULT)
>  	strcat (buf, "default");
> -      switch (aclbufp[pos].a_type)
> +      switch (aclbufp[pos].a_type & ~ACL_DEFAULT)
>  	{
>  	case USER_OBJ:
>  	  __small_sprintf (buf + strlen (buf), "user::%s",
> 

> 2006-07-18  Silvio Laguzzi  <slaguzzi@data-al.de>
> 
> 	* sec_acl.cc (acltotext32): Add missing handling of default ACL entry
> 	types.
> 

Applied.  Thanks for the patch.

I assume this was accidentally but please don't attach *all* of the
ChangeLog file, just your single entry.  You can also entirely
drop the cygcheck output when sending patches to this list.  The
cygcheck output is only for analyzing problem reports on the cygwin ML.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
