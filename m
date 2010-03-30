Return-Path: <cygwin-patches-return-7009-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18055 invoked by alias); 30 Mar 2010 10:54:07 -0000
Received: (qmail 18041 invoked by uid 22791); 30 Mar 2010 10:54:06 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=BAYES_00
X-Spam-Check-By: sourceware.org
Received: from ns2.sietec.de (HELO mail.sietec.de) (213.61.69.205)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 30 Mar 2010 10:54:01 +0000
Received: from mail.bln1.bf.nsn-intra.net (ns2.bln1.bf.nsn-intra.net [10.149.159.159]) 	by mail.sietec.de (8.13.5/8.13.5/MTA) with ESMTP id o2UArkgp026014 	for <cygwin-patches@cygwin.com>; Tue, 30 Mar 2010 12:53:51 +0200 (MEST)
Received: from [10.149.155.84] (stbm8186.bln1.bf.nsn-intra.net [10.149.155.84]) 	by mail.bln1.bf.nsn-intra.net (8.13.5/8.13.5/MTA) with ESMTP id o2UArk3s025688 	for <cygwin-patches@cygwin.com>; Tue, 30 Mar 2010 12:53:46 +0200 (CEST)
Message-ID: <4BB1D83A.8010406@towo.net>
Date: Tue, 30 Mar 2010 10:54:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.8) Gecko/20100227 Lightning/1.0b1 Thunderbird/3.0.3
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
References: <4B266F9B.6070204@towo.net> <20091214171323.GS8059@calimero.vinschen.de> <20091215130036.GA19394@calimero.vinschen.de> <4B28ACE8.1050305@towo.net> <20091216145627.GM8059@calimero.vinschen.de> <4B29934A.80902@towo.net> <4B2C0715.8090108@towo.net> <20091221101216.GA5632@calimero.vinschen.de> <20100125190806.GA9166@calimero.vinschen.de> <4B5F0585.9070903@towo.net> <20100330095912.GZ18364@calimero.vinschen.de>
In-Reply-To: <20100330095912.GZ18364@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2010-q1/txt/msg00125.txt.bz2

Hi Corinna,

On 30.03.2010 11:59, Corinna Vinschen wrote:
> Hi Thomas,
>    
For some reason this mail didn't make it into my cygwin mailbox, so it's 
good you sent me a personal CC.

> ...
> Since you were looking into the Cygwin console code lately, maybe you
> could find out why `stty sane' doesn't reset the character set?
>    
stty sane isn't supposed to do anything "sane" to the terminal, I think, 
just to the tty device.
The tool to use would be 'reset'. So I'll try to find out why 'reset' 
doesn't reset the character set :-\ .

> A couple of minutes ago I printed the bytes from an ISO image unfiltered
> to the console.  Afterwards, the console was using the alternate
> charset.
There are two methods to switch to the alternate character set. One is 
by just sending a Control-N. Most terminals "guard" this method by 
requiring an enable sequence before this works. I guess this would 
considerably reduce the risk that this happens, that's probably why they 
do it.
I didn't implement the guarding mechanism in fhandler_console (although 
I prepared it somewhat) so I think I should fully implement that.
Also I tuned mined to send the corresponding disable sequence on exit 
which it didn't, probably (and weird enough) because terminfo maintains 
the enable capability but no disable capability...

> `stty sane' does not switch back to the default charset for some reason.
>    
See above; I don't think it's supposed to do that.

> If you have a bit of spare time, do you think you would like to have a look?
>    
Is it sufficient to complete this in 2 weeks (after Easter time)?

Thomas
