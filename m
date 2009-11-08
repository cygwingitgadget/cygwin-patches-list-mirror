Return-Path: <cygwin-patches-return-6819-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12950 invoked by alias); 8 Nov 2009 22:02:39 -0000
Received: (qmail 11170 invoked by uid 22791); 8 Nov 2009 22:02:36 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=AWL,BAYES_05,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.17.8)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 08 Nov 2009 22:02:27 +0000
Received: from [127.0.0.1] (dslb-088-073-010-191.pools.arcor-ip.net [88.73.10.191]) 	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis) 	id 0LeS5t-1MLknY3rKf-00q5dx; Sun, 08 Nov 2009 23:02:23 +0100
Message-ID: <4AF73FEC.2050300@towo.net>
Date: Sun, 08 Nov 2009 22:02:00 -0000
From: towo@towo.net
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de> <20091106101448.GA2568@calimero.vinschen.de>
In-Reply-To: <20091106101448.GA2568@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
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
X-SW-Source: 2009-q4/txt/msg00150.txt.bz2

Corinna Vinschen schrieb:
> On Nov  6 09:20, Thomas Wolff wrote:
>   
>> Hi,
>> About enhancements of cygwin console features, I've now worked out a 
>> patch which does the following:
>>     
>
> Thanks for the patch, it looks like a nice addition.
>
> However, there's the problem of the copyright assignment.  As described
> on the http://cygwin.com/contrib.html page, in the "Before you get
> started" section, we can't take non-trivial patches without have a
> signed copyright assignment form (http://cygwin.com/assign.txt) in place.
>   
It's in the envelope.

> A few comments:
>
>   
>> * Implement additional mouse reporting modes 1002 and 1003 as known 
>>   from xterm and mintty; they report mouse move events.
>> * Add detection and reporting of mouse scroll events to mouse reporting 
>>   mode 1000.
>>   Note: This works on my home PC (Windows XP Home) but it's not effective 
>>   on my work PC (Windows XP Professional) where the mouse wheel scrolls the 
>>   Windows console (which it doesn't on the other machine); I don't know 
>>   how to disable or configure this.
>>     
> Open the console properties dialog and disable QuickEdit.
>   
I had checked the properties and nothing worked. QuickEdit enabled would 
disable mouse control for applications altogether; it is disabled so 
mouse click and move events can be processed but the mouse wheel still 
scrolls the window instead, on that machine.

>> * Enforce consistence between select() and read() about whether mouse 
>>   reporting input is available by moving all checks into the common 
>>   function mouse_aware.
>> * Add mouse focus reporting mode 1004 as known from xterm and mintty.
>> * As a separate change, where I added the initialization of the additional 
>>   reporting modes, I also added and fixed some screen attribute modes as 
>>   known from the Linux console (and xterm):
>>   - ESC[22m disable bold, ESC[28m disable invisible, ESC[25m disable blinking
>>   - ESC[2m dim as usual on other terminals, instead of ESC[9m
>>     
> For backward compatibility, I'd prefer if ESC[9m would still do the same.
> As long as ESC[9m isn't desparately needed for something else...
>   
I thought there might be this objection as it is in theory an 
incompatible change but it's not in practice since dim mode doesn't work 
anyway; so I think this change towards the standard assignment should be 
done before someone in the future may fix dim mode to work after which 
it would actually be an incompatible change.

>> * Maybe the escape sequences of shifted function keys should be modified 
>>   to comply with those of the Linux console?
>>     
> Aren't they compatible with xterm?  I don't think it's a terrible good
> idea to change that.
>   
No, they are not:

Linux console
F1..F12         ^[[[A ^[[[B ^[[[C ^[[[D ^[[[E ^[[17~ ^[[18~ ^[[19~ 
^[[20~ ^[[21~ ^[[23~ ^[[24~
shift-F1..F8    ^[[25~ ^[[26~ ^[[28~ ^[[29~ ^[[31~ ^[[32~ ^[[33~ ^[[34~

cygwin console
F1..F12         ^[[[A ^[[[B ^[[[C ^[[[D ^[[[E ^[[17~ ^[[18~ ^[[19~ 
^[[20~ ^[[21~ ^[[23~ ^[[24~
shift-F1..F10   ^[[23~ ^[[24~ ^[[25~ ^[[26~ ^[[28~ ^[[29~ ^[[31~ ^[[32~ 
^[[33~ ^[[34~

xterm, mintty
F1..F12         ^[OP ^[OQ ^[OR ^[OS ^[[15~ ^[[17~ ^[[18~ ^[[19~ ^[[20~ 
^[[21~ ^[[23~ ^[[24~
shift-F1..F12   ^[[1;2P ^[[1;2Q ^[[1;2R ^[[1;2S ^[[15;2~ ^[[17;2~ 
^[[18;2~ ^[[19;2~ ^[[20;2~ ^[[21;2~ ^[[23;2~ ^[[24;2~

Note the shift by 2 in the shifted F-keys from Linux console to cygwin 
console which is quite confusing for any application that might want to 
use them. Modified F-keys are indicated in a generic way by xterm and 
mintty which is much more obvious for unique mapping to the keys and 
which can be detected by applications in a generic way as well. 
Furthermore, xterm and mintty also support Control- and Alt-modified 
F-keys and combinations of the modifiers.
So if your preference would be to follow xterm here anyway, I would 
welcome this change and provide a patch; I think this change can be done 
without compatibility trouble in "mainstream applications" since the 
shifted F-keys are not listed in the cygwin terminfo entry.

>> * I would like to fix some key assignments:
>>   - Control-(Shift-)6 inputs Control-^ which is not proper on international 
>>     keyboards if Shift-6 is not "^", Control-^ (the key) does not input 
>>     Control-^ (the character) on the other hand; the same glitch 
>>     occurs in the pure Windows console, however.
>>     Unfortunately, with the functions being used it is not possible to 
>>     detect that shifted key "^" was hit together with Control; only 
>>     keycodes/scancodes are available when Control/Shift/Alt are used. So 
>>     I don't know whether this can easily be fixed. It works in mintty but 
>>     I think mintty uses different Windows functions.
>>     
> How do you enter any of the control chars ^^, ^\, ^[, ^], ^_ anyway?
> In a CMD window using an english keyboard I can just enter any of them
> using the control char,  C+S+6 = ^^, C+\ = ^\, C+[ = ^[, C+] = ^],
> and C+S+- = ^_.  Same in a cygwin console.  The reason is that these
> sequences return their ASCII value in the INPUT_RECORD in
> Event.KeyEvent.uChar.
>
> Except for one of them, this doesn't work with a german keyboard and
> german keyboard layout.  In this case, the respective keysequences
> C+^, C+AltGr+sz, C+AG+8, C+AG+9 return nothing at all.  Only the
> C+S+- key returns ^_, as expected.
>   
Thanks Andy for pointing to the part of mintty code handling this. 
However, the whole function there looks too complex for a quick 
copy-paste-patch. Maybe later... or Andy might like to factor out the 
mapping part in a way directly reusable for the cygwin console? (Or 
should it be left as is because it's "just the console"...?)

>>   - Pressing something like Alt-ö on a German keyboard leaves an illegal UTF-8 
>>     sequence (the second byte of the respective sequence) in input, apparently 
>>     because Alt-0xC3 is handled somehow. Don't know, though, whether this is 
>>     a cygwin console issue or maybe a readline issue.
>>     
> Alt is converted to a leading ESC.  I don't know how to fix that for
> non-ASCII chars, yet.
>   
For non-ASCII it works fine, thanks to Andy for clarifying; I could have 
checked this myself, even within bash, by simply typing Control-V Alt-ö. 
It does not work however, even for ASCII characters, for characters 
produced with AltGr, e.g. Alt-AltGr-Q where AltGr-Q is @ (German 
keyboard). Andy got this to work in mintty (I think with some other 
subtle trick after I challenged him for it IIRC); it does not work in 
xterm either.

>> * I intended to implement cursor position reports and noticed that their 
>>   request ESC[6n is already handled in the code; it does not work, however, 
>>   so I started to debug it:
>>     
> This needs some more debugging, I guess.
>   
Do you have an opinion about my theory that the wrong read-ahead buffer 
is being filled here (stdout vs. stdin)? If so, I still have no clue how 
to proceed; maybe you'd kindly give a hint how to access the stdin 
buffer / stdin fhandler?

Thanks,
Thomas
