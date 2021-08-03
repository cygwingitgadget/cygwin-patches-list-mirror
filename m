Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 4F9433895031
 for <cygwin-patches@cygwin.com>; Tue,  3 Aug 2021 08:04:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4F9433895031
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N7AEs-1nDShc0LqG-017T0k for <cygwin-patches@cygwin.com>; Tue, 03 Aug 2021
 10:04:04 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 315F8A80DA9; Tue,  3 Aug 2021 10:04:03 +0200 (CEST)
Date: Tue, 3 Aug 2021 10:04:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Make gmondump conform to its doc + adjust doc
Message-ID: <YQj4c77qeWPE80Wg@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210802092553.1268-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210802092553.1268-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:POSbsQrY/QdS1XorMzH7jL9dNxQVSI8SaZbtXq17yypTxFan1Qk
 0xk9yac/5JacEyvDHpHgDiuJsVPzo9qZ6BedsgGEJh2c6Oix934UinPDjmlYxCCS53aMaBO
 mprRA6cTWnZHY4sannVnavSZa0sWLj3ULpuuqDzU4tZnQRTB0tPjrfW0cTY5uaA/h67v6yR
 Vc7hnyfqgVVDkhhas436g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6JEUZMRAbYY=:eUL+dS1uO18dYjurIYN8mh
 5g61fsWE61/bUi9noDJAGp93mWOzWL+oLC5h36M3vTZMGFDe+jwiO0nU/aMKCQnoiCSoKwDwU
 b+w5RwUYHQDjiLmEFQl1y7dDBfNqfB1a2knY5y2c7JMAltDI+wD1nxfcxr33e0xhEGGTX/O4t
 6yT2K1z09N6fgElmQXpXFeOzC8B6+8aY16EfDtKFWtVNidsuD/4DcWjLtnWknZ4dEFdhJ/EDh
 LKSSbh+ZDEJqj3wV5f8qtDLVV95hlGF/Gx2KGvXl3pKeJZUk+PXP6ZB2EcqlVL1Gh19mvgb+6
 8S6VYg8lUbltju+7AJQN0qRJ1b+LBd19ugkYT0hV1vOZ6U8iNnd1TBpgpyPCbf+DCQjWQKTEa
 vbpJrdRmOL93X9A22Hjy92JWCfCoOK2a2ehwvaQNFU/C2//H4DjvOod8A7zS9sC+0L14/usxd
 gVqGJj4tvAE+3HurzuE2rDjai4yUL001KpEbqYIAyFO+Nc8eQD5DZPYQMux8EIKIZe0rEsPrD
 rCJCmQH3I94iCkSjha4IKpW66J/a9DZCy+8YeLTdPFbreOGKSLZQksimzWhfqCE9NcCARvk/U
 ju7PGct9lPxfzBHHhAX9K/VjMM/yfSe5EUf626KMmjEPwkeUqY/+i4aqDKF7qkgKNptaHOcqy
 lPV41zRo25ao8b7P4rjt2UPWvGXQNS/cVN60zQmg2aNm8xRhjHFyFzvQXJoM22FI40esmZaeU
 mxGMwuNqBabuW18MIS5iWAOlDaV45HdxKHg+40xOTkARv1Idq9pEdTKsn23pRdSB5BE2aQw9r
 HZrA4/2AtLILjbRR1wlPpt1df2/qZDHxSk8vV6Bgp5h4xo7kOmX81yTXPCpms4l3nBulytXYl
 ducKGp8EbsO0dw+w5ZSQ==
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
X-List-Received-Date: Tue, 03 Aug 2021 08:04:06 -0000

On Aug  2 02:25, Mark Geisert wrote:
> The doc for gmondump says 1 or more FILENAME are expected, but 0 is
> handled. That's an oversight. Make invocation with 0 FILENAMEs print a
> one-line help message.
> 
> Reword the beginning of profiler's description doc to clarify target's
> child processes are run but only optionally profiled.
> 
> ---
>  winsup/doc/utils.xml    |  7 ++++---
>  winsup/utils/gmondump.c | 12 ++++++++++++
>  2 files changed, 16 insertions(+), 3 deletions(-)

Pushed.


Thanks,
Corinna
