Return-Path: <cygwin-patches-return-4021-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25149 invoked by alias); 18 Jul 2003 17:10:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25124 invoked from network); 18 Jul 2003 17:10:55 -0000
Date: Fri, 18 Jul 2003 17:10:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: setmetamode
Message-ID: <20030718171054.GC1621@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <s1sznjdk5sg.fsf@jaist.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s1sznjdk5sg.fsf@jaist.ac.jp>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00037.txt.bz2

On Thu, Jul 17, 2003 at 03:48:15PM +0900, Kazuhiro Fujieda wrote:
> I have implemented the `setmetamode' command and the corresponding
> ioctl commands of the console device like ones on Linux.
> The following is the usage of setmetamode.
> 
> $ setmetamode
> escprefix
> $ cat | od -t x1
>                               <- Type M-x three times, ^m and ^d.
> 0000000 1b 78 1b 78 1b 78 0d 0a
> 0000010
> $ setmetamode metabit
> $ cat | od -t x1
>                               <- Type M-x three times, ^m and ^d.
> 0000000 f8 f8 f8 0d 0a
> 0000005

Doesn't work.  I've tested multiple times (on XP) but I'm always getting

  0000000 1b 78 1b 78 1b 78 0d 0a

Another question: Shouldn't this also add a sys/kd.h file which just
includes <cygwin/kd.h>?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
