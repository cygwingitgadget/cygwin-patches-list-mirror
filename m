Return-Path: <cygwin-patches-return-4324-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19551 invoked by alias); 29 Oct 2003 15:59:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19542 invoked from network); 29 Oct 2003 15:59:06 -0000
Message-ID: <3F9FE3C5.9050505@netscape.net>
Date: Wed, 29 Oct 2003 15:59:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@sources.redhat.com
Subject: Re: Add PAGE_SIZE, PAGE_SHIFT, PAGE_MASK to sys/param.h
References: <3F9F1C5B.2050501@netscape.net> <20031029093534.GB22720@cygbert.vinschen.de>
In-Reply-To: <20031029093534.GB22720@cygbert.vinschen.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2003-q4/txt/msg00043.txt.bz2

cygwin-patches@cygwin.com wrote:
[SNIP]
>>2003-10-28  Nicholas Wourms  <nwourms@netscape.net>
>>
>>    * include/sys/param.h: Define some page counting macros.
>>    (PAGE_SHIFT): Define.
>>    (PAGE_SIZE): Define.
>>    (PAGE_MASK): Define.
>>    Tidy tab/whitespace formatting from last patch.
> 
> 
> Sorry, but I have several problems with this patch:
> 
> - The formatting of the ChangeLog entry (no TABS).

That proves my later concerns, as I did put TABS in the ChangeLog entry. 
  Unfortunately, this was a bug in Mozilla about the time NS-7.1 was 
released against that code base (Those on the LKML will recall the 
problems ppl had with Mozilla stripping tabs).  See my later comments on 
this.

> - The ChangeLog and your above description are missing the fact, that
>   you also added a NBPW definition.

D'oh, sorry I forgot about that one.

> - The definition of PAGE_MASK is... a problem.  Your definition is the
>   BSD definition (PAGE_SIZE-1), while Linux defines it as the negation
>   thereof, (~(PAGE_SIZE-1)).  I don't know what way to follow here.
>   I guess it's all one, considering that we don't use it in Cygwin so
>   far.  While we once decided that, if SUSv3 fails to lend us a hand,
>   we would try to map the Linux behaviour, the sys/param.h file is
>   a header for mostly BSD definitions.

I know, but I couldn't find this defined like that in any other OS.  I 
felt guilty enough by casting the bitvector, I was worried about be 
"accused" of stealing GPL'ed code.  Thus I thought it better to stick 
with the BSD definition.  Interestingly enough, Wine's 
`memory/virtual.c' has `PAGE_SHIFT' defined to `12' and PAGE_MASK 
defined to 0xfff or 4095 (4096-1).  log2(4096) gives a float answer of 
12.  Also Doug Lea's malloc defines PAGE_MASK as (PAGE_SIZE-1) and then 
negates it where necessary.  OTOH, I found that dlltool from 
binutils-2.7 used to define it as a negation.  Since you are more of an 
expert on mmap then I, I'll leave it others to decide.  If you want to 
leave it out for now, that would be ok, too.  Primarily, I was after 
PAGE_SHIFT & PAGE_SIZE but decided to add PAGE_MASK since it was 
clustered with the others in all the headers I looked at.

> - Neither BSD nor Linux define these highly machine dependent values
>   in sys/param.h.  What about adding a asm/param.h file and include
>   that in sys/param.h?

I wasn't sure what to do, so if you think asm/param.h is better, that 
will be fine.  Of course bsd/linux has it in a machine dependent asm 
dirs, so now that I think about it that would make sense.

> - Don't attach gzipped patches, please.  Mozilla doesn't scramble
>   text attachments, AFAIK.

Unfortunately, as stated previously, it seems that NS-7.1 does.  I have 
to use this to read my netscape mail if I don't want to use the web 
interface.  However, I'll resend the patch with your suggested 
improvements using pine to see if that works.

Cheers,
Nicholas
