Return-Path: <cygwin-patches-return-4621-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29238 invoked by alias); 23 Mar 2004 01:12:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29228 invoked from network); 23 Mar 2004 01:12:58 -0000
Message-ID: <405F8F15.40409@netscape.net>
Date: Tue, 23 Mar 2004 01:12:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
MIME-Version: 1.0
To: matt@use.net
CC: Pierre.Humblet@ieee.org, cygwin-patches@cygwin.com
Subject: Re: [Patch]: Win95
References: <405EF9F4.A97FF863@phumblet.no-ip.org> <20040322185405.GA3266@redhat.com> <405F4530.F3188C94@phumblet.no-ip.org> <024901c4104b$d266a370$640aa8c0@esp>
In-Reply-To: <024901c4104b$d266a370$640aa8c0@esp>
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2004-q1/txt/msg00111.txt.bz2

matt wrote:

>>Can you believe that the address appears 5 times on the stack on Win95,
>>twice on ME, once on NT4.0?
>>
>>Now that the method is stable (after 1.5.10 is released), couldn't we
> 
> store
> 
>>the offsets in wincap, keeping the adaptive method as a backup in the
>>unknown case? Or are there many variations?
> 
> 
> I can tell you from the perspective of writing shellcode and rootkits on
> windows that assuming offsets will be the same is not a good idea if you are
> going for something that is to be widely deployed. Not only can they vary
> between service packs/patches, but also between language editions of the OS.
> 

What would you suggest doing instead?

Cheers,
Nicholas
