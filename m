Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 84A383858D39
 for <cygwin-patches@cygwin.com>; Wed,  2 Mar 2022 08:25:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 84A383858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MeCYx-1nwk2V41J9-00bGKv for <cygwin-patches@cygwin.com>; Wed, 02 Mar 2022
 09:25:24 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 6E807A80762; Wed,  2 Mar 2022 09:25:23 +0100 (CET)
Date: Wed, 2 Mar 2022 09:25:23 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin sysconf.cc
Message-ID: <Yh8p80lFZNuUYWTw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220225163959.48753-1-Brian.Inglis@SystematicSW.ab.ca>
 <20220225163959.48753-3-Brian.Inglis@SystematicSW.ab.ca>
 <Yhy6OKd/2o8VqIUH@calimero.vinschen.de>
 <d71a5b05-531f-8028-7b06-6ee466053f5f@SystematicSw.ab.ca>
 <2a8615a6-1214-ed7a-71f1-d191bcf2f3fe@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a8615a6-1214-ed7a-71f1-d191bcf2f3fe@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:t38CypuH5LwCFBFPUmpZcqUEwWStvMzJL19GSdCgxmPh5tLK4QC
 WnAzzsdp6NYMZ2oYb1yBKwd1PX1hTNV1IRzbzKeEl2Go/LcJjNRkGmNxrVm69kjHRYUh23g
 2lR4OvtZfiSStR+RNWu52o1fYrG8+pC2GcmMl0uxREedXta4pwcSDS767L8dy6amd9PJt5Z
 1XqUyyHpMkfrtGB66F4OQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4c+Ggs8yvGs=:8is8eqH0axThiSHXU2vqgc
 PVyGnlmsI5R4dYT6xKjfEQgoaAxl0Q0yi3LKvOXThiBI4KeKuFMtM/ZSMCH2FhiAHGGjh6etR
 MXk8aqE8yvdXLuUNlNfSZbSnbwwmfO6EAkn6rA0mqr6K1rBOkkbg0fjHh9DX+URqT0ASjmB5T
 H9FE3uDiOphPY11FapIZkcSXSwtAF/Mpf8Yr2RpHo6Tn4yH9RU4Qe68GLEde9KD1nY1grxBHK
 8yRCRdJmze0HbavGpTkmx6wDIfP14zQgBBKHfAI/tS8hfsslnvyKiOjt2c98SOYXkI0R4ONTF
 KvhBXwfpaV3gpAFQUGRaW+fFXtAEC6Vi7SwRTCnpdN9XnVNeSoRohU17uNbCwDMvx5hNX5wti
 nu3+ONeV6s4d87zJgHip8MBX/+ywTX44m/WGWurr85Asnzzu5H1ESwbQnFPze0mgXeXAI1DKn
 SfRCFG2Bbg4jBrmwURxSS18MawcXKfWNe4zsgQgdZZSEPtbAxz3hHyrIXwazZmhIRCvx2q2AU
 hpCQXMhXM37HwAvkZxWcuUWGv9qlSLqA3aIAJCU37xy4IEIdvXRd0yX9yc0pCj+X6u+eDU/1G
 VfFMOrQe7uXyZN1rFiqD1DIVVg+yKCT3w5QxtOszSJvG2V0fNbuqYGqkhlc23cqkzPk2zE3lw
 0+032eHp74q5gdu2R6bX3ZfWjtSj+DLhfHXHeQqaOsnZIuvhrjXeS3HQjOHmfmglgHtaBHGSw
 SL6FXIjISKB+9rYQ
X-Spam-Status: No, score=-96.5 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 02 Mar 2022 08:25:28 -0000

Hi Brian,

On Mar  1 13:20, Brian Inglis wrote:
> Interested in a patch for sysconf.cc to return:
> 
>      _SC_TZNAME_MAX => TZNAME_MAX and
> _SC_MONOTONIC_CLOCK => _POSIX_MONOTONIC_CLOCK?

not sure I understand the question.  Both are already implemented.

  $ getconf -a | egrep '(TZNAME_MAX|MONOTONIC_CLOCK)'
  _POSIX_TZNAME_MAX                   6
  TZNAME_MAX                          undefined
  _POSIX_MONOTONIC_CLOCK              200809


Corinna
