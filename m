Return-Path: <cygwin-patches-return-4769-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17758 invoked by alias); 16 May 2004 22:23:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17734 invoked from network); 16 May 2004 22:23:23 -0000
Message-Id: <3.0.5.32.20040516182015.0081c190@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 16 May 2004 22:23:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: c:.
In-Reply-To: <20040516035807.GA29938@coe.bosbc.com>
References: <3.0.5.32.20040515234018.00804730@incoming.verizon.net>
 <3.0.5.32.20040515223540.00810100@incoming.verizon.net>
 <3.0.5.32.20040515223540.00810100@incoming.verizon.net>
 <3.0.5.32.20040515234018.00804730@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00121.txt.bz2

At 11:58 PM 5/15/2004 -0400, Christopher Faylor wrote:
>On Sat, May 15, 2004 at 11:40:18PM -0400, Pierre A. Humblet wrote:
>>At 10:57 PM 5/15/2004 -0400, Christopher Faylor wrote:
>>>On Sat, May 15, 2004 at 10:35:40PM -0400, Pierre A. Humblet wrote:
>>>>I have run more tests and noticed that c:. and c:..
>>>>are now interpreted as c:/
>>>>That's because of the new code that strips trailing dots
>>>>and spaces. 
>>>
>>>Shouldn't it be interpreted as c:/?  Since c: is interpreted
>>>as c:/, shouldn't c:/.. be interpreted as c:/?
>>
>>As I am talking about c:. and c:.., not c:/..
>>Currently c:. is the current directory of drive c:
>>and c:.. is its parent.
>
>Quoting from path.cc:
>
>   Each DOS drive is defined to have a current directory.  Supporting
>   this would complicate things so for now things are defined so that
>   c: means c:\.

The comment isn't completely accurate. Windows seems to take care of 
maintaining the environment. My previous e-mail showed examples.

>If C: has morphed to being interpreted as the current directory on
>C: then that is a regression as far as cygwin is concerned.

"c:" is still mapped to "c:/"
"c:." and "c:.." are mapped to "c:/" in current cvs only.
   That's the regression.
"c:anything" is passed to Windows "as is" in both 1.5.9 and cvs, 
   except the . and .. cases in cvs

Windows takes care of interpreting the syntax. 

>I don't see how we could ever get this consistently right on Windows NT
>since its shells use some odious environment variable magic to track
>what directory is being used on what drive.

There is a bigger problem: NtCreateFile does not support the format 
c:nodirsep (it's most likely handled by the Windows layer above NT). 
Thus to support it, Cygwin would have to emulate Windows and interact 
with the odious environment variables.
Things such as cd, ls, touch, .. which do not require NtCreateFile,
still work fine in cvs, cat doesn't.
I don't think it's acceptable to have some system calls work while
other fail just because of the filename format.

I see two realistic possibilities on NT:
1) Reject filenames of the form c:nodirsep, except the naked "c:"
or 2) Silently add a / after the :

If we decide on 2), I would apply it to Win9x and NT for uniformity.
If we decide on 1), I would only apply it on NT only (why fail on 9X
if we can succeed?). 
I suspect that some people calling Cygwin programs from the DOS shell
use the form c:nodirsep.

Pierre
