Return-Path: <cygwin-patches-return-6824-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22064 invoked by alias); 9 Nov 2009 16:21:33 -0000
Received: (qmail 22050 invoked by uid 22791); 9 Nov 2009 16:21:29 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.126.186)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 09 Nov 2009 16:21:25 +0000
Received: from [127.0.0.1] (dslb-088-073-156-084.pools.arcor-ip.net [88.73.156.84]) 	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis) 	id 0Le9EG-1MKEjG3QMO-00ppdF; Mon, 09 Nov 2009 17:21:21 +0100
Message-ID: <4AF84166.2080503@towo.net>
Date: Mon, 09 Nov 2009 16:21:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>  <20091106101448.GA2568@calimero.vinschen.de>  <4AF73FEC.2050300@towo.net>  <20091109133551.GA10130@calimero.vinschen.de>  <20091109145458.GB31587@ednor.casa.cgf.cx> <20091109152249.GA12652@calimero.vinschen.de>
In-Reply-To: <20091109152249.GA12652@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00155.txt.bz2

Corinna Vinschen schrieb:
> On Nov  9 09:54, Christopher Faylor wrote:
>   
>> On Mon, Nov 09, 2009 at 02:35:51PM +0100, Corinna Vinschen wrote:
>>     
>>> On Nov 8 23:02, towo@towo.net wrote:
>>>       
>>>> Corinna Vinschen schrieb:
>>>>         
>>> Ooookey, if they aren't listed in terminfo anyway, I have no problems
>>> to change them.  But we should stick to following the Linux console, I
>>> guess.
>>>       
>> I agree.  I'm surprised that we've had the function keys wrong all these
>> years.
>>
>>     
>>>>>> * I intended to implement cursor position reports and noticed that
>>>>>> their request ESC[6n is already handled in the code; it does not work,
>>>>>> however, so I started to debug it:
>>>>>>             
>>>>> This needs some more debugging, I guess.
>>>>>           
>>>> Do you have an opinion about my theory that the wrong read-ahead buffer
>>>> is being filled here (stdout vs.  stdin)?  If so, I still have no clue
>>>> how to proceed; maybe you'd kindly give a hint how to access the stdin
>>>> buffer / stdin fhandler?
>>>>         
>>> I have no opinion yet, since I don't know this part of the code good
>>> enough.  IIUC you think that the readahead buffer of the wrong
>>> fhandle_console is filled, the one connected with stdout, not the one
>>> connected with stdin, right?
>>>       
>> I'm still struggling to understand what a "stdout read-ahead buffer"
>> might be.  Could you point to the place in the code where you see the
>> problem?
>>     
>
> As far as I understand it:
>
>   Application writes ESC [ 6 n to stdout which is connected to one
>   fhandler_console.  Cygwin creates the reply and copies it into the
>   
Yes, see fhandler_console::char_command, case 'n', small_sprintf, then 
puts_readahead (buf);
>   readahead buffer of this very fhandler_console.
Yes, I traced ralen and raixput in fhandler_base::put_readahead (in 
fhandler.cc) and could watch the buffer being filled with e.g. 7 bytes.
>   But that's not the
>   same fhandler_console which is connected to stdin, which is the
>   fhandler the application reads the reply from.
I also traced ralen and raixget in fhandler_base::get_readahead and saw 
the buffer empty immediately after the filling with 7 bytes;
I had also traced other places where ralen could be reset, with no 
occurrence logged between the two traces mentioned.
>   So the reply never
>   makes it to the application.
>   
Thomas
