Return-Path: <cygwin-patches-return-6949-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 939 invoked by alias); 9 Feb 2010 16:26:42 -0000
Received: (qmail 927 invoked by uid 22791); 9 Feb 2010 16:26:41 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from demumfd001.nsn-inter.net (HELO demumfd001.nsn-inter.net) (93.183.12.32)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 09 Feb 2010 16:26:37 +0000
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55]) 	by demumfd001.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id o19GQXI1032221 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL) 	for <cygwin-patches@cygwin.com>; Tue, 9 Feb 2010 17:26:33 +0100
Received: from [10.149.155.84] ([10.149.155.84]) 	by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id o19GQWxi004301 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) 	for <cygwin-patches@cygwin.com>; Tue, 9 Feb 2010 17:26:33 +0100
Message-ID: <4B718CB8.7070308@towo.net>
Date: Tue, 09 Feb 2010 16:26:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091204 Lightning/1.0b1 Thunderbird/3.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
References: <4B266F9B.6070204@towo.net>  <20091214171323.GS8059@calimero.vinschen.de>  <20091215130036.GA19394@calimero.vinschen.de>  <4B28ACE8.1050305@towo.net>  <20091216145627.GM8059@calimero.vinschen.de>  <4B29934A.80902@towo.net>  <4B2C0715.8090108@towo.net>  <20091221101216.GA5632@calimero.vinschen.de>  <20100125190806.GA9166@calimero.vinschen.de>  <4B5F0585.9070903@towo.net> <20100126161036.GA31281@calimero.vinschen.de>
In-Reply-To: <20100126161036.GA31281@calimero.vinschen.de>
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
X-SW-Source: 2010-q1/txt/msg00065.txt.bz2

>
>> On 25.01.2010 20:08, Corinna Vinschen wrote:
>>      
>>> Hi Thomas,
>>> ...
>>> can you please create a patch to add some words to the "What's new and
>>> what changed from 1.7.1 to 1.7.2" section in the User's Guide
>>> (winsup/doc/new-features.sgml), in terms of your console enhancements?
>>>        
>> Hi, changelog and patch attached. I had already looked for a web or
>> man page describing console features to amend that but apparently
>> there is none.
>>      
Actually, I just remember again that I though I should change the 
terminfo entry too. Just - where's the source to patch?
Thomas
