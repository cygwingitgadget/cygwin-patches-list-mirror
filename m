Return-Path: <cygwin-patches-return-2315-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13424 invoked by alias); 5 Jun 2002 15:01:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13409 invoked from network); 5 Jun 2002 15:01:54 -0000
Date: Wed, 05 Jun 2002 08:01:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] minor pthread fixes
Message-ID: <20020605150207.GE15167@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020605150912.X30892@cygbert.vinschen.de> <016901c20c92$b4288c70$0200a8c0@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016901c20c92$b4288c70$0200a8c0@lifelesswks>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00298.txt.bz2

On Wed, Jun 05, 2002 at 11:12:53PM +1000, Robert Collins wrote:
>
>
>> -----Original Message-----
>> From: cygwin-patches-owner@cygwin.com 
>> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Corinna Vinschen
>> Sent: Wednesday, 5 June 2002 11:09 PM
>> To: cygwin-patches@cygwin.com
>> Subject: Re: [PATCH] minor pthread fixes
>> 
>> 
>> On Wed, Jun 05, 2002 at 10:44:54PM +1000, Robert Collins wrote:
>> > Ok, Chris, whats the guideline in nuber-of-line before we need an
>> > assignment? Do I need to back out this patch (it's very few 
>> lines, just
>> > spread over a few functions).
>> 
>> I'm not Chris, sorry
>
>That's ok, you being a RedHat employee and all :}.
>
>> , but the answer is basically something below
>> 10 changed lines is treated as "nonsignificant".  There's no hard
>> rule, though.  Basically, if a change is not only fixing a bug but
>> introduces new functionality, it's a "significant" patch, even if
>> it's changing less than 10 lines.
>
>Hmm. I'll look carefully at the remaining patches to see if there is new
>functionality or just bugfixes. The current one should be fine though
>IMO.

It sounds like it is ok.  I trust your judgement, on this, Robert.

I'm willing to put the patch in the sources on a promise of an assignment
being forthcoming, too.  I just won't pull the sources into our internal
repository until I get the assignment.

If Thomas wants to send me, via private email, a scanned, signed copy of
the assignment form that would be great, too.

cgf
