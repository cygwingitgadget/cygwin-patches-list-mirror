Return-Path: <cygwin-patches-return-5089-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7834 invoked by alias); 27 Oct 2004 15:43:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7816 invoked from network); 27 Oct 2004 15:43:24 -0000
Date: Wed, 27 Oct 2004 15:43:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: sync(3)
Message-ID: <20041027154330.GK24504@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <417F09A1.4090003@x-ray.at> <20041027145621.GJ24504@trixie.casa.cgf.cx> <417FBFA3.5040605@x-ray.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417FBFA3.5040605@x-ray.at>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00090.txt.bz2

On Wed, Oct 27, 2004 at 05:32:51PM +0200, Reini Urban wrote:
>Christopher Faylor schrieb:
>>On Wed, Oct 27, 2004 at 04:36:17AM +0200, Reini Urban wrote:
>>
>>>Why is this a bad idea?
>>
>>It's a very limited implementation of what sync is supposed to do but
>>maybe it's better than nothing.
>>
>>A slightly more robust method would be to implement an internal cygwin
>>signal which could be sent to every cygwin process telling it to run
>>code like the below.
>
>A signal looks better.
>Maybe just to its master process, and all its subprocesses and threads?

I don't know what you mean by the master process.  It's easy to send signals
to every cygwin process.  You don't have to worry about threads.

cgf
