Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 6E1BB396E852
 for <cygwin-patches@cygwin.com>; Wed,  9 Sep 2020 21:46:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6E1BB396E852
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MKKhF-1jxcep3DDD-00LlEO for <cygwin-patches@cygwin.com>; Wed, 09 Sep 2020
 23:46:04 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4B200A83A99; Wed,  9 Sep 2020 23:46:04 +0200 (CEST)
Date: Wed, 9 Sep 2020 23:46:04 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 0/2] Cygwin: pty: Changes regarding charset conversion.
Message-ID: <20200909214604.GZ4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200909152800.791-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200909152800.791-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:d903rNU9C4m0SdUfAxX5mPvpJSSkq2qlNOIJOjA6Hn3hn4oIJlj
 xjYAyvWP117cq+SuHsY/UUztsSIlS0mObA766b3rmemumWxIJTUd/llyl8IykTNabbj4Edt
 HdcuJFfrF5Wg9NsgeZ0GVHXsUhWNX1FC5UeMRN6CLfQ7vfil92uzQvIbTbo/8HR5xFeQo5h
 QCgmq0B/2LDOYyl5GKRjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E2JDWfHNVxM=:P5k78JWMujpyOLqojlgmEx
 QTgSM4g76JXmEEsR0N33bL+1bREcAvsWWWY1esaI4yLryZpPvNP+8aCjGDj3PrYBUMMecqIxh
 OPMVNEA1bQ+erJDU9MtHHVUjQYdZe3A3KlUaRlhA32yXfuAWUH2rHB2NOoskyCwmev4CF8+/n
 /sNPrIo8QiiZ7kRk3CeRMvzgkZOAKWGE5ww7irOeoWAf5eqtABKkCVg5SoeffWbpdUdC7P3P+
 ZkWJJzYIezGK8IQmUBCMaloi8PnKjU0UmFitvBDjVlELMbvXkxUEsHoIO++0U14Q7M0sbEW8b
 SadFJxcqXkfvo/iBtMKzPBI4nGHS1KPdrP3pOiRw5nwNQ9PyzpE2kugYeyfU+AuL+S7K/3qYn
 GUZWdwYN5w6AauLekii2YOit+Hkr7xVhSjwVwVrmEry7E6gY+T3/EsJqtUDAC1gtcl8jI6qFU
 dZKB1yA8oQ1b6A27grRDJjeN4gxxYdiZjtKeqL6+2rGI23Epohm2zNPpwgMREht7RkEFadPHn
 gb20EfbijxsaQ9qxdZGGGe4JQ+DzI2xtkEg9zEjFx4GjHQtGRx3xi9cwvfemXeEh1r8sFJiaC
 umjWVrNB5R7Idpl/ELaRNyr3r2uR3BSfVWQerjBzldrm3D7v5fhaz52IVOcRRbEeOD7+YZM8F
 mAyx88cPzCeGaXoJ0VPfSuQShIDja1M0Jy5qXErxn0ojOoLAl2hzfGboOtLAmpjYiEomWnY7a
 7Xv94HKh6iFp5nbtHJcXrxOgLr+1YiiYV5cggLVXbMx167/1hyd5Ub9E8UuawkQQv83e7Ur8i
 MtCl4T5ODFaciREr18jiKNf8OIhi9zRveEvt8/9aKbVuIMp/tCWtfoSbq/MRORFJjEI0/k8TL
 xZ49NaGanDXiygEFzIBQ==
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Wed, 09 Sep 2020 21:46:09 -0000

On Sep 10 00:27, Takashi Yano via Cygwin-patches wrote:
> Takashi Yano (2):
>   Cygwin: pty: Revise convert_mb_str() function.
>   Cygwin: pty: Fix input charset for non-cygwin apps with disable_pcon.
> 
>  winsup/cygwin/fhandler_tty.cc | 151 +++++++++++++++++++++++-----------
>  1 file changed, 103 insertions(+), 48 deletions(-)

Pushed.

Do we really have to support UTF-7?  Is anybody actually using it?
Usually Cygwin does not support UTF-7 at all.


Thanks,
Corinna
