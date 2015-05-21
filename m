Return-Path: <cygwin-patches-return-8140-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 110904 invoked by alias); 21 May 2015 23:44:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 110893 invoked by uid 89); 21 May 2015 23:44:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=2.7 required=5.0 tests=AWL,BAYES_50,FREEMAIL_FROM,KAM_COUK,SPF_PASS autolearn=no version=3.3.2
X-HELO: out.ipsmtp2nec.opaltelecom.net
Received: from out.ipsmtp2nec.opaltelecom.net (HELO out.ipsmtp2nec.opaltelecom.net) (62.24.202.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (CAMELLIA256-SHA encrypted) ESMTPS; Thu, 21 May 2015 23:44:17 +0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CWAQCebF5V/z1e0lUNT8xbgkkKAoIPAQEBAQEBhS4BAQQ4QBELGAkWDwkDAgECAUUTCAEBtiqlAwEBAQcBAQEBHos6hQwWhBcBBJA+jmuOGodbgQSBBYITgzUBAQE
X-IPAS-Result: A2CWAQCebF5V/z1e0lUNT8xbgkkKAoIPAQEBAQEBhS4BAQQ4QBELGAkWDwkDAgECAUUTCAEBtiqlAwEBAQcBAQEBHos6hQwWhBcBBJA+jmuOGodbgQSBBYITgzUBAQE
Received: from 85-210-94-61.dynamic.dsl.as9105.com (HELO [127.0.0.1]) ([85.210.94.61])  by out.ipsmtp2nec.opaltelecom.net with ESMTP; 22 May 2015 00:44:14 +0100
Message-ID: <555E6DCB.5080005@tiscali.co.uk>
Date: Thu, 21 May 2015 23:44:00 -0000
From: David Stacey <drstacey@tiscali.co.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Update the estimate of the size of installing everything
References: <1432226663-19744-1-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1432226663-19744-1-git-send-email-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2015-q2/txt/msg00041.txt.bz2

On 21/05/2015 17:44, Jon TURNEY wrote:
> Update the estimate of the size of installing everything from "hundreds of
> megabytes" to "tens of gigabytes", just in case someone should think it's a
> good idea with contemporary hard disk sizes:)

Slightly off topic, but I can give you some real numbers if you're 
interested: x86_64 is the larger of the two installs, weighing in at 
44.45 GB with just over 750,000 files - and growing all the time. 
Obviously, that's not installed on an SSD...

Dave.

