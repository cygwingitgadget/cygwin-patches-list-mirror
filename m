Return-Path: <cygwin-patches-return-3751-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12578 invoked by alias); 27 Mar 2003 05:05:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12568 invoked from network); 27 Mar 2003 05:05:45 -0000
Date: Thu, 27 Mar 2003 05:05:00 -0000
From: Pavel Tsekov <ptsekov@gmx.net>
X-X-Sender: ptsekov@moria.atlanticsky.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] performance patch for /proc/registry -- version 2
In-Reply-To: <20030326202213.GZ23762@cygbert.vinschen.de>
Message-ID: <Pine.LNX.4.44.0303270540001.2604-100000@moria.atlanticsky.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00400.txt.bz2

On Wed, 26 Mar 2003, Corinna Vinschen wrote:

> However... am I doing something wrong?  I'm trying to find out what the
> performance improvement is on my XP box and both versions of the DLL
> (w/ and w/o your patch) are running 7.5 minutes for 
> 
>   ls -lR /proc/registry > /dev/null
> 
> Or is that only a problem on older systems?  You're running NT4SP5, right?

Joe wrote on cygwin-developers:

"On an NT machine running SP5, an "ls -l" on
/proc/registry/HKEY_LOCAL_MACHINE/SYSTEM/CurrentControlSet/Services
returns in 0.25 seconds now.  Without the patch, I killed it after
7 minutes because I got tired of waiting for it to finish."

The differences is that you use ls -lR. I have debugged a slowdown 
problem with /proc/registry back in June 2002:

http://sources.redhat.com/ml/cygwin/2002-06/msg00103.html
http://sources.redhat.com/ml/cygwin/2002-06/msg00188.html

I don't remember anyone fixing this so I guess this is what causes the 
slowdown on your machine.
