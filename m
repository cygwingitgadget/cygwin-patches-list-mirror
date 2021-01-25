Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 687EC3857811
 for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021 18:55:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 687EC3857811
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2ep5-1kzzkj0TEt-004EZQ for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021
 19:55:14 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 3622DA80D5E; Mon, 25 Jan 2021 19:55:13 +0100 (CET)
Date: Mon, 25 Jan 2021 19:55:13 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Add missing guard regarding attach_mutex.
Message-ID: <20210125185513.GE4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210125091812.1765-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125091812.1765-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:5tCHY3Qzxb27/3alkxPoT86NO55g6pINd/PpQYo0xestlbg2Kvv
 GxjwauqSVoLIVw0A8TvSzrzP4jn4yPy4vYaKKTlGfPWVzEzEGPcjysGJ59kgv6pfwOWf4qR
 9216nTcKKIV3/bpOSHktbumcOkw6s3SqVXY3grN8ITspQxqs2xqMIJFn6yeuTcgJfYeBB4F
 VMP5tpboFJEIlT3A/wbIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2/7A9INej5E=:i4XuGk5ifnOEv8UuMv0eW2
 cuMbl9jNeqHkc0P5FEtRijeMMySRx4QgVr8QFrK3xHvmQOPXT5XLqdfn6NUMMDOw+l6g5yYTb
 kDiYL5aIPl10gPAYcQrAXkYU8ytFdO0wD/YrUm7N6+D3oBzlz3VFhpNDIy5FVe+2Whel33h+U
 5cOfRb0jt8nThLGmZOWxA942k4g6UYBEhi5mQuNhTeNSrFY86owfEgqnytgIEp7FQgUipk/NZ
 Pk63+BmeO5gqeXot5lZYKBTn7ZV9TS8DRmDXP3dw6ookQl5qqnP3FiqMryxdsjOHxk4WM6OK3
 Y9nbFEZA04xulLOdGwT+2zcvq6VNGU7BggCIM0AgzmlnMmuMjJ8o+0eRtqKi+pvAW6mZD06h+
 zT4+sTihyi6YLx0WJtY00rYEXb4zTPYUKTjKGolRkJFBUvF9uGWIDaWmVhfswdQ1TY3Ak5JnR
 7vj1BJmfMw==
X-Spam-Status: No, score=-100.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 25 Jan 2021 18:55:16 -0000

On Jan 25 18:18, Takashi Yano via Cygwin-patches wrote:
> - The commit a5333345 did not fix the problem enough. This patch
>   provides additional guard for the issue.
> ---
>  winsup/cygwin/fhandler_console.cc | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Pushed.


Thanks,
Corinna
