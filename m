Return-Path: <cygwin-patches-return-7791-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13466 invoked by alias); 11 Jan 2013 12:52:33 -0000
Received: (qmail 13442 invoked by uid 22791); 11 Jan 2013 12:52:32 -0000
X-SWARE-Spam-Status: No, hits=-2.9 required=5.0	tests=AWL,BAYES_00,KHOP_THREADED,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.17.9)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 11 Jan 2013 12:52:24 +0000
Received: from [10.255.168.210] ([62.159.77.186])	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)	id 0LlpLM-1TKaOK3ve4-00ZnuX; Fri, 11 Jan 2013 13:52:21 +0100
Message-ID: <50F00AFA.2000307@towo.net>
Date: Fri, 11 Jan 2013 12:52:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Console modes: cursor style
References: <50EFCE3C.8030607@towo.net> <20130111110534.GD17162@calimero.vinschen.de>
In-Reply-To: <20130111110534.GD17162@calimero.vinschen.de>
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
X-SW-Source: 2013-q1/txt/msg00002.txt.bz2

On 11.01.2013 12:05, Corinna Vinschen wrote:
> On Jan 11 09:33, Thomas Wolff wrote:
>> The attached patch adds two escape control sequences to the Cygwin Console:
>>
>>   * Show/Hide Cursor (DECTCEM)
>>   * Set cursor style (DECSCUSR): block vs. underline cursor, or
>>     arbitrary size (as an extension, using values > 4)
>>
>> Thomas
>>
>> 2013-01-13  Thomas Wolff  <...>
>>
>> 	* fhandler.h (class dev_console): Flag for expanded control sequence.
>> 	* fhandler_console.cc (char_command): Supporting cursor style modes.
> Patch applied.  Can you provide a patch for the docs, too, please?
Sure, but: where are the docs to be patched? Any package to be installed?
------
Thomas
