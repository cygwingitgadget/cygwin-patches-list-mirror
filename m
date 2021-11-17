Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 1B1CE3858402
 for <cygwin-patches@cygwin.com>; Wed, 17 Nov 2021 18:22:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1B1CE3858402
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWRi7-1nBrVa1LD9-00XsiV for <cygwin-patches@cygwin.com>; Wed, 17 Nov 2021
 19:22:33 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 66529A80D57; Wed, 17 Nov 2021 19:22:32 +0100 (CET)
Date: Wed, 17 Nov 2021 19:22:32 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Suppress unnecessary
 set_pipe_non_blocking() call.
Message-ID: <YZVIaMwayVXfzVMT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211117080827.1800-1-takashi.yano@nifty.ne.jp>
 <ce2d178a-4a01-6041-3ca7-44a9df090222@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce2d178a-4a01-6041-3ca7-44a9df090222@cornell.edu>
X-Provags-ID: V03:K1:ksPLt1F2PbexdUCrqQ8Jx9JW3NFS8njiD6lBmRyAxr2YcJQSvd3
 SEVyW2mIuDu2fJqUMcj2ooJnaV3/Xr/LfDKfhq43eVGrPc8jq8cEes+0QcKlESE8tIYQFPf
 l9p7I52a2j9zdoQ0j/KZFXxiBlqh2Yu7v7AVwarsBIRsGtF41przcZSaV92QwlDRfGq6QXZ
 gDaVZ5gxtT66b3umjG3tA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BkwzUYvyJZ4=:GQjGe5Ipgkc2vK6tzVJ2Ve
 /mkXiyIJTWbL6CiJZ+0XbViWdd64nJfW3KQwL3p+mZ+LBYu+KkF3bOAXiTT9uI9ig898WqWcN
 7S2LKf16xPSV1TckDz6t7F2+dSmtB4NvYRKtll+MBjga+jshUh+qPWDLWduPCL9MfJHfNry51
 CJdgmqummFtaqohZ1IxVbiDAtzgFRn4QNIM2kV83xLW0kAzHpS850saMolyyw2x4iAMsOLt7d
 M4sYqggQHXrsyvhYoP2KdKHmlJPg9z00JZvqMSfyHZ29qRWUfxUFF5tnYeNW3VexLFnbfcBK/
 avUcAd5BD4DYDZ24U9G67ibO2/HvMdQDebh0mf939lXSfM8XOZPf2bkq3fejYjuu2cqi1j+8a
 PK5p8Z7cpWsQPfR8My6z3D8Cct1kNAl5e45qqBsNCsqasqFlr2Efng9teILH23qZzIf/9adJV
 1Pny2wmCtk+qD8m3dPHWNzAfQ4Hr4zRjH7AgCGDcMd/vpEqzLrfRW/7FNfl6OFRTAQpKJmOGN
 mXs0pb5fUeoXAcJs4rpAU7N6qTqyTGT5GYvUS/QPxQUg9nkFTJovRDAxBs5kQT4ygW852W/iZ
 xHG5HVi//CGBI+EWYd1rUqYjQTub+/0TxvFhKiit9OPz59Q+2x1BKRwGbs4QhN7YDhyANNnSr
 BdgDlSpXeTNjD2nGmfJsiFcjUKeLvANy7wFkLwZGCYuCV6JfhC5B7jdur9wnwkZci8jfMBWT8
 Hu4arze+s5RzWq9D
X-Spam-Status: No, score=-99.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Wed, 17 Nov 2021 18:22:37 -0000

On Nov 17 10:09, Ken Brown wrote:
> On 11/17/2021 3:08 AM, Takashi Yano wrote:
> > - Call set_pipe_non_blocking(false) only if the pipe will be really
> >    inherited to non-cygwin process.
> 
> LGTM, but Corinna should probably take a quick look too, since I'm not very
> familiar with this part of the code.

Looks right to me.


Corinna
