Return-Path: <cygwin-patches-return-5090-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26550 invoked by alias); 27 Oct 2004 16:48:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26490 invoked from network); 27 Oct 2004 16:48:41 -0000
Received: from unknown (HELO smartmx-02.inode.at) (213.229.60.34)
  by sourceware.org with SMTP; 27 Oct 2004 16:48:41 -0000
Received: from [62.99.252.218] (port=63716 helo=[192.168.0.2])
	by smartmx-02.inode.at with esmtp (Exim 4.30)
	id 1CMqyV-00069F-Of
	for cygwin-patches@cygwin.com; Wed, 27 Oct 2004 18:48:40 +0200
Message-ID: <417FD162.4060806@x-ray.at>
Date: Wed, 27 Oct 2004 16:48:00 -0000
From: Reini Urban <rurban@x-ray.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8a3) Gecko/20040817
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: sync(3)
References: <417F09A1.4090003@x-ray.at> <20041027145621.GJ24504@trixie.casa.cgf.cx> <417FBFA3.5040605@x-ray.at> <20041027154330.GK24504@trixie.casa.cgf.cx>
In-Reply-To: <20041027154330.GK24504@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00091.txt.bz2

Christopher Faylor schrieb:
> On Wed, Oct 27, 2004 at 05:32:51PM +0200, Reini Urban wrote:
>>Christopher Faylor schrieb:
>>>On Wed, Oct 27, 2004 at 04:36:17AM +0200, Reini Urban wrote:
>>>>Why is this a bad idea?
>>>
>>>It's a very limited implementation of what sync is supposed to do but
>>>maybe it's better than nothing.
>>>
>>>A slightly more robust method would be to implement an internal cygwin
>>>signal which could be sent to every cygwin process telling it to run
>>>code like the below.
>>
>>A signal looks better.
>>Maybe just to its master process, and all its subprocesses and threads?
> 
> I don't know what you mean by the master process.  

the parent of some subprocesses.
exim or postgres or apache1 open a farm of subprocesses, which 
eventually might want to sync() logfiles or mboxes.

> It's easy to send signals to every cygwin process. You don't have to worry about threads.

good.

my private coverage:
   time find /usr/src -name \*.c -exec grep -H sync \{\} \;
so far is unsuccessful.
The examples I found (exim, postgresql, uw-imap) all use fsync() (of 
course). apache doesn't use fsync/sync (logs) at all.

But I didn't check the more likely candidates, perl/python/... or simple 
small servers yet.
-- 
Reini Urban
http://xarch.tu-graz.ac.at/home/rurban/
