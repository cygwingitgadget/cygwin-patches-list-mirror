Return-Path: <cygwin-patches-return-3284-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 668 invoked by alias); 8 Dec 2002 00:39:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 653 invoked from network); 8 Dec 2002 00:39:56 -0000
Message-ID: <3DF2947F.8010308@ece.gatech.edu>
Date: Sat, 07 Dec 2002 16:39:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
References: <3DEB8ABD.80309@ece.gatech.edu> <3DEE0B91.4070208@ece.gatech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00235.txt.bz2

Charles Wilson wrote:

> I've tested Egor's patch and it seems to work just fine, as demonstrated 
> by the two test cases he posted last week, AND as demonstrated by the 
> test case posted to the binutils list some months ago (it tested 
> pseudo-reloc behavior in the child after a fork).
> 
> I've also tested Egor's runtime reloc support with Ralf's binutils "use 
> the DLL as the import lib" and it ALSO works fine in all three cases.
> 
> I'm going to continue using ld.exe-ralf and 
> cygwin1.dll-egor/libcygwin.a-egor for my day-to-day use, just to see if 
> something wacky crops up...
[snip]
> On balance, I agree that #1 is the best option.  Unless I run afoul of 
> some unforseen wackiness in the next few days, recommend inclusion as is 
> (in the most recent iteration, e.g. no cygwin.sc changes)

So far, no problems.  I'm gonna go on record in favor of this patch, in 
its 4th incarnation 
(http://cygwin.com/ml/cygwin-patches/2002-q4/msg00222.html).

given that winsup/cygwin/lib/getopt.c(*) still retains its BSD licensing 
and comments, there's no reason to change the (non-)license/public 
domain attribution in egor's pseudo-relocs.c file.  Egor's patch #4 
should be able to be committed as-is.

--Chuck

(*) winsup/cygwin/lib/getopt.c still retains the original 
BSD-with-advert license which is explicitly incompatible with the GPL. 
And since it is the NetBSD variant, it doesn't fall under the 
"rescinded" announcement made by the Berkeley folks:

ftp://ftp.cs.berkeley.edu/pub/4bsd/README.Impt.License.Change

(the NetBSD folks are quite clear that they LIKE the advertisement 
clause in their license)

However, the FreeBSD folks DO abide by the "rescind clause 3" decision; 
perhaps we should replace our (modified) getopt.c with a similarly 
modified one from FreeBSD?

