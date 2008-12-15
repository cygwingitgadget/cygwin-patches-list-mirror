Return-Path: <cygwin-patches-return-6393-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3752 invoked by alias); 15 Dec 2008 10:32:30 -0000
Received: (qmail 3739 invoked by uid 22791); 15 Dec 2008 10:32:29 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 15 Dec 2008 10:31:36 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id DBA9E6D4356; Mon, 15 Dec 2008 11:34:26 +0100 (CET)
Date: Mon, 15 Dec 2008 10:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may 	crash      find)
Message-ID: <20081215103426.GA31452@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20081208115433.GX12905@calimero.vinschen.de> <49417625.4030209@t-online.de> <20081212152000.GA32492@calimero.vinschen.de> <494287F4.2080505@byu.net> <20081212161304.GK32197@calimero.vinschen.de> <49428EA4.5090402@byu.net> <20081212164007.GL32197@calimero.vinschen.de> <4942A03A.5060104@t-online.de> <20081213091246.GN32197@calimero.vinschen.de> <4943BAB0.8080001@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4943BAB0.8080001@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00037.txt.bz2

On Dec 13 14:37, Christian Franke wrote:
> Corinna Vinschen wrote:
>> On Dec 12 18:32, Christian Franke wrote:
>>   
>>> Why not encode "@" as a reserved name like it is already done for "." and 
>>> ".." (which appear as "%2E" and "%2E.")? This would provide backward 
>>> compatibility and consistency with current conversions:
>>>
>>> @ - default value
>>> %40 - named key or value
>>> %40%val - named value if key exists
>>>
>>> I will post a patch.
>>>     
>>
>> Perfect.
>>
>>   
>
> As a side effect, the patch fixes an old bug:
> stat("/proc/registry/.../@", .) did not set st_size.
>
>
> 2008-12-13  Christian Franke  <franke@computer.org>
>
> 	* fhandler_registry.cc (DEFAULT_VALUE_NAME): Remove constant.
> 	(encode_regname): Encode empty (default) name to "@".
> 	Encode "@" to "%40".  Change error return to -1.
> 	(decode_regname): Decode "@" to empty name.  Decode "%40" to "@".
> 	(fhandler_registry::exists): Skip check for keys if name is empty.
> 	Remove check for DEFAULT_VALUE_NAME, now handled by decode_regname ().
> 	(fhandler_registry::readdir): Remove check for empty name, now
> 	handled by encode_regname ().
> 	(fhandler_registry::open): Remove check for DEFAULT_VALUE_NAME.
> 	(fhandler_registry::open_key): Fail with ENOENT if key name is empty.

Thanks for the patch.  Can you resend it against the latest version
of fhandler_registry.cc, please?  It doesn't apply cleanly anymore.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
