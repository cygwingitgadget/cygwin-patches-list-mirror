Return-Path: <cygwin-patches-return-3748-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7124 invoked by alias); 26 Mar 2003 21:47:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7105 invoked from network); 26 Mar 2003 21:47:27 -0000
Message-ID: <3E821FEE.2000408@hekimian.com>
Date: Wed, 26 Mar 2003 21:47:00 -0000
X-Sybari-Trust: 1b4c2b77 36b09be0 04609a3e 00000109
From: Joe Buehler <jbuehler@hekimian.com>
Reply-To:  jbuehler@hekimian.com
Organization: Spirent Communications, Inc.
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] performance patch for /proc/registry -- version 2
References: <LPEHIHGCJOAIPFLADJAHAEHODHAA.chris@atomice.net> <3E820411.1020100@hekimian.com> <20030326202213.GZ23762@cygbert.vinschen.de>
In-Reply-To: <20030326202213.GZ23762@cygbert.vinschen.de>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00397.txt.bz2

Corinna Vinschen wrote:

> However... am I doing something wrong?  I'm trying to find out what the
> performance improvement is on my XP box and both versions of the DLL
> (w/ and w/o your patch) are running 7.5 minutes for 
> 
>   ls -lR /proc/registry > /dev/null
> 
> Or is that only a problem on older systems?  You're running NT4SP5, right?
> 
> Other than that your patch looks fine.

It may be that XP has the WIN32 API fixed.  The different is drastic
on my NT4 SP5 box.  You can see the difference just by doing
ls -l /proc/registry/HKEY_LOCAL_MACHINE.  With patch comes back instantly,
without you have to sit and wait.
-- 
Joe Buehler
