Return-Path: <cygwin-patches-return-3326-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13222 invoked by alias); 16 Dec 2002 15:07:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13212 invoked from network); 16 Dec 2002 15:07:42 -0000
Message-ID: <3DFDDE2B.7060202@yahoo.com>
Date: Mon, 16 Dec 2002 07:07:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hartmut Honisch <hartmut_honisch@web.de>
CC:  cygwin-patches@cygwin.com
Subject: Re: Minor additions to winbase.h and ntdll.def
References: <NFBBLLCAILKHOEOHEFMHCEBECEAA.hartmut_honisch@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00277.txt.bz2

Hartmut Honisch wrote:
>>>Winbase.h
>>>- Changed NMPWAIT_WAIT_FOREVER constant from (-1) to 0xffffffff (like in
>>
>>Why?
> 
> 
> I have a piece of own code that passes NMPWAIT_WAIT_FOREVER as a parameter
> to CallNamedPipe. The compiler gave me a warning because the function
> prototype expected a DWORD value which by definition cannot be negative. So
> it's obviously a (minor) bug in cygwin's header files, which I thought the
> cygwin folks might be interested in to fix.
> 

They just happen to be used in Cygwin and just happen to be CVSed in the 
winsup/w32api directory, but the MinGW team maintain them.

> 
>>Looking at Microsoft's header files and making changes to w32api is not
>>allowed.
> 
> 
> Technically, I didn't do it that way. I just mentioned that to avoid
> discussions like that one, since cygwin's headers shouldn't differ from
> Microsoft's headers regarding the value of numeric constants.
> 

Such differences help provide defense to copyright enfringement claims.

> 
>>You'll have to find the MSDN documentation and provide the
>>references.
> 
> 
> There are no references in MSDN that show the numeric value of that
> constant - at least I can't find any. So I wonder how (-1) got there in the
> first place.
> 

Then, your patch can't be accepted.  The foremost prerequisite for 
changes to the w32api is the documentation that warrants the change. 
Here is an example of a proper bug report.

<quote>
Bugs item #653761, was opened at 2002-12-14 17:19
You can respond by visiting:
https://sourceforge.net/tracker/?func=detail&atid=102435&aid=653761&group_id=2435

Category: w32api
Group: None
Status: Open
Resolution: None
Priority: 5
Submitted By: Dimitri Papadopoulos (dimitri_at)
Assigned to: Earnie Boyd (earnie)
Summary: missing CPLPAGE_*

Initial Comment:
Header cplext.h defines only:
CPLPAGE_MOUSE_BUTTONS 1
CPLPAGE_MOUSE_PTRMOTION 2
CPLPAGE_KEYBOARD_SPEED 1

The following are missing from w32api:
CPLPAGE_MOUSE_WHEEL
CPLPAGE_DISPLAY_BACKGROUND

Reference:
http://msdn.microsoft.com/library/en-us/shellcc/platform/shell/programmersguide/shell_int/shell_int_extending/extensionhandlers/propsheethandlers.asp#cpl 

</quote>

Dimitri could have supplied a patch but the information and 
documentation reference are still needed.

Earnie.
