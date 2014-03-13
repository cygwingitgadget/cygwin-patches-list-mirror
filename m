Return-Path: <cygwin-patches-return-7974-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20715 invoked by alias); 13 Mar 2014 10:31:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20701 invoked by uid 89); 13 Mar 2014 10:31:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=2.3 required=5.0 tests=AWL,BAYES_00,FAKE_REPLY_C,SPF_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: shelob.oktetlabs.ru
Received: from shelob.oktetlabs.ru (HELO shelob.oktetlabs.ru) (195.131.132.186) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Thu, 13 Mar 2014 10:31:16 +0000
Received: by shelob.oktetlabs.ru (Postfix, from userid 122)	id 895737F545; Thu, 13 Mar 2014 14:31:11 +0400 (MSK)
Received: from bree.oktetlabs.ru (bree.oktetlabs.ru [192.168.38.213])	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))	(No client certificate requested)	by shelob.oktetlabs.ru (Postfix) with ESMTPS id 336647F427	for <cygwin-patches@cygwin.com>; Thu, 13 Mar 2014 14:31:08 +0400 (MSK)
X-DKIM: Sendmail DKIM Filter v2.8.2 shelob.oktetlabs.ru 336647F427
Authentication-Results: shelob.oktetlabs.ru/336647F427; dkim=none	(no signature) header.i=unknown; dkim-adsp=none
Received: from oleg by bree.oktetlabs.ru with local (Exim 4.80)	(envelope-from <Oleg.Kravtsov@oktetlabs.ru>)	id 1WO2uq-0006Xu-VU	for cygwin-patches@cygwin.com; Thu, 13 Mar 2014 14:31:09 +0400
Date: Thu, 13 Mar 2014 10:31:00 -0000
From: Oleg Kravtsov <Oleg.Kravtsov@oktetlabs.ru>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Fix errno codes set by opendir() in case of problems with the path argument
Message-ID: <20140313103108.GA25153@bree.oktetlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140303193201.GA914@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00047.txt.bz2

On Mon, 3 Mar 2014 14:32:01 -0500, Christopher Faylor wrote:
> On Mon, Mar 03, 2014 at 10:34:59PM +0400, Oleg Kravtsov wrote:
>> Currently cygwin has a problem with errno code set by opendir()
>> function. It always sets errno to ENOENT.
>> After applying the path opendir() sets errno to 'ENAMETOOLONG' when path
>> or a path component is too long,
>> 'ELOOP' when a loop of symbolic links exits in the path.
>>
>> 2014-02-18  Oleg Kravtsov <Oleg.Kravtsov@oktetlabs.ru>
>>
>>        * dir.cc (opendir): Set errno code depending on the type of an error
>>        instead of always setting it to ENOENT.

> Thanks for the patch but I don't see any reason for a goto here.  Also
> you seem to be skipping over a free which could result in a memory leak.
Actually I wanted opendir() to be in sync with other functions (mkdir, rmdir), i.e. use the same style.
There is no memory leak in the proposed patch, but it does not matter, your patch is also a valid one, though not comply the style used in other functions.

> I think the below should do the same thing without those limitations.
Yes, please fix it in a way you think is the most preferable.

> Does it work for you?
Yes, thanks.

Oleg
