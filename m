Return-Path: <cygwin-patches-return-6862-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12493 invoked by alias); 14 Dec 2009 16:17:53 -0000
Received: (qmail 12479 invoked by uid 22791); 14 Dec 2009 16:17:52 -0000
X-SWARE-Spam-Status: No, hits=-0.9 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_JMF_BL
X-Spam-Check-By: sourceware.org
Received: from demumfd002.nsn-inter.net (HELO demumfd002.nsn-inter.net) (93.183.12.31)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 14 Dec 2009 16:17:48 +0000
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55]) 	by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id nBEGHjTr012545 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL) 	for <cygwin-patches@cygwin.com>; Mon, 14 Dec 2009 17:17:45 +0100
Received: from [10.149.155.84] ([10.149.155.84]) 	by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id nBEGHiLa027161 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) 	for <cygwin-patches@cygwin.com>; Mon, 14 Dec 2009 17:17:45 +0100
Message-ID: <4B266528.7090006@towo.net>
Date: Mon, 14 Dec 2009 16:17:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>  <20091106101448.GA2568@calimero.vinschen.de>  <4AF73FEC.2050300@towo.net>  <20091119152632.GJ29173@calimero.vinschen.de>  <20091119160054.GB8185@ednor.casa.cgf.cx>  <20091119160948.GA1883@calimero.vinschen.de>  <4B1C04D1.8010707@towo.net> <20091214114715.GG8059@calimero.vinschen.de>
In-Reply-To: <20091214114715.GG8059@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00193.txt.bz2

Corinna Vinschen wrote:
> Hi Tom,
>   
Hi Cori,

> On Dec  6 20:24, Thomas Wolff wrote:
>   
>> This is my updated and extended patch for a number of console enhancements.
>>     
>> ...
>>     
>> If you want a subset of the features sooner than others, I may split
>> the patch.
>>     
> Thanks for the offer.  It would be nice if you could split up the patch
> in the chunks which you're referring to in your ChangeLog entries.  It
> makes it less hard to follow the individual bits.
Sure, although I had hoped I could at least combine a few modifications 
to reduce fiddling around...
Also, since it's always cumbersome to update a patch to a new target 
version, would you be willing to apply some of the features still to the 
current release, 1.7.0-68?
I would provide those first.
My proposal:

Patch 1 (1.7.0-68):
* Additional event reporting as described before.
* Add and fix a few rarely used screen attributes as described before.
* Enable ESC prefixing for Alt-AltGr keys, so that e.g. Alt-@ works on 
keyboards where @ is AltGr-q (a one-liner).
But if you prefer, I'll make it 3 patches.

Patch 2 (maybe 1.7.0-68, or later, as you like):
* Extend escape sequences for modified function keys to indicate all 
combinations of Ctrl, Shift, Alt, using the rxvt codes.
* Extend escape sequences for modified keypad keys to indicate all 
combinations of Ctrl, Shift, Alt, following the xterm/mintty convention 
for Ctrl and Shift, and the rxvt/linux convention for Alt, to reach 
maximum compatibility.
  Note that Alt handling interfers with the Windows-style Alt-numeric 
character input method but it did so before already, so I didn't break 
anything. However, if that method is desired to work, I would modify my 
patch accordingly.

Patch 3 (maybe 1.7.0-68, or later, as you like):
* Add VT100 graphics mode. It remaps small ASCII letters to line drawing 
graphics and is enabled / disabled in either of two ways:
* Add "Secondary Device Attribute" report option to terminal status reports.
I would like to leave the second in here because both include an update 
of escape sequence parsing. It's in preparation of patch 4.

Patch 4 (to be postponed as there's still some trouble with it):
* Fix cursor position reports and terminal status reports to work.

Patch 5 (later, to be investigated):
* Fix control-character mappings (for non-letter controls) on 
international keyboards.

Kind regards,
Thomas
