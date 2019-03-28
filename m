Return-Path: <cygwin-patches-return-9268-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8765 invoked by alias); 28 Mar 2019 22:56:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8748 invoked by uid 89); 28 Mar 2019 22:56:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 22:56:28 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id 9dwfh3Hk7o7SQ9dwghdWOo; Thu, 28 Mar 2019 16:56:27 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
To: cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <87y350ytpb.fsf@Rainer.invalid> <9c38ac1d-4dea-12d4-a63b-6e8ec59b3ae8@ssi-schaefer.com> <0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca> <f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca>
Date: Thu, 28 Mar 2019 22:56:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00078.txt.bz2

On 2019-03-28 10:48, Michael Haubenwallner wrote:
> On 3/28/19 4:19 PM, Brian Inglis wrote:
>> On 2019-03-28 08:59, Michael Haubenwallner wrote:
>>> On 3/27/19 8:59 PM, Achim Gratz wrote:
>>>> Michael Haubenwallner writes:
>>>>> As far as I understand, rebasing is about touching already installed
>>>>> dlls as well, which would require to restart all Cygwin processes.
>>>>> As the problem is about some dll built during a larger build job,
>>>>> this is not something that feels useful to me.
>>>>
>>>> That's exactly why I introduced the "--oblivious" option several years
>>>> ago.  It'll let you rebase a set of DLL while benefitting from the
>>>> rebase database, but not recording them there, so if you later install
>>>> them properly there will be no collision.  I needed this for testing
>>>> newly compiled Perl XS modules, but you seem to have a similar use case.
>>>
>>> What I can see so far is that right now there is only one single rebase
>>> database, in /etc/rebase.db.<arch>.
>>>
>>> However, my 'installed' dlls are not put into /bin, but into the so called
>>> Gentoo "Prefix", e.g. /home/haubi/test-20190327/gentoo-prefix/usr/bin for
>>> example.  Remember that there can be multiple independent instances of Gentoo
>>> Prefix, so recording them all into the host /etc/rebase.db is not an option.
>>>
>>> Hence there should be a rebase database per Gentoo Prefix instance, like
>>> /home/haubi/test-20190327/gentoo-prefix/etc/rebase.db.<arch>, to record
>>> my 'installed' dlls, while still loading the /etc/rebase.db.<arch> to avoid
>>> conflicts with cygwin provided dlls.
>>>
>>> And how would one explicitly remove specific entries from the rebase database
>>> when dlls get uninstalled (by either package remove or package upgrade)?
>>
>> Using rebase -O, --oblivious with -T, --filelist local-test-rebase-db gives you
>> your own local test rebase db - just add all your test dlls into it (sort -u to
>> eliminate dups).
> Sounds interesting... but something I must be doing wrong here:
> $ rebase --oblivious --filelist=my-dlls.txt local-test-rebase-db
> local-test-rebase-db: skipped because nonexistent.
> $ touch local-test-rebase-db
> $ rebase --oblivious --filelist=my-dlls.txt local-test-rebase-db
> local-test-rebase-db: skipped because not rebaseable
> $ cp /etc/rebase.db.x86_64 local-test-rebase-db
> $ rebase --oblivious --filelist=my-dlls.txt local-test-rebase-db
> local-test-rebase-db: skipped because not rebaseable
> It doesn't want to create or update the local-test-rebase-db file...

File list my-dlls.txt is your local test rebase db listing all your test dlls.
If you are packaging your own exes and dlls with your own local Cygwin distro,
you should point to your local utility directory with a path in a file under
/var/lib/rebase/user.d/$USER for each Cygwin userid on each system, or perhaps
you might also need to add your own production exes and dlls into
/var/cache/rebase/rebase_user and /var/cache/rebase/rebase_user_exe: see
/usr/share/doc/Cygwin/_autorebase.README.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.q
