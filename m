Return-Path: <cygwin-patches-return-6167-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6654 invoked by alias); 16 Nov 2007 13:40:30 -0000
Received: (qmail 6640 invoked by uid 22791); 16 Nov 2007 13:40:29 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-70-20-17-24.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (70.20.17.24)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 16 Nov 2007 13:40:25 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 0E5572B352; Fri, 16 Nov 2007 08:40:22 -0500 (EST)
Date: Fri, 16 Nov 2007 13:40:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Encode invalid chars in /proc/registry entries
Message-ID: <20071116134022.GA7993@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <473CC0A6.6010409@t-online.de> <20071116110901.GK30894@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071116110901.GK30894@calimero.vinschen.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00019.txt.bz2

On Fri, Nov 16, 2007 at 12:09:01PM +0100, Corinna Vinschen wrote:
>Hi Christian,
>
>On Nov 15 22:56, Christian Franke wrote:
>> Registry key and value names may contain chars which are not allowed within 
>> file names ('/', '\', ":"). But Cygwin's /proc/registry returns these names 
>> unchanged to the app. The obvious effect is that such entries cannot be 
>> accessed.
>>
>> But if an entry name is identical to an existing path, more interesting 
>> results occur. Cygwin itself adds registry entries which are testcases for 
>> this issue :-))
>> [...]
>> The attached patch encodes the critical chars with %XX to avoid such 
>> problems.
>>
>> Patch is tested with 1.5.24-2. Merge with HEAD looks good, but was not 
>> actually tested. Therefore, no changelog provided yet.
>
>Thanks for this patch.  Apart from the missing ChangeLog I'm inclined
>to apply it to the upcoming 1.5.25 release, but I don't like to have it
>in HEAD as is.

I'm not so sure it's appropriate for either yet.

Isn't it possible to use at least some of the managed mode functions
which deal with munging characters to do some of encoding?  It seems
like the patch duplicates some of the functionality from path.cc.

I realize that the registry is sort of the opposite of a managed mount
but it seems like the encoding functions might be potentially used in
reverse for this.

cgf
