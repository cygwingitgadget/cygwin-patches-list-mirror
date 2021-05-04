Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-046.btinternet.com (mailomta23-re.btinternet.com
 [213.120.69.116])
 by sourceware.org (Postfix) with ESMTPS id 3AB3E398B172
 for <cygwin-patches@cygwin.com>; Tue,  4 May 2021 18:13:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3AB3E398B172
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
 by re-prd-fep-046.btinternet.com with ESMTP id
 <20210504181352.ODCR21941.re-prd-fep-046.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Tue, 4 May 2021 19:13:52 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C5063186D902
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvdefiedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeguefhkedvfeeigefhhedtjeehieegtdehhffhheffgfehheegtdffleejteeuueenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (81.153.98.246) by
 re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C5063186D902 for cygwin-patches@cygwin.com;
 Tue, 4 May 2021 19:13:52 +0100
Subject: Re: [PATCH] Use automake (v5)
To: cygwin-patches@cygwin.com
References: <20210420201326.4876-1-jon.turney@dronecode.org.uk>
 <d4964f52-518e-205b-c44f-02bea6a225d6@dronecode.org.uk>
 <YI/Tx0ryd7qhMhos@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <c9c3c819-0c35-a65a-136b-aab1a0d15ff0@dronecode.org.uk>
Date: Tue, 4 May 2021 19:12:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YI/Tx0ryd7qhMhos@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.3 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 04 May 2021 18:13:56 -0000

On 03/05/2021 11:43, Corinna Vinschen wrote:
> On May  2 16:28, Jon Turney wrote:
>> On 20/04/2021 21:13, Jon Turney wrote:
>>> For ease of reviewing, this patch doesn't contain changes to generated
>>> files which would be made by running ./autogen.sh.
>>
>> Some possible items of future work I noted:
>>
>> * Documentation is now always built (rather than dangerously ignoring any
>> errors)
>>
>> Although this is half-arsed at the moment, as we don't require the
>> documentation tools at configure time, we'll just fail when the rules are
>> executed if they are missing.
>>
>> Perhaps there should be explicit configuration to build documentation or
>> not?
> 
> `make doc'?

Yeah, that's probably the right thing to do.

[...]
>> * 'make our include directories absolute so we don't have to worry about
>> making them relative to the subdirectory we happen to be building in' is
>> sufficiently obscure that it at least deserves a comment.
> 
> I'm not sure I understand... -v, please?

Yeah, that's why it needs comment :)

realdirpath() in winsup/configure.ac makes paths absolute (and canonical)

Therefore we can use things set with it (AC_CYGWIN_INCLUDES, 
target_builddir, winsup_srcdir) in Makefile.am in arbitrarily deep 
subdirectories, and things just happen to work (which wouldn't be the 
case if they contained relative paths)

It's all a hangover from when it used to be even more complex (see 
commit 39e8d907), and looking at this again, this could probably be 
cleaned-up some more (perhaps using $top_builddir, $top_srcdir?).
