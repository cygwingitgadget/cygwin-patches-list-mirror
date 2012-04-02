Return-Path: <cygwin-patches-return-7635-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5108 invoked by alias); 2 Apr 2012 20:41:18 -0000
Received: (qmail 5094 invoked by uid 22791); 2 Apr 2012 20:41:16 -0000
X-SWARE-Spam-Status: No, hits=-1.4 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SARE_SUB_NEED_REPLY
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 02 Apr 2012 20:40:46 +0000
Received: from pool-98-110-186-28.bstnma.fios.verizon.net ([98.110.186.28] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1SEo3R-0003mm-Fp	for cygwin-patches@cygwin.com; Mon, 02 Apr 2012 20:40:45 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id E212F13C076	for <cygwin-patches@cygwin.com>; Mon,  2 Apr 2012 16:40:44 -0400 (EDT)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+wZOj2Cl/ejsOhOb0xyCpt
Date: Mon, 02 Apr 2012 20:41:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console: new mouse modes, request/response attempt
Message-ID: <20120402204044.GA13667@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4F79F407.9000700@towo.net> <20120402185035.GA9912@ednor.casa.cgf.cx> <4F7A02F9.8000300@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F7A02F9.8000300@towo.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q2/txt/msg00004.txt.bz2

On Mon, Apr 02, 2012 at 09:50:17PM +0200, Thomas Wolff wrote:
>Am 02.04.2012 20:50, schrieb Christopher Faylor:
>> On Mon, Apr 02, 2012 at 08:46:31PM +0200, Thomas Wolff wrote:
>>> This patch includes 2 things (to be fixed and separated anyway; change
>>> log still missing) for discussion:
>>> * mouse modes 6 and 15 (numeric mouse coordinates)
>>> * semi-fix for missing terminal status responses
>>> The fix tries to detect the proper fhandler for CONIO, which is then
>>> used to queue the response.
>>> Problem 1: I am not sure whether this detection is proper in all cases,
>>> what e.g. if /dev/tty is reopened etc. I don't know where else a
>>> relation between the handles for CONIN and CONOUT might be established.
>>> Problem 2: While the response reaches the application with this patch,
>>> only the first byte is read right-away. Further bytes are delayed until
>>> other input is becoming present (typing a key). This may (or may not) be
>>> related to other issues with select(), so maybe it's worth analyzing it.
>>>
>>> Thomas
>>> diff -rup sav/fhandler.h ./fhandler.h
>>> --- sav/fhandler.h	2012-04-01 19:46:04.000000000 +0200
>>> +++ ./fhandler.h	2012-04-02 15:47:22.385727000 +0200
>>> @@ -1282,8 +1282,11 @@ class dev_console
>>>
>>>    bool insert_mode;
>>>    int use_mouse;
>>> +  bool ext_mouse_mode6;
>>> +  bool ext_mouse_mode15;
>>>    bool use_focus;
>>>    bool raw_win32_keyboard_mode;
>>> +  fhandler_console * fh_tty;
>>>
>>>    inline UINT get_console_cp ();
>>>    DWORD con_to_str (char *d, int dlen, WCHAR w);
>>> diff -rup sav/fhandler_console.cc ./fhandler_console.cc
>>> --- sav/fhandler_console.cc	2012-04-02 00:28:55.000000000 +0200
>>> +++ ./fhandler_console.cc	2012-04-02 18:02:26.004016200 +0200
>>> @@ -139,6 +139,8 @@ fhandler_console::set_unit ()
>>>    if (shared_console_info)
>>>      {
>>>        fh_devices this_unit = dev ();
>>> +      if (this_unit == FH_TTY)
>>> +	dev_state.fh_tty = this;
>> You *definitely* just can't squirrel away a pointer to a random fhandler
>> here.
>Not sure what exactly you mean. Is "== FH_TTY" a random selection? I 
>traced (again) that during setup of cygwin there are 80 fhandler objects 
>created. Only one of them matches this criteria (and none the others, 
>e.g. "== FH_CONIO". So I made a guess, and as I said, it works, kind of...

`this' is a pointer to a fhandler.  You can't just store it in a static
location and use it whenever you want later.  You have no idea how long
this fhandler will be around.  What happens if it's destroyed?

>> Do we really care about console mode that much now that mintty is the
>> default?
>
>Maybe not, but the fact that it works partially but subsequent
>characters are postponed resembles the other problem that I have just reported
>tocygwin@cygwin.com, which makes me wonder whether there is one common problem.
>
>
>Also when I originally tweaked the mouse code, I couldn't completely 
>understand the code in select.cc (only got it to work by pattern 
>matching code...). I did notice, however, that select and read were 
>inconsistent in the sense that an application having called select() 
>with a positive response may not be able to get a byte with a subsequent 
>read(), because criteria were re-evaluated and could have different 
>results (esp. in border cases). I did fix it by strictly applying the 
>same guard routine for both cases, but only for the mouse code branch.

If you have an example of actual failing code then please post it.

cgf
