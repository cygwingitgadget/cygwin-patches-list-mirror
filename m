Return-Path: <cygwin-patches-return-3288-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23805 invoked by alias); 8 Dec 2002 02:53:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23796 invoked from network); 8 Dec 2002 02:53:05 -0000
Message-ID: <3DF2B3B3.70208@ece.gatech.edu>
Date: Sat, 07 Dec 2002 18:53:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
References: <3DEB8ABD.80309@ece.gatech.edu> <3DEE0B91.4070208@ece.gatech.edu> <3DF2947F.8010308@ece.gatech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00239.txt.bz2

> On Sat, Dec 07, 2002 at 07:38:23PM -0500, Charles Wilson wrote:
>>So far, no problems.  I'm gonna go on record in favor of this patch, in 
>>its 4th incarnation 
>>(http://cygwin.com/ml/cygwin-patches/2002-q4/msg00222.html).
>>
>>given that winsup/cygwin/lib/getopt.c(*) still retains its BSD licensing 
>>and comments, there's no reason to change the (non-)license/public 
>>domain attribution in egor's pseudo-relocs.c file.  Egor's patch #4 
>>should be able to be committed as-is.

Notice the "should" in this paragraph?

> You know, I don't recall asking for legal opinions.

Now you're just being an asshole.

>  There is absolutely
> no reason why I should trust the legal analysis of anyone who is not a
> lawyer.
> 
> If public domain of Berkeley licensing was a huge win, then I really
> wouldn't be asking anyone to fill out cygwin assignments, would I?

Then why the hell was this version of getopt.c committed to the CVS 
sources in the first place? In version 1.1.4?

>>(*) winsup/cygwin/lib/getopt.c still retains the original 
>>BSD-with-advert license which is explicitly incompatible with the GPL. 
>>And since it is the NetBSD variant, it doesn't fall under the 
>>"rescinded" announcement made by the Berkeley folks:
> 
> Yes, and perhaps you noticed this when I mentioned it in the mingw-dvlpr
> mailing list or perhaps not.

No, I used to read the cygwin lists, never the mingw lists.  Because the 
final writing phase of my dissertation has lasted so long, I've recently 
tried to be a *little* more visible, update a few packages, and answer 
questions/address issues where I think it's worth taking (a little) time 
away from writing.

I guess it was a mistake to let my sense of responsibility for "my" 
packages override, even if only in a small part, my self-interest.  I 
don't need this.

> Regardless, I don't need an education of what kind of licenses are in
> cygwin.  I'm well aware of what's there.

And of course, you are the only person who reads cygwin-patches -- or 
perhaps everyone else who reads cygwin patches has the same 
comprehensive and infallible understanding of the contents of the cygwin 
codebase.  It's just me, the local village idiot, that was surprised to 
see a BSD-with-advert file in there.

> 
>>ftp://ftp.cs.berkeley.edu/pub/4bsd/README.Impt.License.Change
>>
>>(the NetBSD folks are quite clear that they LIKE the advertisement 
>>clause in their license)
>>
>>However, the FreeBSD folks DO abide by the "rescind clause 3" decision; 
>>perhaps we should replace our (modified) getopt.c with a similarly 
>>modified one from FreeBSD?
> 
> There's a conspicuous lack of an IANAL here.  Odd.

As if I needed to say that.  Everybody on this list, including you, 
KNOWS that I'm a Ph.D. student -- I've mentioned it often enough. 
Nobody would ever believe that I was a lawyer -- and you *know* that I'm 
not.  Should I also preface every message on programming by stating that 
I'm not a professional software engineer, even if I give advice on 
software architecture?  It seems that IANAL disclaimers are only really 
necessary on anonymous boards or larger communities without long 
histories of mutual association and knowledge.

In any case, nobody is stupid enough to think ANYTHING on this list 
constitutes an ACTUAL binding legal opinion...

My earlier message conflated two issues.  (1) is that public domain 
sources like egor's could probably be accepted into cygwin's CVS, 
without disturbing Red Hat's dual licensing scheme. (see the "could" in 
that sentence?  similar to the "should" in the sentence above? Both of 
which are indicative of a non-authoritative personal opinion?)  I 
pointed out getopt.c as an example of code that is distributed by Red 
Hat, under that dual license, as part of cygwin, but where the file 
itself contains a different (compatible) license.  Like newlib. 
However, when I noticed issue (2) below, I probably should have split 
the message into two parts, ignored getopt.c entirely, and instead based 
the "compatibility of license" argument on the similarity between

   cgywin(sec.10 GPL) vs. newlib(LGPL,BSDnoadvert,and 7 other free 
licenses),
and
   cygwin(sec.10 GPL) vs. pseudo-relocs(public domain - a "free" license 
according to OSI).

Unfortunately, I THEN noticed that getopt.c was NOT actually a 
compatible license (and as such, muddied the waters).  I pointed out 
that SECOND issue in the same email -- to the detriment of the argument 
w.r.t. issue #1.  Sorry for the confusion.  And I hope the info above 
answers Danny's question.

But I'm out of this thread.  Egor, you're on your own.  Ditto Ralf's ld 
patches.  I'm no longer going to waste my time testing contributions if 
both the contribution and the testing are treated with disdain.

--Chuck
