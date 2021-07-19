Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id B4D7C3855011
 for <cygwin-patches@cygwin.com>; Mon, 19 Jul 2021 10:05:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B4D7C3855011
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mi2BV-1lRhjX2EE5-00e8uR; Mon, 19 Jul 2021 12:04:42 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5C949A80EFD; Mon, 19 Jul 2021 12:04:39 +0200 (CEST)
Date: Mon, 19 Jul 2021 12:04:39 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com, Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH 1/3] Cygwin: New tool: profiler
Message-ID: <YPVON/D5dvOYFwfU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com,
 Jon TURNEY <jon.turney@dronecode.org.uk>
References: <20210716044957.5298-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210716044957.5298-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:Bp6F5C52FIhDJO4W+Gf/5Yoz1MCALHmCd8Mwu71d6SCxatOalp+
 nsphPZTd0ugun5McwCU0HpExko83NRjtQFVzSGWVxcLYl1XhYBnqJ2ZTn9wuPkWuc1GuHCK
 O4aqREDu2scDhFxSod1LN49PCvbV6DRwuAAekZn5ODaV7CnoBFlS3T04evZHMN4Jz3ihcFO
 RHSa96mtXjVe8DKOGXDMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nkZ3ilQgCVI=:t0ccjCK/f6TSaFCYf/ESyb
 io9dJvk+Kbe+gxlxhDyC94iFCT3/pooxHZW4c28VNZ7rbmXW/wDr0yHhf4WVKxvUs8gGgqBOS
 6246BdaAUx8aYbput0jNtIJe5TfCE83e/wA6FDVOAIJRSl2zkh9z0U4Y/MXI/7emNFLZaN88A
 0c8wO54vKT2F7SO7jyhfjR9M6ux8FI0k2Ur3V1rTHiwXOKX85ZvEw51xkEeIC1xOP33G1+Fsj
 z15mMh2HHgEGip8j+i2Np43fa0EGkeQex4YQqwdYrkQweIR3e1yPlbhvG1Aeghsvf6xusTBnu
 uPndNbNq1QoI4keLrCFcU32k9ME+Lelwwe0JyoZmChw0vuapOkssk+ZTBG8xuWzSnxE8DIDmS
 mL8wUrnAqwBjwB7SBjs0Xy55hfNG/P4ozNR6p43vkOmzEEUJK/fnzadGaU+Y8FXUH6cuMfy3W
 8DNdF4NQ6UMcX5W+ztW5D4uIIuy+AUPoz/iSveESPQ8YMvtX8ZC6Ne44fitltttrVvYZTksyb
 Bs5ReFays7Q2M5Tr2JRtQSacqHF8mANlrJKF2/PvM69KwJ0f64JaxUQrKjvlKzjz8GFSf8BYN
 zg4IHfWCDghep2W4qMV9qfa82BWg84yOoGbDbYWoTIMldKCJu/dQHRdYLmssQH7Ql3xoecXfs
 2wQAOCRfuqn6glHh9D1rV2u6YGsnN9uq+Tvp57mGlQFBSoLuYMWML0veqDyjIZppTMfhc9ZDm
 2UisYz+VGjrtd8aMaDdjcKE3llSEDYulaCMrrm/+P2RZsbWapGUHXpJbDWVQHXK5XBDeJO1Gj
 pAbORjj7Uqn8DpAo250zfFUuxywo12/dmXXLju32CMI/ACP1Fx+OMDCIkgl9jHjislH+tWcWb
 mJLmXWL5oJoqa22taCmw==
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Mon, 19 Jul 2021 10:05:36 -0000

Hi Matt,

On Jul 15 21:49, Mark Geisert wrote:
> The new tool formerly known as cygmon is renamed to 'profiler'.  For the
> name I considered 'ipsampler' and could not think of any others.  I'm open
> to a different name if any is suggested.
> 
> I decided that a discussion of the pros and cons of this profiler vs the
> existing ssp should probably be in the "Profiling Cygwin Programs" section
> of the Cygwin User's Guide rather than in the help for either.  That
> material will be supplied at some point.
> 
> CONTEXT buffers are made child-specific and thus thread-specific since
> there is one profiler thread for each child program being profiled.
> 
> The SetThreadPriority() warning comment has been expanded.
> 
> chmod() works on Cygwin so the "//XXX ineffective" comment is gone.
> 
> I decided to make the "sample all executable sections" and "sample
> dynamically generated code" suggestions simply expanded comments for now.
> 
> The profiler program is now a Cygwin exe rather than a native exe.

The patchset LGTM, but for the details I'd like jturney to have a look
and approve it eventually.


Thanks,
Corinna
