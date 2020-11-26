Return-Path: <Stromeko@nexgo.de>
Received: from vsmx009.vodafonemail.xion.oxcs.net
 (vsmx009.vodafonemail.xion.oxcs.net [153.92.174.87])
 by sourceware.org (Postfix) with ESMTPS id D892F3971C61
 for <cygwin-patches@cygwin.com>; Thu, 26 Nov 2020 20:30:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D892F3971C61
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Stromeko@nexgo.de
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])
 by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 86247159DF8C
 for <cygwin-patches@cygwin.com>; Thu, 26 Nov 2020 20:30:09 +0000 (UTC)
Received: from Gertrud (unknown [84.160.202.5])
 by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 5DF45159DF3D
 for <cygwin-patches@cygwin.com>; Thu, 26 Nov 2020 20:30:07 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Speed up mkimport
References: <20201126095620.38808-1-mark@maxrnd.com>
Date: Thu, 26 Nov 2020 21:30:04 +0100
In-Reply-To: <20201126095620.38808-1-mark@maxrnd.com> (Mark Geisert's message
 of "Thu, 26 Nov 2020 01:56:20 -0800")
Message-ID: <87wny76eur.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-VADE-STATUS: LEGIT
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 26 Nov 2020 20:30:12 -0000

Mark Geisert writes:
> +	    # Do two objcopy calls at once to avoid one system() call overhead
> +	    system '(', $objcopy, '-R', '.text', $f, ')', '||',
> +		$objcopy, '-R', '.bss', '-R', '.data', "t-$f" and exit 1;

That doesn't do what you think it does.  It in fact increases the
overhead since it'll start a shell that runs those two commands sand
will even needlessly start the first objcopy in a subshell.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf rackAttack:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
