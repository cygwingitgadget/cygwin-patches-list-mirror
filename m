Return-Path: <cygwin-patches-return-4767-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23154 invoked by alias); 16 May 2004 03:58:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23144 invoked from network); 16 May 2004 03:58:07 -0000
Date: Sun, 16 May 2004 03:58:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: c:.
Message-ID: <20040516035807.GA29938@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040515223540.00810100@incoming.verizon.net> <3.0.5.32.20040515223540.00810100@incoming.verizon.net> <3.0.5.32.20040515234018.00804730@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040515234018.00804730@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00119.txt.bz2

On Sat, May 15, 2004 at 11:40:18PM -0400, Pierre A. Humblet wrote:
>At 10:57 PM 5/15/2004 -0400, Christopher Faylor wrote:
>>On Sat, May 15, 2004 at 10:35:40PM -0400, Pierre A. Humblet wrote:
>>>I have run more tests and noticed that c:. and c:..
>>>are now interpreted as c:/
>>>That's because of the new code that strips trailing dots
>>>and spaces. 
>>
>>Shouldn't it be interpreted as c:/?  Since c: is interpreted
>>as c:/, shouldn't c:/.. be interpreted as c:/?
>
>As I am talking about c:. and c:.., not c:/..
>Currently c:. is the current directory of drive c:
>and c:.. is its parent.

Quoting from path.cc:

   Each DOS drive is defined to have a current directory.  Supporting
   this would complicate things so for now things are defined so that
   c: means c:\.

If C: has morphed to being interpreted as the current directory on
C: then that is a regression as far as cygwin is concerned.

I don't see how we could ever get this consistently right on Windows NT
since its shells use some odious environment variable magic to track
what directory is being used on what drive.

cgf
