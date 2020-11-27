Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 756CE3972464
 for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2020 09:56:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 756CE3972464
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 0AR9u6qV058678
 for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2020 01:56:06 -0800 (PST)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpdh9zklX; Fri Nov 27 01:56:02 2020
Subject: Re: [PATCH] Cygwin: Speed up mkimport
To: cygwin-patches@cygwin.com
References: <20201126095620.38808-1-mark@maxrnd.com>
 <87wny76eur.fsf@Rainer.invalid>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <ee4d7296-e9b3-13c8-cc15-f2e393b42e6f@maxrnd.com>
Date: Fri, 27 Nov 2020 01:56:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <87wny76eur.fsf@Rainer.invalid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Fri, 27 Nov 2020 09:56:11 -0000

Achim Gratz wrote:
> Mark Geisert writes:
>> +	    # Do two objcopy calls at once to avoid one system() call overhead
>> +	    system '(', $objcopy, '-R', '.text', $f, ')', '||',
>> +		$objcopy, '-R', '.bss', '-R', '.data', "t-$f" and exit 1;
> 
> That doesn't do what you think it does.  It in fact increases the
> overhead since it'll start a shell that runs those two commands sand
> will even needlessly start the first objcopy in a subshell.

Still faster than two system commands :-).  But thanks for the comment; I thought 
I was merely grouping args, to get around Perl's greedy arg list building for the 
system command.  After more experimenting I ended up with:
             system '/bin/true', '||', $objcopy, '-R', '.text', $f, '||',
                 $objcopy, '-R', '.bss', '-R', '.data', "t-$f" and exit 1;
Kind of ugly, but better?  It obviates the need for parent to pace itself so the 
enclosing loop runs a bit faster.

..mark
