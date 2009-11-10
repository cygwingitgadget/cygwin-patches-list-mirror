Return-Path: <cygwin-patches-return-6825-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16967 invoked by alias); 10 Nov 2009 16:47:59 -0000
Received: (qmail 16947 invoked by uid 22791); 10 Nov 2009 16:47:58 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.126.186)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 10 Nov 2009 16:47:52 +0000
Received: from [127.0.0.1] (dslb-088-073-050-136.pools.arcor-ip.net [88.73.50.136]) 	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis) 	id 0LwmRY-1M1e3w2i5Y-016bK8; Tue, 10 Nov 2009 17:47:49 +0100
Message-ID: <4AF99932.5090702@towo.net>
Date: Tue, 10 Nov 2009 16:47:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Subject: Re: console enhancements: mouse events
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>  <20091106101448.GA2568@calimero.vinschen.de>  <4AF73FEC.2050300@towo.net> <20091109133551.GA10130@calimero.vinschen.de>
In-Reply-To: <20091109133551.GA10130@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00156.txt.bz2

Corinna Vinschen schrieb:
>>>>  - Pressing something like Alt-ö on a German keyboard leaves an
>>>> illegal UTF-8     sequence (the second byte of the respective
>>>> sequence) in input, apparently     because Alt-0xC3 is handled
>>>> somehow. Don't know, though, whether this is     a cygwin
>>>> console issue or maybe a readline issue.
>>>>         
>>> Alt is converted to a leading ESC.  I don't know how to fix that for
>>> non-ASCII chars, yet.
>>>       
>> For non-ASCII it works fine, thanks to Andy for clarifying; I could
>>     
>
> Erm... sorry, but do we really talk about the same?  If you press
> Alt-ö, the console generates the sequence ESC 0xc3 0xb6.  That's not
> desired so I'm contemplating the idea to skip the keypress if the
> resulting multibyte char is > 1 byte.  This restricts ESC-somekey
> either to explicit function key sequences (ESC-[-foo, etc), or
> to just two byte sequences like ESC-A, ESC-0, ESC-;, etc.
>   
I had not expected you to take action on this issue so soon:
> - Don't create ESC sequences for ALT-key keypresses if key translates
>   into a multibyte sequence.  This avoids stray bytes in input when
>   pressing for instance ALT-&ouml; (Umlaut-o) under UTF-8.
>   
- especially given:
> ...  And, whatever
> super-duper change we make to this essential console code in future,
> let's wait until after 1.7.1, please.
>   
Actually, I think this is the wrong change. I'm sorry I came up with 
this confusion because I didn't test sufficiently, but as I said in my 
second mail
> For non-ASCII it works fine,
and contemplating again
> If you press Alt-ö, the console generates the sequence ESC 0xc3 0xb6.
I think this is absolutely the right thing to generate - after all, what 
else should be expected here?
The "stray bytes" are created in bash/readline, the previous behavior of 
cygwin console in this case was perfect, I'd suggest to revert, please.

Thomas
