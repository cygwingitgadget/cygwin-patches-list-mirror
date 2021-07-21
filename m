Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id B168C3857400
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 08:09:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B168C3857400
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MF3Y8-1lv8vC1fho-00FWh5 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021
 10:09:30 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D6B70A831C8; Wed, 21 Jul 2021 10:09:29 +0200 (CEST)
Date: Wed, 21 Jul 2021 10:09:29 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fix format warnings in profiler.cc
Message-ID: <YPfWOWeu6b0c7Kfs@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5acddcda-7fa9-e854-911c-27af2f13a22c@dronecode.org.uk>
 <20210721080040.55316-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210721080040.55316-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:Usd71CD2VPHLx+f0cdscj3hDH0WzbFttstHOvGNx9cG3kGXswlY
 ro/InuZxQnBJn/Dx3mmmA0YRBMAxP3nBEjHHxK9uMrsYZ8vHyCbTEXpAMTMB95BFQSBsLUl
 Cjelp9TAzriTRJIU3lxYUqsaUHwCfuX49V3RWG4jC0CScEZ1qJhV6n6kZFCQvYv91SIk2Cp
 PWDFUJbjJKc0ZjVqTHz9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Td8w07ecuk=:cRvgkt20Cl03CempL0UlWo
 qeeZAhAwPjzJFjErKK9fcHi0kcHz4dDfNisLUMpaknQUDUogMvdKk8TdmjGY9cs7MBwgFk6P/
 9lCDWOfKCxSKeaW9iolXmTClJCoStc5gd55B7WiBu2fsFB/jloYQW3rRfwrBK5VTDWMU5voH8
 MDbxuXrkbniCsEelnbSmubE4U8xgpaoGjABdbb694TGpcEqwQJF6S0MT8lZXqiQacxLRZ1/Fy
 ScEnOmktz4Hod1AhASfOwmdeYAvnel/n4pxsVEQjzCKeiVzQwP/NbNQXZb2AC6KQUUWQKxFms
 r/1JeKx4MEBvMj72pWfO7Wsn6AdG7MQcQCsRGdo2PLREcy73pKq0130oP9U3aezJij40htByL
 wiR/5arc2cbZIwltnu18lWAOX+dyLLo5M7teeU6911MridkUIO7e1oiv/PUpoUWfMIZawZqwI
 vlitWnsHvr8pgkpduru7GLhWfPhrr+/lS80MBKQ72zXzKE+oh8g9d3Vmk2XwxCeF1ckXMXPrn
 MJokgsDO9k7sqHyOqi8Mmm0tRyG4Yfa7qsCH39MkqDvdAa2wF3PVLy0G3MPTxtL8noCRy3Cig
 TNJPHOgajLFaoj2gSlXcdfVOtVEHjCAToa3NdSkMwhSl9p/ZcFzE8aMljuIQ5hDaoPxkGMjlq
 X1DDE78TDR6bfLuZns+RqwEGk+8wPSKr4oVlbL6tGoM1OLsG8/7qVdNCTHpFv1iZL2R2CYytT
 UYN2+KvukmF2gPqUXIcPd3ct42zXe0cHVNry/PTizeI0eyShseI1fPdT95mpzGw+mJ9ByKOc6
 VHXdnhhPkWEbAMLmaT7oG/XzAUxwsGMXgmzeI3dww+lmN6MOFKWZK8ofq/5M7wNjmpnY5e9wS
 O17sv7pnSjG7dzCphJNA==
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 21 Jul 2021 08:09:33 -0000

On Jul 21 01:00, Mark Geisert wrote:
> Use new typedef to normalize pids for printing on both 32- and 64-bit Cygwin.

I pushed my patch before I saw yours.  If you want to use ulong, please
send a followup patch which introduces the typedef.


Thanks,
Corinna
