Return-Path: <cygwin-patches-return-8017-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23805 invoked by alias); 13 Aug 2014 20:20:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23792 invoked by uid 89); 13 Aug 2014 20:20:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: mailout05.t-online.de
Received: from mailout05.t-online.de (HELO mailout05.t-online.de) (194.25.134.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 13 Aug 2014 20:20:13 +0000
Received: from fwd25.aul.t-online.de (fwd25.aul.t-online.de [172.20.26.130])	by mailout05.t-online.de (Postfix) with SMTP id D5BFF301FA8	for <cygwin-patches@cygwin.com>; Wed, 13 Aug 2014 22:20:09 +0200 (CEST)
Received: from [192.168.2.108] (SmSQC6ZCohUvtet4GN7ZTfIAc3bLz9pRlxtdzoysyJ-T-q1IuEhQw6a6neRcgIIZQx@[84.180.70.2]) by fwd25.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-SHA encrypted)	esmtp id 1XHf1h-4RP1u40; Wed, 13 Aug 2014 22:20:05 +0200
Message-ID: <53EBC873.2020904@t-online.de>
Date: Wed, 13 Aug 2014 20:20:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0 SeaMonkey/2.26.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck -m, --check-mtimes option
References: <53E3DE5D.10302@t-online.de> <20140808103139.GX13601@calimero.vinschen.de> <20140808125135.GA13601@calimero.vinschen.de>
In-Reply-To: <20140808125135.GA13601@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q3/txt/msg00012.txt.bz2

Hi Corinna,

Corinna Vinschen wrote:
> On Aug  8 12:31, Corinna Vinschen wrote:
>> Hi Christian,
>>
>> On Aug  7 22:15, Christian Franke wrote:
>>> Attached is an experimental patch which adds -m, --check-mtimes[=SECONDS]
>>> option to cygcheck. It provides an IMO useful heuristics to find files
>>> possibly modified after installation.
>>>
>>> "cygcheck -c -m" prints the number of files with st_mtime >
>>> INSTALL_TIME+SECONDS. INSTALL_TIME is the st_mtime of the
>>> /etc/setup/PACKAGE.lst.gz file.
>>>
>>> With -v, the affected path names are printed. The optional parameter SECONDS
>>> defaults to 600 to hide files modified by postinstall scripts.
>> That's an interesting idea.  I just gave it a try.  I think this might
>> be useful,
> On second thought, the modification date isn't very meaningful all by
> itself, is it?  In theory it's only meaningful if the file has changed
> as well.

That's why I called it "heuristics" :-)


>    Consider, what is the user supposed to do with the information
> that the file modification date has changed?  Where does the user go
> from there?

The info is IMO useful to find changed config files, forgotten hot fixed 
scripts or other files you possibly want to save before a package is 
updated.

It also sometimes exposes package collisions (e.g. libgnutls26/28 
provide different versions of cyggnutls-openssl-27.dll or libsasl2/2_3 
provide different version of /usr/sbin/saslauthd).


> So I'm wondering if the st_mtime check isn't just a starting
> point for a test for a file change.  OTOH, we have a problem there.
> The rudimentary package database in /etc/setup is not very helpful.
> It only contains filenames, but no other information on the files.
>
> What would be really cool:  Setup generates the package info files in
> /etc/setup with additional file size and md5 (sha1, sha256, you name it)
> checksum.  Then cygcheck could test if st_mtime, st_size and the
> checksum match.  Or, in a first step, just store and check the file
> size.

Yes, this is an obvious missing feature of the Cygwin package 
management. I didn't suggest it because my open source spare time is too 
limited to implement it :-)

Christian
