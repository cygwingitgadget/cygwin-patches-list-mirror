Return-Path: <cygwin-patches-return-9314-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 72403 invoked by alias); 9 Apr 2019 09:00:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 72394 invoked by uid 89); 9 Apr 2019 09:00:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=mails, facing
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 09 Apr 2019 09:00:36 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 11:00:28 +0200
Received: from [172.28.53.60]	by mailhost.salomon.at with esmtps (UNKNOWN:AES128-SHA:128)	(Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hDmcG-0002ZW-Lb; Tue, 09 Apr 2019 11:00:28 +0200
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <87y350ytpb.fsf@Rainer.invalid> <9c38ac1d-4dea-12d4-a63b-6e8ec59b3ae8@ssi-schaefer.com> <0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca> <f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com> <abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca> <87sgv65eyc.fsf@Rainer.invalid> <5fa27e1c-a790-f03d-b4b3-1985f26df128@SystematicSw.ab.ca> <87pnq9jupk.fsf@Rainer.invalid> <a83dedc6-ea5b-5fc9-4bbc-f06a9cf19472@SystematicSw.ab.ca> <878sww93g9.fsf@Rainer.invalid> <97aec921-d9b1-3b0e-de7a-d492832ba481@SystematicSw.ab.ca> <236d3269-1b0b-9da0-9816-ed84e489f73e@ssi-schaefer.com> <87ef6jmfwv.fsf@Rainer.invalid> <437a6a24-4428-ad14-f6bb-16ff23679c30@ssi-schaefer.com> <87mul0zanq.fsf@Rainer.invalid>
To: cygwin-patches@cygwin.com
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <9f8ccdae-1198-b414-dc5d-52823b86721c@ssi-schaefer.com>
Date: Tue, 09 Apr 2019 09:00:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87mul0zanq.fsf@Rainer.invalid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00021.txt.bz2

On 4/8/19 7:09 PM, Achim Gratz wrote:
> Michael Haubenwallner writes:
>> Well... once installed, a dll may get in use quickly, because I can not require
>> to shut down all Cygwin processes.  So I need to rebase and register the dll in
>> some staging directory before it is installed into it's final directory, hence
>>  I'm about to add some new '--destdir' option.
> 
> I don't quite understand yet what you're trying to do and why, but
> "--destdir" doesn't have the right ring to it for my ears.  If I'm not
> mistaken you want to strip the staging prefix from the database entry,
> which incidentally would be where a
> 
> make DESTDIR=/staging install
> 
> would have placed the files?

Exactly, the _rebase_ needs to be done while the files are in /staging,
but the database records need to not have the /staging part of course.
However, updating the _database_ can be done either while the files are
in /staging still, or when they are at their final location later on.
I just need to avoid performing a rebase to files in their final location.

For the moment, I'm doing the database update together with performing the
rebase in /staging, so I need to tell rebase.exe about "/staging" to strip
from the database record.  This boils down to:
$ find /staging -type f -name '*.dll' > files.list
$ rebase --database --filelist=files.list --destdir=/staging

But I'm facing some fork problems now, where I need to investigate whether
they're related to my rebase step, before I can submit the patches.

If curious, see https://github.com/haubi/cygwin-rebase/commits/gentoo

Thanks!
/haubi/
PS: I've tried to submit the first two patches yesterday, but somehow the
mails didn't make it to the list.
