Return-Path: <cygwin-patches-return-3276-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31059 invoked by alias); 4 Dec 2002 13:40:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30711 invoked from network); 4 Dec 2002 13:40:31 -0000
Message-ID: <3DEE0571.6080703@ece.gatech.edu>
Date: Wed, 04 Dec 2002 05:40:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
References: <3DEB8ABD.80309@ece.gatech.edu> <10868607121.20021203111856@logos-m.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00227.txt.bz2

egor duda wrote:

> CW> OTOH, if you, Egor Duda, do NOT assign ownership to Red Hat, but instead 
> CW> release the code as public domain FIRST, then mingw is free to take it.
> 
> That's what i was meaning.
> 
> CW>   Also, Red Hat is free to take it as well -- but they do not have 
> CW> "ownership" of the code; they simply are using it as they would any 
> CW> other public domain code.  Which means Red Hat has the right to 
> CW> re-release it under their proprietary cygwin license and under the GPL.

And I see that your most recent version was explicitly released into the 
public domain.  As I understand it, this means that both cygwin and 
mingw can take it -- and cygwin is even free to modify the code slightly 
(or not!) and then claim the result as their very very own and stamp it 
with the "This software is released under the Cygwin license blah blah 
see section 10 of the GPL blah blah" stuff, if they want.  As I 
understand it, public domain code is "free" for the stealing.  That's 
why RMS doesn't like public domain, and why the GPL was invented in the 
first place.

> CW> But, I am not sure how your (Egor's) pre-existing "assignment form for 
> CW> continuing contributions" affects this.  Does the assignment kick in 
> CW> automatically, since this was developed against the cygwin source dist?
> 
> Yes, you're right there was such clause in copyright assignment.
> That means that it's up to Redhat to place this code to public domain.

Nope, on second thought, you as the coder have to explicitly 
"contribute" the code (in the sense of posting it for inclusion) AND 
that very same code has to be *accepted* into the cygwin codebase. 
Let's do a thought experiment:

I'm at home, and I whip up some modifications to cygwin.  I never show 
them to anybody. I never distribute the binaries or the code.  Does Red 
Hat own those changes, just because I have one of those letters in a 
filing cabinet somewhere in North Carolina?  Of course not.

Next, assume I publish those changes on the cygwin mailing list.  cgf 
says, "Chuck, that's idiotic -- why would anyone every wnat to do 
something as stupid as your patch?"  and rejects it.  Does Red Hat own 
the code?  Naturally not.  Am I free to go use that same code in some 
other (proprietary) project?  Yes -- assuming my "patch" was a new and 
independent file/function, and not simply an extension of something 
already in cygwin itself -- e.g. my "patch" was not, in itself, a 
derivative work.

Now, if you DO post the code for inclusion AND it is accepted, then 
things are a little fuzzy -- but I think the public domain'ing finesses 
the issue.  You release these changes into the public domain -- and just 
so happen to do that on a cygwin list.  ANYONE is free now to take that 
code, include it in their proprietary product -- and slap a restrictive 
proprietary license on it.

Including Red Hat.

So, Red Hat (e.g. cgf) can take the code and stick it in cygwin -- and 
slap the funny cygwin crossbreed GPL/section 10 license on it.  "This 
file is part of cygwin" and all that.

AND mingw (earnie) is free to take the code and stick it into mingw -- 
and keep the "public domain" status that your originally gave to the code.

No problems.

> Anyway, if there's any problems with that, the code can be easily
> implemented independently. It's not a rocket science, after all.

Doubt any such problems will arise, since you've explicitly labeled the 
code as public domain.

--Chuck
