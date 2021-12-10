Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id B231A385801A
 for <cygwin-patches@cygwin.com>; Fri, 10 Dec 2021 09:51:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B231A385801A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MJmX3-1nFDmi0dNR-00K981 for <cygwin-patches@cygwin.com>; Fri, 10 Dec 2021
 10:51:45 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A14C2A80D32; Fri, 10 Dec 2021 10:51:44 +0100 (CET)
Date: Fri, 10 Dec 2021 10:51:44 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: path: Fix path conversion of virtual drive.
Message-ID: <YbMjMOBmVysDekHc@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211209111527.15917-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211209111527.15917-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:1NgisZhxDnpGcrv5X8XJQ4RryHCa2/Yv9ip2BHqxXeYvJNYMIL5
 RThPfLX6PyPH4XZ2vhooiwQI4nZmLzKD6JC+iiKq1kxSbULg6R9lj9tjvaN0kbCcocAzr/k
 7PNTobrlNhOZe1dsBsa2HQRDm9D1k6zQpszcHf0AdTtLmiM+JvAS8XembzjWNPEZmsv6tPr
 A8+TGSo8zYdpLlH9fb6PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cvC2gJOoJ0w=:bNLhGLSD3LI8nMTJh7Uojn
 d1ZR8ITYtu1Bp8ScQTrIVZQrkpZRi1x3a26mdOaSPtImmFwpXYn9xdYD5vwjt8mJR+mRL0rYc
 dKf4iwgelB4kvLwKMBR7pKXCRVd+FhRtXAes1JB/BcxNNzLct7AW9Tw4OwwDyPQqOVD4bom0w
 Tvt2DIcIjLvlKPzmhPA+bixw70xsp22gXkHm44DV69JMaK/YCyC/yxMd7IH6cKUAPqlimZJX/
 vLKx5hYSk/3WcVWXi/VEABMPd9AQDqfm2AzubIebJ43tGk1oa17CqZ12PfPtGO4aoWOk413hi
 5vYmyz8o6VHqs5zKP/1e8YvK287gkbztGY3uoSjmWSn/aVoKckcQEE5+HInj80IjzGX5K5CiM
 jXEf2yJutOwSo+6GwJjjBr1OuYfprI3fhQzqJbAOeqwhwH+2lvtW7Xhl3NCQ4iwVIhD57tLeo
 Tz29HMc61WhkY4pOSWdoySjV69UdRB0WP3jEYk4zXVPgDi6z5X6MgLJCpU8+Pur5gv3A7nXkf
 BcSP6XWOw03lWcBOBcuYIC4e1Z3n2UkmFEEg00IDQJ8iJvT2Sao/KTGur8pj3Q+Ajz1Sn/fb/
 5iTcgu3HBl/qmis9njPy2z2jf/lOGY+48VpbZfq+KOGVsp0Zrt8atAFwutwnJlTY4IIxfAmni
 M1771jCIf/0I/b3r7ctqoaZ4wqf0TpHIQaU/Oy3sRk+YdFesXFBPdvrbE+1xChbwPBNNYEO5u
 Kw7jWWsWqW3GZOqy
X-Spam-Status: No, score=-99.7 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Fri, 10 Dec 2021 09:51:48 -0000

On Dec  9 20:15, Takashi Yano wrote:
> - The last change in path.cc introduced a bug that causes an error
>   when accessing a virtual drive which mounts UNC path such as
>   "\\server\share\dir" rather than "\\server\share". This patch
>   fixes the issue.
> ---
>  winsup/cygwin/path.cc | 56 +++++++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 21 deletions(-)

LGTM.


Thanks,
Corinna
