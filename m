Return-Path: <cygwin-patches-return-4697-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8272 invoked by alias); 21 Apr 2004 14:54:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7935 invoked from network); 21 Apr 2004 14:54:05 -0000
Date: Wed, 21 Apr 2004 14:54:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Recent changes in pthread_create
Message-ID: <20040421145405.GA25134@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <18588.1082531891@www4.gmx.net> <20040421144457.GC21459@coe.bosbc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421144457.GC21459@coe.bosbc.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00049.txt.bz2

On Wed, Apr 21, 2004 at 10:44:57AM -0400, Christopher Faylor wrote:
>On Wed, Apr 21, 2004 at 09:18:11AM +0200, Thomas Pfaff wrote:
>>Date: Thu, 18 Apr 2002 12:11:26 +0200
>>[...]
>>2. The InterlockedIncrement (&MT_INTERFACE->threadcount) in
>>  __pthread_create is misplaced. If the newly created thread terminates
>>  fast enough the threadcount will be decremented before it was
>>  incremented, which will result in an exit from __pthread_exit instead
>>  of an ExitThread.
>>[... ]
>>
>>Same thing will now happen again after your change from CREATE_SUSPENDED to
>>0 in CreateThread.
>
>This was not just a simple change of CREATE_SUSPENDED to 0.
>
>I moved the mutex lock to prevent the thread from terminating before
>pthread::create exits.

Or, more correctly, before pthread::create is finished incrementing the
threadcount.

cgf
