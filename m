Return-Path: <cygwin-patches-return-4717-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10580 invoked by alias); 6 May 2004 14:58:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10571 invoked from network); 6 May 2004 14:58:30 -0000
Date: Thu, 06 May 2004 14:58:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: chdir
Message-ID: <20040506145830.GA27402@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040505002003.GA8846@coe.bosbc.com> <3.0.5.32.20040504200359.007fcec0@incoming.verizon.net> <20040505002003.GA8846@coe.bosbc.com> <3.0.5.32.20040505004236.007ff280@incoming.verizon.net> <20040505095134.GA6206@cygbert.vinschen.de> <3.0.5.32.20040505235853.00806100@incoming.verizon.net> <20040506094334.GV2201@cygbert.vinschen.de> <20040506123720.GB17511@cygbert.vinschen.de> <409A4505.7868167F@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409A4505.7868167F@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00069.txt.bz2

On Thu, May 06, 2004 at 10:00:37AM -0400, Pierre A. Humblet wrote:
>
>Corinna Vinschen wrote:
>> Ooops:
>> 
>>   $ cd /
>>   /: No such file or directory.
>
>Oops, nothing to do with chdir. It's in the code that detects
>file components consisting entirely of dots or spaces.
>
>Something crossed my mind. Should we allow trailing dots and
>spaces on managed mounts (and encode that)? After all the goal
>is to be fully Unix like there. 

Yes, eventually.  There are lots of things that still need to be
done for managed mounts, though.  Maybe I need to start keeping a list.

cgf
