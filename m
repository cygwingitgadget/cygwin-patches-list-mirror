Return-Path: <cygwin-patches-return-4766-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11474 invoked by alias); 16 May 2004 03:43:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11465 invoked from network); 16 May 2004 03:43:23 -0000
Message-Id: <3.0.5.32.20040515234018.00804730@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 16 May 2004 03:43:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: c:.
In-Reply-To: <20040516025750.GA24317@coe.bosbc.com>
References: <3.0.5.32.20040515223540.00810100@incoming.verizon.net>
 <3.0.5.32.20040515223540.00810100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00118.txt.bz2

At 10:57 PM 5/15/2004 -0400, Christopher Faylor wrote:
>On Sat, May 15, 2004 at 10:35:40PM -0400, Pierre A. Humblet wrote:
>>I have run more tests and noticed that c:. and c:..
>>are now interpreted as c:/
>>That's because of the new code that strips trailing dots
>>and spaces. 
>
>Shouldn't it be interpreted as c:/?  Since c: is interpreted
>as c:/, shouldn't c:/.. be interpreted as c:/?

As I am talking about c:. and c:.., not c:/..
Currently c:. is the current directory of drive c:
and c:.. is its parent.

$ cd e:.
$ /bin/pwd
/e/PROGRA~1/CYGNUS/SRC/WINSUP/CYGWIN
$ cd c:.
$ /bin/pwd
/c/HOME/PIERRE
$ cd e:..
$ /bin/pwd
/e/PROGRA~1/CYGNUS/SRC/WINSUP

You raise yet another point with c:/..
It doesn't exist for Windows, but both 1.5.9 and current cvs
map it to c:/

Pierre
