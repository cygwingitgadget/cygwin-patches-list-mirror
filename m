Return-Path: <cygwin-patches-return-9257-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24617 invoked by alias); 28 Mar 2019 14:59:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24607 invoked by uid 89); 28 Mar 2019 14:59:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=gentoo
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 14:59:30 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 15:59:27 +0100
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1h9WV5-0001OX-ER	for cygwin-patches@cygwin.com; Thu, 28 Mar 2019 15:59:27 +0100
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <87y350ytpb.fsf@Rainer.invalid>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Message-ID: <9c38ac1d-4dea-12d4-a63b-6e8ec59b3ae8@ssi-schaefer.com>
Date: Thu, 28 Mar 2019 14:59:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87y350ytpb.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q1/txt/msg00067.txt.bz2

Hi Achim,

On 3/27/19 8:59 PM, Achim Gratz wrote:
> Michael Haubenwallner writes:
>> As far as I understand, rebasing is about touching already installed
>> dlls as well, which would require to restart all Cygwin processes.
>> As the problem is about some dll built during a larger build job,
>> this is not something that feels useful to me.
> 
> That's exactly why I introduced the "--oblivious" option several years
> ago.  It'll let you rebase a set of DLL while benefitting from the
> rebase database, but not recording them there, so if you later install
> them properly there will be no collision.  I needed this for testing
> newly compiled Perl XS modules, but you seem to have a similar use case.

What I can see so far is that right now there is only one single rebase
database, in /etc/rebase.db.<arch>.

However, my 'installed' dlls are not put into /bin, but into the so called
Gentoo "Prefix", e.g. /home/haubi/test-20190327/gentoo-prefix/usr/bin for
example.  Remember that there can be multiple independent instances of Gentoo
Prefix, so recording them all into the host /etc/rebase.db is not an option.

Hence there should be a rebase database per Gentoo Prefix instance, like
/home/haubi/test-20190327/gentoo-prefix/etc/rebase.db.<arch>, to record
my 'installed' dlls, while still loading the /etc/rebase.db.<arch> to avoid
conflicts with cygwin provided dlls.

And how would one explicitly remove specific entries from the rebase database
when dlls get uninstalled (by either package remove or package upgrade)?

Thanks!
/haubi/
