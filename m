Return-Path: <cygwin-patches-return-4464-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25234 invoked by alias); 1 Dec 2003 18:22:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25223 invoked from network); 1 Dec 2003 18:22:37 -0000
Message-ID: <3FCB86E6.8090604@netscape.net>
Date: Mon, 01 Dec 2003 18:22:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]:  Add flock syscall emulation
References: <Pine.CYG.4.58.0311271409240.1064139@reddragon.clemson.edu> <20031129230104.GA6964@cygbert.vinschen.de> <3FCA2F9C.4070207@netscape.net> <20031201102334.GA27760@cygbert.vinschen.de>
In-Reply-To: <20031201102334.GA27760@cygbert.vinschen.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2003-q4/txt/msg00183.txt.bz2

Corinna wrote:
> On Sun, Nov 30, 2003 at 12:57:48PM -0500, Nicholas Wourms wrote:
> 
>>Corinna wrote:
>>
>>>I've run indent on flock.c since its formatting was non-GNU.
>>
>>I can understand why you did it in this case (the tabs were out of 
>>control), but can we make an exception for bsd/isc-derived code?  I 
>>think that enforcing this rule strictly on written-from-scratch source 
>>is ok, but doing it on derived source reduces the overall transparency 
>>of changes against the upstream version.
> 
> 
> I see.  Is that necessary for flock?  It's not BSD derived and will
> not likely need another external update.

Oh, I think I was unclear.  I was trying to say is that I agree with 
your formatting changes to the flock code.  I just wanted to see if I 
could have an exception from this policy in certain cases where the 
source was derived.

> However, we have a problem here, which I just saw when looking into
> the flock code another time.  The newlib defintion of `struct flock'
> isn't 64 bit aware and it doesn't adhere to the SUSv3 definition.  :-(
> It uses 'long' as datatypes for l_start and l_len but these should
> be off_t.

> So we need to define flock32 and flock64 structs and change the fcntl
> interface to accept both.  Sic.

Hmm, I see what you mean.  While I've been mulling over the problem, it 
seems you've already solved it.  Thanks for catching that oversight on 
my part.

Cheers,
Nicholas
