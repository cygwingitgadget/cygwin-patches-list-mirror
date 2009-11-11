Return-Path: <cygwin-patches-return-6833-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15589 invoked by alias); 11 Nov 2009 17:56:26 -0000
Received: (qmail 15575 invoked by uid 22791); 11 Nov 2009 17:56:25 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from demumfd002.nsn-inter.net (HELO demumfd002.nsn-inter.net) (93.183.12.31)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 11 Nov 2009 17:56:19 +0000
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55]) 	by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id nABHuGnb007670 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL); 	Wed, 11 Nov 2009 18:56:16 +0100
Received: from [10.149.155.84] ([10.149.155.84]) 	by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id nABHuFTd014140 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Wed, 11 Nov 2009 18:56:16 +0100
Message-ID: <4AFAFABF.40903@towo.net>
Date: Wed, 11 Nov 2009 17:56:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>  <20091106101448.GA2568@calimero.vinschen.de>  <4AF73FEC.2050300@towo.net> <20091109133551.GA10130@calimero.vinschen.de>
In-Reply-To: <20091109133551.GA10130@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00164.txt.bz2

Corinna Vinschen wrote:
>>>> * Maybe the escape sequences of shifted function keys should be
>>>> modified   to comply with those of the Linux console?
>>>>         
>>> Aren't they compatible with xterm?  I don't think it's a terrible good
>>> idea to change that.
>>>       
>> No, they are not:
>>
>> Linux console
>> F1..F12         ^[[[A ^[[[B ^[[[C ^[[[D ^[[[E ^[[17~ ^[[18~ ^[[19~
>> ^[[20~ ^[[21~ ^[[23~ ^[[24~
>> shift-F1..F8    ^[[25~ ^[[26~ ^[[28~ ^[[29~ ^[[31~ ^[[32~ ^[[33~ ^[[34~
>>
>> cygwin console
>> F1..F12         ^[[[A ^[[[B ^[[[C ^[[[D ^[[[E ^[[17~ ^[[18~ ^[[19~
>> ^[[20~ ^[[21~ ^[[23~ ^[[24~
>> shift-F1..F10   ^[[23~ ^[[24~ ^[[25~ ^[[26~ ^[[28~ ^[[29~ ^[[31~
>> ^[[32~ ^[[33~ ^[[34~
>> [...]
>>  Furthermore, xterm and mintty also support
>> Control- and Alt-modified F-keys and combinations of the modifiers.
>> So if your preference would be to follow xterm here anyway, I would
>> welcome this change and provide a patch; I think this change can be
>> done without compatibility trouble in "mainstream applications"
>> since the shifted F-keys are not listed in the cygwin terminfo
>> entry.
>>     
> Ooookey, if they aren't listed in terminfo anyway, I have no problems
> to change them.  But we should stick to following the Linux console,
> I guess.
>   
Well, cygwin console is actually following rxvt and VT220 here (which I 
should have included in my survey for completeness), while Linux console 
is deviating from VT220, so there is at least some kind of consistence 
in the cygwin console. (Contemplating that rxvt and VT220 are both 
abandonware...)
If you don't like my suggestion to switch to the unanbigous sequences of 
xterm and mintty (still my favorite), I'll not pursue this issue further 
because I don't want to be blamed for potential confusion of a 
"shift-by-2" change. It would still be an option to fill the unmapped 
combinations (esp. with Ctrl and Alt), in that case probably in the 
style of rxvt.


About the Alt-AltGr issue (which is orthogonal to the previous 
Alt-non-ASCII issue):
>> ... e.g. Alt-AltGr-Q where AltGr-Q is @ (German keyboard).
>> ...; it does not work in xterm either.
>>     
(which isn't quite true; it works with the resource metaSendsEscape: true)

- I found a very simple patch, just one additional line (the third below):
              meta = (control_key_state & ALT_PRESSED) != 0
                     && ((control_key_state & CTRL_PRESSED) == 0
                         || (control_key_state & ALT_PRESSED) == ALT_PRESSED
                         || (wch <= 0x1f || wch == 0x7f));

and Alt-AltGr-Q delivers ESC @ as expected (German keyboard, AltGr-Q = @).

> That's potentially too tricky for the current code.  And, whatever
> super-duper change we make to this essential console code in future,
> let's wait until after 1.7.1, please.
>   
Thanks Andy for previous hints that enabled me find the solution, 
otherwise it would have been too tricky; the actual solution isn't.
Changes about the basic Ctrl-key layout for international keyboards are 
more super-duper apparently and will have to wait.

Thomas
