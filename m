Return-Path: <cygwin-patches-return-5444-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14255 invoked by alias); 11 May 2005 01:33:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14237 invoked from network); 11 May 2005 01:33:45 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.140.130)
  by sourceware.org with SMTP; 11 May 2005 01:33:45 -0000
Received: from [192.168.1.10] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.50)
	id IGAXKB-00034K-3L; Tue, 10 May 2005 21:31:23 -0400
Message-Id: <3.0.5.32.20050510213122.00b4b658@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 11 May 2005 01:33:00 -0000
To: ericblake@comcast.net (Eric Blake),cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: mkdir -p and network drives
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2005-q2/txt/msg00040.txt.bz2

At 01:27 AM 5/11/2005 +0000, Eric Blake wrote:
>> At 11:11 AM 5/10/2005 -0400, Christopher Faylor wrote:
>> 
>> So I restrained mkdir to only act on FH_FS.
>> 
>> Ideally mkdir & rmdir should be part of the various handlers, but
>> there is no current payoff in doing so as directories can only be
>> created/deleted on FH_FS 
>
>Would it ever be possible (or desirable) to let /proc/registry be writable
as a means of creating registry keys (mkdir) and values (creat)?  

Yes IMO, and that day we will need to distribute {mk, rm}dir to the handlers.
There doesn't seem to be much demand for that however, people seem happy with
regtool.

Pierre
