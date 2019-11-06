Return-Path: <cygwin-patches-return-9810-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 97032 invoked by alias); 6 Nov 2019 16:37:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 97016 invoked by uid 89); 6 Nov 2019 16:37:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 06 Nov 2019 16:37:15 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id SOIxiyTFkRnrKSOIyilJrP; Wed, 06 Nov 2019 09:37:13 -0700
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] Cygwin: console, pty: Prevent error in legacy console mode.
To: cygwin-patches@cygwin.com
References: <20191106115909.429-1-takashi.yano@nifty.ne.jp> <70126295-3dc8-7d1c-75ba-e5d60fe60b3e@SystematicSw.ab.ca> <20191107004406.00ffd699bed4c625f2ffde0b@nifty.ne.jp>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Message-ID: <69a4bcdb-6ae2-7772-d940-c304fd7d7c81@SystematicSw.ab.ca>
Date: Wed, 06 Nov 2019 16:37:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191107004406.00ffd699bed4c625f2ffde0b@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00081.txt.bz2

On 2019-11-06 08:44, Takashi Yano wrote:
> On Wed, 6 Nov 2019 08:06:55 -0700
> Brian Inglis wrote:
>>> +      if (con.is_legacy)
>>> +	setenv ("TERM", "cygwin", 1);
>>>      }
>>
>> handlers should not be changing user's env vars: that is the user's selection to
>> get their preferred operation in their apps.
>>
>> If you need to set TERM, shouldn't you also set it appropriately for non-legacy
>> console?
> 
> The environment TERM is set to cygwin or xterm-256color in environ.cc
> based on wincap.has_con_24bit_colors().
> 
> However, if legacy console mode is enabled, new terminal capability
> compatible with xterm is disabled. So TERM is override to cygwin by
> the code above.
> 
> This is done only in the first initialization stage, so TERM value
> set by user in .login, .bashrc, .tcshrc and etc, ... will be kept.
> 
> Only the case in which TERM is overrid is:
> 1) Enable console legacy mode.
> 2) Open command prompt.
> 3) set TERMq
> 4) start cygwin
> 
> What situation do you assume this causes problem?

Is this not executed on every object creation and on every fork?
If that is not the case, then legacy_console/() should be a singleton
object/method, constructed when accessed, or in wincap, like
has_con_24bit_colors() - is_con_legacy().

When user explicitly sets TERM before starting Cygwin, or after forking, Cygwin
does not touch it, so you should not, and perhaps the legacy console check
should be added there:

newlib-cygwin/winsup/doc/setup-env.xml:
<para>
The <envar>TERM</envar> environment variable specifies your terminal
type.  It is automatically set to <literal>cygwin</literal> if you have
not set it to something else.
</para>

newlib-cygwin/winsup/cygwin/environ.cc:
   /* If console has 24 bit color capability, TERM=xterm-256color,
      otherwise, TERM=cygwin */
   if (!sawTERM)
-    envp[i++] = strdup (wincap.has_con_24bit_colors () ? xterm : cygterm);
+    envp[i++] = strdup (wincap.has_con_24bit_colors () &&
!wincap.is_con_legacy() ? xterm : cygterm);

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
