Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id E02293853C19
 for <cygwin-patches@cygwin.com>; Wed, 28 Jul 2021 08:23:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E02293853C19
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MHoZS-1mNWR72dyY-00Eyf4 for <cygwin-patches@cygwin.com>; Wed, 28 Jul 2021
 10:23:43 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 35399A80DD9; Wed, 28 Jul 2021 10:23:43 +0200 (CEST)
Date: Wed, 28 Jul 2021 10:23:43 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Convert gmondump and profiler synposes to
 <cmdsynposis>
Message-ID: <YQEUD/d5NGiAma5l@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210727125751.4791-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210727125751.4791-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:EPwwGOaxvu0NmXSkKmm3YQzYdLDW43rn+EE6bCVVUb9qfb3GP4X
 /NOUhpQisAhEIRH75O+JU1NYqg63tXau6e85IaHBBUt/iZzRBrmh9gzdTOyCy+3GtvWw8e7
 lbmF2+Lcp91hREAhaNcRSG9U4hWKEr5tKM1NrDr8BYIx4HPb4cKKORzXKYwl+NfsJv+9+QZ
 GJLQRkbJYrS5NHyjpGqcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0xIjC7JjHEw=:sSeaURe6FfRQrf4MYte66r
 6FvTOP7E5siEnFcc0xAItQZqZ+VGi6+RCx/kZrgM6kN+YBFHF6USUjHBNAoYtuDpEcuiiDwip
 6mWMIWzepQVDKf13xnNRfH0TQCqYzSo119OV6qHqmRPEM+IoJOK47v0qqqvgXmbOU7DZQe4uL
 Lksl1EmHYeRjpPC3/Rv8omnEuAE7bhWAxtrPv/G8OC5VM7BAxxhE0WJRvqktPG0yCphWfyV+d
 VOeenyLzjjvFricqpQ9VMtdQOpxSsIbOt2lJrmf05j9ZRSmoLXWgadQTEQl8VkfvvmI/SeQWE
 DmQW4LenwN5CERkVQqGb8otxu14K9fSYTLgzq5hGjfGAh+0G+5l7IDBGN5/PGQ6XoHnrCkNWU
 iqrq9NjxdELBNKCxDv5tj4Euzm+ENscd5vYLhyEsPBKBrjxEEIXQk3iQCIxM7vxxewOX9S9PI
 T73y3zFnj91mkrneBfvc/qrWguDKnjH5888GJGDRx/axN9c1L8S4F+Wa6pTb7++y9NPmDUqLM
 kjidzOk4RKyMTMFK9gaQ4NB/Fe3yW+33wCLmAn3TpLhTTIYKi5DOacOa3gr7bIlb+J6pNw85+
 wG3iKeMv0WCy0g5p2VlR3+rT4uYEfg/9Q/HIlhr0PYbMN33PLacxIaloRWEVllhg9ioSg+vj7
 WwPOSCVRkN2R+ObD2ESQB0wzF/7RigZf/waBl3Zf5nFvJyGqMcYHE0fJs9+QrsKYfR9Hy1mZF
 SsvR8G1Zo4wlbXjVX0I4urFFYOa7mrBCBiwqThyqBB4/syBJm+WLZVafw9fIOhOCg47hcnsU6
 IXM6ZwdDJ0nG4zXg+sGeTVzF4lA+OpSGFoWsR0BGjTBzDVlyX5f0ziNpFt9zmcjtD6DD0QQjM
 VZNrEF/MzDAit6F6aZ+A==
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
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
X-List-Received-Date: Wed, 28 Jul 2021 08:23:47 -0000

On Jul 27 13:57, Jon Turney wrote:
> Convert gmondump and profiler synposes to <cmdsynposis>, since
> addition of these crossed with e6b667f1.

+1


Thanks,
Corinna
