Return-Path: <cygwin-patches-return-3836-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11978 invoked by alias); 29 Apr 2003 18:32:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11953 invoked from network); 29 Apr 2003 18:32:44 -0000
Message-ID: <3EAEC434.2030809@netscape.net>
Date: Tue, 29 Apr 2003 18:32:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: chris@atomice.net
CC: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: Re: hostid patch
References: <LPEHIHGCJOAIPFLADJAHMEIFDJAA.chris@atomice.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00063.txt.bz2

chris@atomice.net wrote:
>>>On Tue, Apr 15, 2003 at 08:55:08PM +0100, Chris January wrote:
>>>
>>>>*Not* tested on anything other than Windows XP.
>>>>
>>>>Adds gethostid function to Cygwin. Three patches: one for 
>>>
>>Cygwin, one for
>>
>>>>newlib and one for w32api.
>>>>If I've done anything wrong let me know and I'll try to fix it.
>>>
>>>I tried this on Windows XP and, when run repeatedly, I get two
>>>different numbers:
>>>
>>>m:\test>gethostid
>>>0xf9926a74
>>>
>>>m:\test>gethostid
>>>0xdfd35415
>>>
>>>The highly sophisticated program that I'm using is below.
>>>
>>>I take it this doesn't happen to you, Chris?
>>
>>Can you send me two strace outputs with different results please?
>>There are debug_printf's all the way through the hostid function 
>>that output
>>the result at each stage and these can be used to identify which value is
>>changing between calls.
> 
> 
> ping...
> 

On WinME, using the hostid sources from coreutils, I'm 
getting consistant results.

Cheers,
Nicholas


