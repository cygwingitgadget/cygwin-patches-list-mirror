Return-Path: <cygwin-patches-return-8530-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2314 invoked by alias); 1 Apr 2016 13:13:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2293 invoked by uid 89); 1 Apr 2016 13:13:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=H*Ad:U*yselkowitz, H*M:cygwin, H*F:U*yselkowitz, H*MI:sk:2016040
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 01 Apr 2016 13:12:54 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 7088480510	for <cygwin-patches@cygwin.com>; Fri,  1 Apr 2016 13:12:53 +0000 (UTC)
Received: from [10.10.116.17] (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u31DCpBe007995	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 1 Apr 2016 09:12:53 -0400
Subject: Re: [PATCH v2] Refactor to avoid nonnull checks on "this" pointer.
To: cygwin-patches@cygwin.com
References: <1459441102-19941-1-git-send-email-pefoley2@pefoley.com> <20160401121318.GA16660@calimero.vinschen.de>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <56FE73D7.8030306@cygwin.com>
Date: Fri, 01 Apr 2016 13:13:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160401121318.GA16660@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00005.txt.bz2

On 2016-04-01 07:13, Corinna Vinschen wrote:
> On Mar 31 12:18, Peter Foley wrote:
>> G++ 6.0 asserts that the "this" pointer is non-null for member functions.
>> Refactor methods that check if this is non-null to be static where
>> necessary, and remove the check where it is unnecessary.
>
> No, sorry, but now.  Converting all affected functions to static
> functions just because this might be null is much too intrusive for my
> taste.  *If* that's really a problem going forward, I'd rather see the
> pointer test moved into the caller.  But don't waste your time on a
> patch yet.
>
> Let's please take a step back and look at what happens.  So, here's the
> question:  What error message does G++ 6 generate in case of an `if
> (this)' test in a member function, and why on earth should it care and
> do that?

See https://gcc.gnu.org/gcc-6/porting_to.html, section named 
"Optimizations remove null pointer checks for this".

-- 
Yaakov
