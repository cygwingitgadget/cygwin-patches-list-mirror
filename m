Return-Path: <cygwin-patches-return-7651-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19220 invoked by alias); 24 Apr 2012 19:35:05 -0000
Received: (qmail 19139 invoked by uid 22791); 24 Apr 2012 19:35:04 -0000
X-SWARE-Spam-Status: No, hits=-3.2 required=5.0	tests=AWL,BAYES_00,KHOP_THREADED,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.17.8)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 24 Apr 2012 19:34:50 +0000
Received: from [127.0.0.1] (dslb-088-073-036-239.pools.arcor-ip.net [88.73.36.239])	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)	id 0Le960-1RtGmj1Epo-00piif; Tue, 24 Apr 2012 21:34:49 +0200
Message-ID: <4F970064.8020009@towo.net>
Date: Tue, 24 Apr 2012 19:35:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Extended mouse coordinates
References: <4F945706.3050808@towo.net> <20120424144403.GA24364@calimero.vinschen.de>
In-Reply-To: <20120424144403.GA24364@calimero.vinschen.de>
X-TagToolbar-Keys: D20120424213500407
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q2/txt/msg00020.txt.bz2

Am 24.04.2012 16:44, schrieb Corinna Vinschen:
> On Apr 22 21:07, Thomas Wolff wrote:
>> This patch replaces my previous proposal
>> (http://cygwin.com/ml/cygwin-patches/2012-q2/msg00005.html) with two
>> modifications:
>>
>>   * Fixed a bug that suppressed mouse reporting at large coordinates (in
>>     all modes actually:-\ )
>>   * Added mouse mode 1005 (total of 3 three new modes, so all reporting
>>     modes run by current terminal emulators would be implemented)
>>
>> I would appreciate the patch to be applied this time, planned to be
>> my last mouse patch :)
>>
>> Kind regards,
>> Thomas
>> 2012-04-03  Thomas Wolff<towo@towo.net>
>>
>> 	* fhandler.h (class dev_console): Two flags for extended mouse modes.
>> 	* fhandler_console.cc (fhandler_console::read): Implemented
>> 	extended mouse modes 1015 (urxvt, mintty, xterm) and 1006 (xterm).
>> 	Not implemented extended mouse mode 1005 (xterm, mintty).
>> 	Supporting mouse coordinates greater than 222 (each axis).
>> 	Also: two { wrap formatting consistency fixes.
>> 	(fhandler_console::char_command) Initialization of enhanced
>> 	mouse reporting modes.
>>
> Patch applied with changes.  Please use __small_sprintf rather than
> sprintf.  I also changed the CHangeLog entry slightly.  Keep it short
> and in present tense.
>
>
> Thanks,
> Corinna
>
Hmm, thanks but I'm afraid this went wrong. You quote (and probably 
applied) my first patch which is missing mouse mode 1005 and 
unfortunately also has a bug which effectively makes the extended 
coordinates unusable (because the reports are suppressed in that case as 
they were before :( ).
The mail you responded to contained an updated patch.
Thomas
