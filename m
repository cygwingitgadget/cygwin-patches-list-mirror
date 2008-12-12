Return-Path: <cygwin-patches-return-6385-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31804 invoked by alias); 12 Dec 2008 15:18:23 -0000
Received: (qmail 31750 invoked by uid 22791); 12 Dec 2008 15:18:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 12 Dec 2008 15:17:39 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id E00D36D4356; Fri, 12 Dec 2008 16:20:00 +0100 (CET)
Date: Fri, 12 Dec 2008 15:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may 	crash  find)
Message-ID: <20081212152000.GA32492@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49384250.7080707@t-online.de> <20081205095742.GP12905@calimero.vinschen.de> <4939A9F7.1000400@t-online.de> <20081207171802.GV12905@calimero.vinschen.de> <493C1DF7.6090905@t-online.de> <20081208114800.GW12905@calimero.vinschen.de> <20081208115433.GX12905@calimero.vinschen.de> <49417625.4030209@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49417625.4030209@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00029.txt.bz2

On Dec 11 21:20, Christian Franke wrote:
> Corinna Vinschen wrote:
>>
>> Oh, btw.
>>
>> I was wondering if you would be not too disgusted by the idea to add
>> some documentation about this change to the Cygwin User's Guide.
>> There's already some blurb in pathnames.sgml about the /proc/registry
>> access.  Currently it lacks a description of the entire % handling.
>> Maybe it would be helpful to break out an entire (small) section for the
>> /proc/registry access...
>>
>>   
>
>
> 2008-12-11  Christian Franke  <franke@computer.org>
>
> 	* pathnames.sgml: New section for /proc/registry. Document registry
> 	name encoding.

Cool, thank you!  Patch applied.

Here's a question which occured to me when reading the doc after I had
applied it.  There's apparently still a problem which is, how do you
read the default value of a key if a value called '@' exists?  Do you
have an idea for a simple solution?


Thanks again,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
