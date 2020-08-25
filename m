Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id C52023857C7D
 for <cygwin-patches@cygwin.com>; Tue, 25 Aug 2020 11:04:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C52023857C7D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MkYoK-1ku1Bo1GUo-00m5ls for <cygwin-patches@cygwin.com>; Tue, 25 Aug 2020
 13:04:46 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A4334A83A73; Tue, 25 Aug 2020 13:04:43 +0200 (CEST)
Date: Tue, 25 Aug 2020 13:04:43 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] FAQ api, programming, timezone, setup patches
Message-ID: <20200825110443.GH3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200824201058.4916-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824201058.4916-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:Hj/5BUyVsEtRrRxbfp2spSO9AgAZbFpkz2QgUi+B/myLIdX5xQ6
 Xj7LnJGybEv5i0yRJ0XgOu0fQFpDjp+D+4c+W6jOmdUSCBODc+/4eyLmp8YD1WllhM1xVFs
 ZjqlHzfVYC+NQpXsO8uSsggeZMG+VaLcsOIqP5BIDSjK+avKxHyT1f6AQ7SdyXCRh53nStW
 SeNh1NgkvuQ+p0PH7Nd5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Em26vKHa4RE=:Np7f2S5kuDtmu0OdOeB3da
 fa/ChO9ALl9ZQ4h+yNvmnCyhYsXzFf0ZjcS/QhQDVPNCLbR7h4oE9+ze1K7KLq7jN/vUjKDY1
 m2d5981zMoUlQIm1ga0snunOQLsW+5wQodJWZOdzkzMfXvNIUjCkHNKMkegHBn6svHoIe+Kr4
 aqGeXBafBJMw8/qXrlvKC5q8RMukcF405Ww8JdR8Qc+HIPKqQqSARmi0CTXOT5kmC5HhTa2bP
 DW3wGOIq57dmmtheAEH1dn8at11jXsQXQYs+QWvsfdHu+bljgxjtFfhqnfbOYazYl7fQTi4gg
 mNIeM2l3Ey3ww+PHwcwkxs7/BqslhBAh44BMFNVHXfvkHg4xnRMRIBH2tOUuY2hrc8BLPdPW+
 JIs7/9G9+1VyPpPG0nHsgmkwaHxqMIgaDi575ce2WG+nTND3FFcndiIRH6U0WZBRhB8uSFDTU
 quNhCVauQfsvjIQMgzbMY/mImmbztHM1VlVeoVP5EeWnxWELm16kN2LwHXK8UHcQcAzhaDFk5
 oEeYU/6TCT8lQu9f7n2E2EvdXOdVP+B98k2Ii8ADu9ZL681xWWUT5tlvGiXi8g0k3Er3/GJN/
 uyXvS9Qw1inwVswjy+2ccIPdlkbr/W+NVRHiHunq8yhccPAu/r+vb+uT5udOs9VSVwoU4FC8Z
 kXatLPkTo9KZ5loLgeVsPt4+R5gS0lrPWa7+e6l4IHDTm4llYrZDzRRpnUjGMmk2BoV0X4TW5
 T8pXjmdJ79QoexVLZH9cGFmYV2rZ2TbG8xrAxvezkHwPyjyH50WEK9Y0YWeLASxFOqhH5FlQT
 p2wQuQwBMe4EAt6nHR3nD8LIxk+lWP0KW7ANX2Ed1A5us6kNDcyYZiDPBDnNN8BCPKdNjswch
 8jjz88s1jr2CLUuYb2Ig==
X-Spam-Status: No, score=-99.7 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 25 Aug 2020 11:04:49 -0000

Hi Brian,

On Aug 24 14:10, Brian Inglis wrote:
>   winsup/doc/faq-api.xml,faq-programming.xml: change Win32 to Windows

Didn't we agree on WinAPI?  Windows is fine when used in the context of
the OS, but Win32 was mainly used to denote the API.  So "Windows API"
or, better, WinAPI, should be used in these places.


Thanks,
Corinna
