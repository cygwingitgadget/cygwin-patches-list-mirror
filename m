Return-Path: <cygwin-patches-return-4605-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26364 invoked by alias); 12 Mar 2004 23:08:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26346 invoked from network); 12 Mar 2004 23:08:15 -0000
Date: Fri, 12 Mar 2004 23:08:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for /proc/meminfo handler
Message-ID: <20040312230813.GA29678@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <A065B7C9B0648F4F8C43388D0D699F8D1DBEEC@ZABRYSVCL21EX01.af.didata.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A065B7C9B0648F4F8C43388D0D699F8D1DBEEC@ZABRYSVCL21EX01.af.didata.local>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q1/txt/msg00095.txt.bz2

On Mar 12 15:14, Andrew Klopper wrote:
> With the Cygwin 1.5.7-1 DLL, 'cat /proc/meminfo' returns an incorrect
> value for free swap space. This is most noticeable when the free virtual
> memory is less than the total physical memory, in which case the
> calculated free swap space is a negative value. This value is then
> converted to an unsigned int for display purposes, resulting in a very
> large positive number which is greater than the total amount of swap
> space.
> 
> A patch to correct this problem is attached.

Well, that doesn't look right after applying your patch:

  $ cat /proc/meminfo
	   total:      used:      free:
  Mem:   536330240  230658048  305672192
  Swap:  770961408 4245790720  820137984
  MemTotal:         523760 kB
  MemFree:          298508 kB
  [...]
  SwapTotal:        752892 kB
  SwapFree:         800916 kB

The result using the original version looks much better:

  $ cat /proc/meminfo
	   total:      used:      free:
  Mem:   536330240  231788544  304541696
  Swap:  770961408  182104064  588857344
  MemTotal:         523760 kB
  MemFree:          297404 kB
  [...]
  SwapTotal:        752892 kB
  SwapFree:         575056 kB

So, perhaps both are wrong?

Please don't send patches uuencoded or in any other encoded or compressed
way.  Just add it as plain text, inline or attached.  And all patches
need a ChangeLog entry.  Have a look onto http://cygwin.com/contrib.html
which explains it thoroughly.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
