Return-Path: <cygwin-patches-return-7015-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 442 invoked by alias); 30 Mar 2010 20:01:47 -0000
Received: (qmail 348 invoked by uid 22791); 30 Mar 2010 20:01:46 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.126.187)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 30 Mar 2010 20:01:41 +0000
Received: from [192.168.69.1] (dslb-088-073-021-211.pools.arcor-ip.net [88.73.21.211]) 	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis) 	id 0M7nzI-1Nakqb00zA-00voI2; Tue, 30 Mar 2010 21:56:37 +0200
Message-ID: <4BB257B0.7000505@towo.net>
Date: Tue, 30 Mar 2010 20:01:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
References: <20091216145627.GM8059@calimero.vinschen.de> 	 <4B2C0715.8090108@towo.net> 	 <20091221101216.GA5632@calimero.vinschen.de> 	 <20100125190806.GA9166@calimero.vinschen.de> 	 <4B5F0585.9070903@towo.net> 	 <20100330095912.GZ18364@calimero.vinschen.de> 	 <4BB1D83A.8010406@towo.net> 	 <20100330142200.GA12926@calimero.vinschen.de> 	 <4BB21CBF.7030701@towo.net> 	 <20100330161503.GB18364@calimero.vinschen.de> <416096c61003300936i55764afeqf06d84251cd9a9b7@mail.gmail.com>
In-Reply-To: <416096c61003300936i55764afeqf06d84251cd9a9b7@mail.gmail.com>
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
X-SW-Source: 2010-q1/txt/msg00131.txt.bz2

Andy Koppe schrieb:
>>  How can I enforce printing garbage so I
>> can test the reset command?
>>     
>
> echo $'\e(0'
>   
and echo ^N (Control-N) for the other mode, which is more likely to 
occur by binary output;
the enable sequence for it is echo ^[)0 (same as above, with ')' instead 
of '(').

And I forgot the following sentence for the change log:
(fhandler_console::write) Reset VT100 graphic mode flags on terminal 
full reset (ESC c).

Thomas
