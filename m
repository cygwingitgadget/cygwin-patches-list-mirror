Return-Path: <cygwin-patches-return-3285-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13719 invoked by alias); 8 Dec 2002 01:43:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13710 invoked from network); 8 Dec 2002 01:43:36 -0000
Date: Sat, 07 Dec 2002 17:43:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
Message-ID: <20021208014438.GB10595@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DEB8ABD.80309@ece.gatech.edu> <3DEE0B91.4070208@ece.gatech.edu> <3DF2947F.8010308@ece.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF2947F.8010308@ece.gatech.edu>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00236.txt.bz2

On Sat, Dec 07, 2002 at 07:38:23PM -0500, Charles Wilson wrote:
>Charles Wilson wrote:
>
>>I've tested Egor's patch and it seems to work just fine, as demonstrated 
>>by the two test cases he posted last week, AND as demonstrated by the 
>>test case posted to the binutils list some months ago (it tested 
>>pseudo-reloc behavior in the child after a fork).
>>
>>I've also tested Egor's runtime reloc support with Ralf's binutils "use 
>>the DLL as the import lib" and it ALSO works fine in all three cases.
>>
>>I'm going to continue using ld.exe-ralf and 
>>cygwin1.dll-egor/libcygwin.a-egor for my day-to-day use, just to see if 
>>something wacky crops up...
>[snip]
>>On balance, I agree that #1 is the best option.  Unless I run afoul of 
>>some unforseen wackiness in the next few days, recommend inclusion as is 
>>(in the most recent iteration, e.g. no cygwin.sc changes)
>
>So far, no problems.  I'm gonna go on record in favor of this patch, in 
>its 4th incarnation 
>(http://cygwin.com/ml/cygwin-patches/2002-q4/msg00222.html).
>
>given that winsup/cygwin/lib/getopt.c(*) still retains its BSD licensing 
>and comments, there's no reason to change the (non-)license/public 
>domain attribution in egor's pseudo-relocs.c file.  Egor's patch #4 
>should be able to be committed as-is.

You know, I don't recall asking for legal opinions.  There is absolutely
no reason why I should trust the legal analysis of anyone who is not a
lawyer.

If public domain of Berkeley licensing was a huge win, then I really
wouldn't be asking anyone to fill out cygwin assignments, would I?

>(*) winsup/cygwin/lib/getopt.c still retains the original 
>BSD-with-advert license which is explicitly incompatible with the GPL. 
>And since it is the NetBSD variant, it doesn't fall under the 
>"rescinded" announcement made by the Berkeley folks:

Yes, and perhaps you noticed this when I mentioned it in the mingw-dvlpr
mailing list or perhaps not.

Regardless, I don't need an education of what kind of licenses are in
cygwin.  I'm well aware of what's there.

>ftp://ftp.cs.berkeley.edu/pub/4bsd/README.Impt.License.Change
>
>(the NetBSD folks are quite clear that they LIKE the advertisement 
>clause in their license)
>
>However, the FreeBSD folks DO abide by the "rescind clause 3" decision; 
>perhaps we should replace our (modified) getopt.c with a similarly 
>modified one from FreeBSD?

There's a conspicuous lack of an IANAL here.  Odd.

cgf
