Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id 016DA3858C78
 for <cygwin-patches@cygwin.com>; Tue,  1 Mar 2022 20:20:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 016DA3858C78
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
 by cmsmtp with ESMTP
 id P7BGnfT2zgTZYP8zGn9sn6; Tue, 01 Mar 2022 20:20:46 +0000
Received: from [10.0.0.5] ([184.64.124.72]) by cmsmtp with ESMTP
 id P8zFn4RpTQV6mP8zGnAa4l; Tue, 01 Mar 2022 20:20:46 +0000
X-Authority-Analysis: v=2.4 cv=PbTsOwtd c=1 sm=1 tr=0 ts=621e801e
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=IkcTkHD0fZMA:10 a=iMpC6L0jGsNNbTZxuiUA:9 a=QEXdDO2ut3YA:10
Message-ID: <2a8615a6-1214-ed7a-71f1-d191bcf2f3fe@SystematicSw.ab.ca>
Date: Tue, 1 Mar 2022 13:20:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Subject: Cygwin sysconf.cc
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220225163959.48753-1-Brian.Inglis@SystematicSW.ab.ca>
 <20220225163959.48753-3-Brian.Inglis@SystematicSW.ab.ca>
 <Yhy6OKd/2o8VqIUH@calimero.vinschen.de>
 <d71a5b05-531f-8028-7b06-6ee466053f5f@SystematicSw.ab.ca>
Content-Language: en-CA
Organization: Systematic Software
In-Reply-To: <d71a5b05-531f-8028-7b06-6ee466053f5f@SystematicSw.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfENOCSOI1wf9PKLfwc6Tsr5SngzKo3jsEBk7OtF0g5Kyu59rcCd8oEBt31cPnnoP5dJYDnoN+iTUks8i9yMIrUc8jCYhVa5nzSUyok/p5OXj6nW2y3GJ
 eFRSG8+IrSFncXrfTBSpPJihUMX05/fRqG72udtHlUC7fPrpnaRqJef1mMGLYmL6iz4mRaI9WaDf/5ZcODxPnu5p7RLlgCNw7VU=
X-Spam-Status: No, score=-1160.9 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, KAM_LINKBAIT, RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL,
 SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 01 Mar 2022 20:20:48 -0000

Interested in a patch for sysconf.cc to return:

      _SC_TZNAME_MAX => TZNAME_MAX and
_SC_MONOTONIC_CLOCK => _POSIX_MONOTONIC_CLOCK?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
