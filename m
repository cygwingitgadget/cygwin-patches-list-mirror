Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 16E45386F421
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 09:14:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 16E45386F421
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MDv1A-1kMske2zDQ-009yRj for <cygwin-patches@cygwin.com>; Mon, 07 Sep 2020
 11:14:56 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 135B7A83A8F; Mon,  7 Sep 2020 11:14:56 +0200 (CEST)
Date: Mon, 7 Sep 2020 11:14:56 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 3/3] testsuite: don't strip dir from obj files
Message-ID: <20200907091456.GI4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200905052711.13008-1-arthur2e5@aosc.io>
 <20200905052711.13008-3-arthur2e5@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200905052711.13008-3-arthur2e5@aosc.io>
X-Provags-ID: V03:K1:eniAL0mZYVhLxMDoddQLjQ4GV8HO7hxQ06RoNAC+ck02e/5/4qj
 WNOmTEJwo5J8yU4iO6TFy7rOVq6u2dhzWh9Hua4Xppm4ymuHVEYZPEGKTQmv6zTVRjparAg
 fG0yGrLIx9xplfiAUOFeiT66jSe4z/Z0hNQuRuRZJvG/YYla4EoYM+uH02ZUuZSJy2uf2PV
 1NKCiCzD3uLLRLKkEzg9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ZNol/WxxRo=:bFP7gJ6Y4geZcubgm4mcEH
 ROLEyIWXIIE17i5Uj4SHdLlLYXzQDyKDXibVE5oyn+M0GKm3JLdDhEeL/wWIVyvXW40jeqWNn
 0lYz2UMGm4pVwYkB7x1FQ+Y+MweFeWnDTmnNrdo9xAHdQD//pmFEh1VrF430kDF3cq7reNIPv
 Wxmh1bMfs+SKTuf+KKI1pWbVuIHCdLmfayy2/l1LeDJWfSDPLGZiYRf4LkGxqH2qREoeYNR66
 osi+YDdzQHXoW85xy90NKCKFIyMUL14CK9OQ5vDyHAxFtkUjTO3QjDyjV2bFoMiB80iNOMk5q
 eV/HNNl0mTMRqI1BbUw7Y4WmvZDniKA+QT/IY4PG4qeW3MjoAmiz9cVkQlTEFcSD3H0xsgdtE
 x7ZmVybzTx/izRxwkJgUfO44qHkXNE4pbOEm06aHAubXQESRBEDvvmevnX5mxqwrcnhQBrE2Z
 PMYtSg909gVnIYbwtIQy7Eho62x0qcqUdwob8WDq2IduX17cZIYrp9UxohR91w169qkBx3wxV
 +MF+2fjJK9lF1hrNeiTaT5f8DxVG4KR0bz9SqP8kRo+GMggLbO/TcxYVuKFxwW2ILzbUdQEhD
 K3RmkEtHe+Yxlnzj/tsletrDWMPpxhwhQq/UhbRrcpEZYzCq2Cap1Cff6HjZA4DOGV0LRsqMJ
 +7z2YQtoBNvvrQp5KmDMgNvE2agBp2MWFuAt6ZbhfZ8gsuZM/oFOwIVGucbueOYgb8d2kObbW
 Ojel7SrNuqyFm+Vvp8x9aWW4ZQyQA68R1EE+WmQoaKZKjqH8z392VTxZxR09C2NdM94fY6z6O
 pr8KC5mC5Ea83OUALOx3qA707Uc/ULL9CDC7HCWlzCBKQvTplNKuQcUGbnT1knecBOU2YwShS
 DvB8j6wvCcoU+GMMVYyw==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 07 Sep 2020 09:14:59 -0000

On Sep  5 13:27, Mingye Wang wrote:
> Make has no idea how to build an o file when the correspoinding c file
> is not there. That happens when we strip the dir.

The testsuite is broken and neglected for a long time.  You don't have
to fix it and add new testcases.  The better thing to do would be to use
an existing, external testsuiteand drop this one.


Corinna
