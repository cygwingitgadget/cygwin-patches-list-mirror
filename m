From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: preliminary patch for incorporating internationalizing facilities
Date: Wed, 28 Jun 2000 15:16:00 -0000
Message-id: <20000628181636.A24412@cygnus.com>
References: <s1sr99ho8cf.fsf@jaist.ac.jp> <395A676F.F78E67A6@cygnus.com> <20000628171354.A31411@cygnus.com> <s1sn1k5o3t6.fsf@jaist.ac.jp>
X-SW-Source: 2000-q2/msg00120.html

On Thu, Jun 29, 2000 at 07:09:57AM +0900, Kazuhiro Fujieda wrote:
>>>> On Wed, 28 Jun 2000 17:13:54 -0400
>>>> Chris Faylor <cgf@cygnus.com> said:
>
>> I don't understand the reason for using strtol rather than
>> atoi either.
>
>I have no reasonable reason.  The current implementation of
>strtol uses locale-depend macros. I wanted to check where strtol
>was used in Cygwin correctly before I dealt with this problem.
>`atoi' disturbed my work at the time, so I hated it and replaced
>it with `strtol'.

Hmm.  Well I don't like the thought of changing something to use
three arguments and a (possibly) slower method of conversion unless
it is really necessary.

cgf
