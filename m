Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 9FC21384B0C1
 for <cygwin-patches@cygwin.com>; Tue, 21 Apr 2020 09:18:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9FC21384B0C1
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MYvTy-1jmq0s1M0W-00Uruq for <cygwin-patches@cygwin.com>; Tue, 21 Apr 2020
 11:17:58 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E3EFAA8270E; Tue, 21 Apr 2020 11:17:57 +0200 (CEST)
Date: Tue, 21 Apr 2020 11:17:57 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3 v2] Cygwin: accounts: Unify nsswitch.conf db_* defaults
Message-ID: <20200421091757.GB1654005@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200420192047.000069a0@gmail.com>
 <20200421091203.GA1654005@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421091203.GA1654005@calimero.vinschen.de>
X-Provags-ID: V03:K1:LGrba1PQfTe5MIIfqQIB7K4TH3WQqT5c7xUI72vebeTm/HL2Nuk
 CKUqGv3MQTA8LX5XvA7/1cC3NE7n3jr8UgKqJ7E9/WGsacEcES51drYW9QH2U5Hbq53yTTn
 6NMt21IdhO4SOTCFhv3iHljI6/ntLNgMVObtehCmG1OtBVcsCM5GlfnqNL7OSgblV3fZWJv
 8wHjW2gfH2SkJiZ14DwSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oHZlIyAZPjA=:RkeQliyGClo5Scal0czPaP
 dZBGiPYTdaUIJY5attsdbtK53M0hSvfBdVyHH65dxB/kjZIIIA4MRuspBrmf0XM/PcATHNrHK
 QCfAKfv4zkOX8iWBV+Rxp6LN/ifXYE/3wA2wqMJOovb6TbM4u2cGUcGAij0iK45lxa+3uUpgw
 OteixyZo5yBOlaPXQkbc/2XlYiPZBYhzTaW0eByL7dEDOHAKYewDH2DAfAm+K773iCOAtVN/h
 q9lqCAK6vJyKATOHq/RujWKhCGqj5dBXY6/Ng32H/XEqTbpuOQmq2CXdSlkgNiB21/izT/7LD
 Dw9A8FSbWb16P10L5N3tnje6RDNYKHak4KFepTbvd/CF725whHTJwLOnvQKBIwSncMApqcf1l
 J8mZLmW9cfFL2jzIm4NmJZ8Rs9T8k0D7STZSjxz3odyPQb9T9A3iOrFf1EOjBlvRL1UQBRYJo
 N0gaGzQFy95p5MfCTgcFtJgvHI02+eKYirhIN00AH2DZb6D0yksC4jRF9ogN9Sq6q5LT4xf+v
 9wOnLmT3Hc+dr2D4b+TYB3n9eXja23Rq/qfKRqtQ3rzj8129qgFFpZd84VlMe1IBF76LXqkTC
 NsUdp901fcyisFvBlDqLeQWQuCzIaFLk8MTgkHi7mTRZtv/I1O/iH9H0TkwoXBtKEsKd7Zvqr
 vbz2KhOncdqQbmpogVQ0kNq3im7kqi2PZd6OfG8Lqq+VsE6HwFCPfV4pNvkmvUMe1WcwPxyu9
 7okBBbyekqlqT7NVCfbmuq8m/Bia/bRl655jm6A9To+nOhvsNuxF17Y+XGp83/+5AbVPhosiI
 PJgeLOUyG/mdLdIBCmmoF1stsT8dEoeo+3XejX+lSXDFe9p3o5LeF+GvRkfzfc88++7yiq0
X-Spam-Status: No, score=-97.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 21 Apr 2020 09:18:02 -0000

On Apr 21 11:12, Corinna Vinschen wrote:
> Hi David,
> 
> source patch is ok, just the docs...

Patch 2 and 3 are ok, they just don't apply cleanly as long as
patch 1 isn't applied.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
