Return-Path: <cygwin-patches-return-7637-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27143 invoked by alias); 3 Apr 2012 19:52:23 -0000
Received: (qmail 27132 invoked by uid 22791); 3 Apr 2012 19:52:21 -0000
X-SWARE-Spam-Status: No, hits=-2.8 required=5.0	tests=AWL,BAYES_00,KHOP_THREADED,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SARE_SUB_NEED_REPLY,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.17.9)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 03 Apr 2012 19:52:08 +0000
Received: from [127.0.0.1] (dslb-088-073-037-163.pools.arcor-ip.net [88.73.37.163])	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)	id 0MRvbR-1RmG593azh-00TWSc; Tue, 03 Apr 2012 21:52:07 +0200
Message-ID: <4F7B54E1.9070105@towo.net>
Date: Tue, 03 Apr 2012 19:52:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console: new mouse modes, request/response attempt
References: <4F79F407.9000700@towo.net> <20120402185035.GA9912@ednor.casa.cgf.cx> <4F7A02F9.8000300@towo.net> <20120402204044.GA13667@ednor.casa.cgf.cx>
In-Reply-To: <20120402204044.GA13667@ednor.casa.cgf.cx>
X-TagToolbar-Keys: D20120403215201428
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
X-SW-Source: 2012-q2/txt/msg00006.txt.bz2

Am 02.04.2012 22:40, schrieb Christopher Faylor:
> On Mon, Apr 02, 2012 at 09:50:17PM +0200, Thomas Wolff wrote:
>> Am 02.04.2012 20:50, schrieb Christopher Faylor:
>>> On Mon, Apr 02, 2012 at 08:46:31PM +0200, Thomas Wolff wrote:
>>>> ...
>>>> * semi-fix for missing terminal status responses
>>>> The fix tries to detect the proper fhandler for CONIO, which is then
>>>> used to queue the response.
>>>> Problem 1: I am not sure whether this detection is proper in all cases,
>>>> what e.g. if /dev/tty is reopened etc. I don't know where else a
>>>> relation between the handles for CONIN and CONOUT might be established.
>>>> Problem 2: While the response reaches the application with this patch,
>>>> only the first byte is read right-away. Further bytes are delayed until
>>>> other input is becoming present (typing a key). This may (or may not) be
>>>> related to other issues with select(), so maybe it's worth analyzing it.
>>>>
>>>> Thomas
>>>> diff -rup sav/fhandler.h ./fhandler.h
>>>> --- sav/fhandler.h	2012-04-01 19:46:04.000000000 +0200
>>>> +++ ./fhandler.h	2012-04-02 15:47:22.385727000 +0200
>>>> @@ -1282,8 +1282,11 @@ class dev_console
>>>>
>>>>     bool insert_mode;
>>>>     int use_mouse;
>>>> +  bool ext_mouse_mode6;
>>>> +  bool ext_mouse_mode15;
>>>>     bool use_focus;
>>>>     bool raw_win32_keyboard_mode;
>>>> +  fhandler_console * fh_tty;
>>>>
>>>>     inline UINT get_console_cp ();
>>>>     DWORD con_to_str (char *d, int dlen, WCHAR w);
>>>> diff -rup sav/fhandler_console.cc ./fhandler_console.cc
>>>> --- sav/fhandler_console.cc	2012-04-02 00:28:55.000000000 +0200
>>>> +++ ./fhandler_console.cc	2012-04-02 18:02:26.004016200 +0200
>>>> @@ -139,6 +139,8 @@ fhandler_console::set_unit ()
>>>>     if (shared_console_info)
>>>>       {
>>>>         fh_devices this_unit = dev ();
>>>> +      if (this_unit == FH_TTY)
>>>> +	dev_state.fh_tty = this;
>>> You *definitely* just can't squirrel away a pointer to a random fhandler
>>> here.
>> ...
> `this' is a pointer to a fhandler.  You can't just store it in a static
> location and use it whenever you want later.  You have no idea how long
> this fhandler will be around.  What happens if it's destroyed?
Yes, that's why I mentioned problem 1 above. The patch is experimental, 
and it revealed that even if the missing relation could be properly 
established, there's still the other problem... (see below).
>>> Do we really care about console mode that much now that mintty is the
>>> default?
>> Maybe not, but the fact that it works partially but subsequent
>> characters are postponed resembles the other problem that I have just reported
>> tocygwin@cygwin.com, which makes me wonder whether there is one common problem.
>>
>>
>> Also when I originally tweaked the mouse code, I couldn't completely
>> understand the code in select.cc (only got it to work by pattern
>> matching code...). I did notice, however, that select and read were
>> inconsistent in the sense that an application having called select()
>> with a positive response may not be able to get a byte with a subsequent
>> read(), because criteria were re-evaluated and could have different
>> results (esp. in border cases). I did fix it by strictly applying the
>> same guard routine for both cases, but only for the mouse code branch.
> If you have an example of actual failing code then please post it.
My point is: The function that doesn't work here, 
puts_readahead/put_readahead,
is also called in fhandler_pty_master::accept_input () (fhandler_tty.cc)
and in fhandler_termios::line_edit () (fhandler_termios.cc),
and I remember pipe and/or pty problems being discussed recently.
Also there is the "input delay issue" in mintty/xterm I described (and 
by the way, I forgot to mention it does not happen anymore in the 
terminal after rlogin to another system) and somehow I suspect they 
might have a common cause, or similar causes.
------
Thomas
