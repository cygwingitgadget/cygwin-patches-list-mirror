Return-Path: <cygwin-patches-return-4771-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19426 invoked by alias); 17 May 2004 02:06:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18877 invoked from network); 17 May 2004 02:06:50 -0000
Date: Mon, 17 May 2004 02:06:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: c:.
Message-ID: <20040517020649.GA12550@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040515234018.00804730@incoming.verizon.net> <3.0.5.32.20040515223540.00810100@incoming.verizon.net> <3.0.5.32.20040515223540.00810100@incoming.verizon.net> <3.0.5.32.20040515234018.00804730@incoming.verizon.net> <3.0.5.32.20040516182015.0081c190@incoming.verizon.net> <20040517005837.GA11668@coe.bosbc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517005837.GA11668@coe.bosbc.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00123.txt.bz2

On Sun, May 16, 2004 at 08:58:37PM -0400, Christopher Faylor wrote:
>On Sun, May 16, 2004 at 06:20:15PM -0400, Pierre A. Humblet wrote:
>>At 11:58 PM 5/15/2004 -0400, Christopher Faylor wrote:
>>>On Sat, May 15, 2004 at 11:40:18PM -0400, Pierre A. Humblet wrote:
>>>>At 10:57 PM 5/15/2004 -0400, Christopher Faylor wrote:
>>>>>On Sat, May 15, 2004 at 10:35:40PM -0400, Pierre A. Humblet wrote:
>>>>>>I have run more tests and noticed that c:. and c:..
>>>>>>are now interpreted as c:/
>>>>>>That's because of the new code that strips trailing dots
>>>>>>and spaces. 
>>>>>
>>>>>Shouldn't it be interpreted as c:/?  Since c: is interpreted
>>>>>as c:/, shouldn't c:/.. be interpreted as c:/?
>>>>
>>>>As I am talking about c:. and c:.., not c:/..
>>>>Currently c:. is the current directory of drive c:
>>>>and c:.. is its parent.
>>>
>>>Quoting from path.cc:
>>>
>>>   Each DOS drive is defined to have a current directory.  Supporting
>>>   this would complicate things so for now things are defined so that
>>>   c: means c:\.
>>
>>The comment isn't completely accurate. Windows seems to take care of 
>>maintaining the environment. My previous e-mail showed examples.
>
>Windows 9x does.  Windows NT doesn't.  You can confuse Windows NT if you
>try.
>
>c:\>cd \tmp\bob
>c:\>m:
>m:\>bash
>bash$ env - bash
>bash$ ls m:..
>This "incorrectly" displays the root drive of c: .  So, again, previous
>versions were wrong.  c:.  and c:..  should be interpreted as c:\.

Sorry, that should be "ls c:..".

cgf
