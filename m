Return-Path: <cygwin-patches-return-4073-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11095 invoked by alias); 12 Aug 2003 22:55:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11014 invoked from network); 12 Aug 2003 22:55:36 -0000
Message-ID: <3F39704F.6030001@netscape.net>
Date: Tue, 12 Aug 2003 22:55:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-developers@cygwin.com
CC: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Questions and a RFC [was Re: Assignment from Nicholas Wourms arrived]
References: <20030812191411.GH17051@cygbert.vinschen.de>
In-Reply-To: <20030812191411.GH17051@cygbert.vinschen.de>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2003-q3/txt/msg00089.txt.bz2

cygwin-patches@cygwin.com wrote:
> FYI,
> 
> your copyright assignment form has been received by Red Hat.  Patch away!
> 
> Any outstanding issues besides argz/envz?
> 

Not yet, I've got a few things I'd like to contribute to newlib first.

However, I do have a few questions...

1)Did my MUA strip the tabs from the patch?  The only reason I ask is 
because I had formatted the code with tabs and now it looks like they 
were all converted to spaces.  [BTW, sorry about NBBY, I had been 
meaning to send a follow up since I realized that I forgot that I had it 
globally defined in another header :-(].

2)I assume that my assignment covers me for Newlib contributions?

3)I'm still trying to figure out how to use lstat in newlib source code, 
  since apparently the function declaration is hidden when building 
newlib/cygwin.  So far, any attempt to use it results in undefined 
references to _lstat when linking the dll.  I tried adding a definition 
to _syslist.h, but that didn't work.  I hate to sound clueless, but if 
someone could nudge me toward the right header or magic, that would be 
great.

4)Corinna, I've been working on porting some of the missing 
SUSv3/c99/bsd functions from the *bsd libc.  I noticed that the libutil 
which you distribute with inetutils contains some of the functions I 
thought belonged in libc, or at least the headers of newlib would have 
me believe this.  Specifically, I was wanted to work on adding instances of:
endusershell()
setusershell()
getusershell()
ruserok()
iruserok()

Why would I want to do this you ask?  Well some of the specific 
implementations of the other code I'm tying to port use these functions. 
  I suppose I could just use internal, static versions, but these 
functions really ought to be reusable and in sync with the global 
header.  Do you have any objections to this, provided you find my code 
sound?

5)This is meant as a general RFC based on something I noticed while 
researching the freebsd libc.

What would people think about adding another member to the FILE 
structure which would allow for future additions without 
incompatibilities?  I noticed that freebsd has addressed their growing 
FILE ABI by using adding a new member struct, *_extra, to allow for 
additional members without causing incompatibilities.  As I was working 
on porting fwide(), I ran across this feature in freebsd.  Here's how 
it's done:

In the public header, stdio.h:
------------------------------
struct __sFILEX;
...
typedef struct __sFILE {
...
    int (*_write)(void *, const char *, int);

    /* separate buffer for long sequences of ungetc() */
    struct  __sbuf _ub; /*ungetc buffer */
    struct __sFILEX *_extra; /*additions to FILE to not break ABI*/
         ^^^^^^^^^^^^^^^^^^^^^^^^
    int _ur;        /*saved _r when _r is counting ungetc*/
...
};
------------------------------

Then from private header, local.h, located in the stdio/ dir:
-------------------------------------------------------------
struct __sFILEX {
    unsigned char   *_up; /*saved _p when _p is doing ungetc data*/
    pthread_mutex_t fl_mutex;   /* used for MT-safety */
    pthread_t   fl_owner;   /* current owner */
    int     fl_count;   /* recursive lock count */
    int     orientation;    /* orientation for fwide() */
#ifdef notdef
    /*
     * XXX These are not used yet -- they will be used to store the
     * multibyte conversion state for writing and reading when
     * stateful encodings are supported by the locale framework.
     */
    mbstate_t   wstate;     /* write conversion state */
    mbstate_t   rstate;     /* read conversion state */
#endif
};
-------------------------------------------------------------

Planning ahead for future possibilities is always a good thing, so in 
that respect this seems like a sound idea.  Since we are already dealing 
with ABI breakage, I thought I'd float this now to see what people 
think.  Would a change like this be of benefit to Cygwin?

Cheers,
Nicholas
