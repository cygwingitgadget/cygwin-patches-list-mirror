Return-Path: <cygwin-patches-return-6761-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12629 invoked by alias); 13 Oct 2009 10:25:19 -0000
Received: (qmail 12610 invoked by uid 22791); 13 Oct 2009 10:25:17 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Oct 2009 10:25:13 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id C2AA96D5598; Tue, 13 Oct 2009 12:25:02 +0200 (CEST)
Date: Tue, 13 Oct 2009 10:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
Message-ID: <20091013102502.GG11169@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A9AD529.3060107@t-online.de> <20090901183209.GA14650@calimero.vinschen.de> <20091004123006.GF4563@calimero.vinschen.de> <20091004125455.GG4563@calimero.vinschen.de> <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de> <4ACFAE4D.90502@t-online.de> <20091010100831.GA13581@calimero.vinschen.de> <4AD243ED.6080505@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AD243ED.6080505@t-online.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00092.txt.bz2

On Oct 11 22:45, Christian Franke wrote:
> Corinna Vinschen wrote:
>> Thanks for the patch.  You did check that the normal setuid/seteuid
>> cases still work, didn't you?
>>
>>   
>
> Yes.

Cool.  I just tested it myself and it looks good.

>> What's wrong with:
>>
>>   for i in $(id -G);
>>   do
>>     [ $i -eq 544 ] && PS1='# '
>>   done
>>
>>   
>
> Is OK, except if admin group is mapped to other gid (0?) in /etc/group.

It isn't in the default case.  And it's important that there is a way
to handle this with simple POSIXy means.

> I removed the error check and set HANDLE_FLAG_INHERIT in seteuid32().

Oh, sure!  That's much simpler than duplicating the token handle at
set_imp_token time.

>> Do I miss something or is the setuid_to_restricted flag equivalent to
>> the curr_token_is_restricted flag [...]
>
> setuid_to_restricted is only set in setuid32, not in seteuid32. If 
> seteuid(geteuid()) is called, the behaviour is similar to the ruid != euid 
> case: The exec()ed process can revert to the original token.

Ok, so I missed something, sorry.

> 	* include/sys/cygwin.h: Add new cygwin_getinfo_type
> 	CW_SET_EXTERNAL_TOKEN.
> 	Add new enum CW_TOKEN_IMPERSONATION, CW_TOKEN_RESTRICTED.
> 	* cygheap.h (cyguser): New flags ext_token_is_restricted,
> 	curr_token_is_restricted and setuid_to_restricted.
> 	* external.cc (cygwin_internal): Add CW_SET_EXTERNAL_TOKEN.
> 	* sec_auth.cc (set_imp_token): New function.
> 	(cygwin_set_impersonation_token): Call set_imp_token ().
> 	* security.h (set_imp_token): New prototype.
> 	* spawn.cc (spawn_guts): Use CreateProcessAsUserW if
> 	restricted token was enabled by setuid ().
> 	Do not create new window station in this case.
> 	* syscalls.cc (seteuid32): Add handling of restricted
> 	external tokens. Set HANDLE_FLAG_INHERIT for primary token.
> 	(setuid32): Set setuid_to_restricted flag.
> 	* uinfo.cc (uinfo_init): Do not reimpersonate if
> 	restricted token was enabled by setuid ().
> 	Initialize user.*_restricted flags.

Patch checked in.

Thanks for doing this.  Would you have fun to provide a tool for the
net distro which uses this feature?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
