Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id BE22C3857C67
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 08:19:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BE22C3857C67
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mmhs6-1lMNJC1Lt8-00jrtY for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021
 10:19:16 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C8325A831C3; Wed, 21 Jul 2021 10:19:15 +0200 (CEST)
Date: Wed, 21 Jul 2021 10:19:15 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Add more winsymlinks values
Message-ID: <YPfYgz0EHe7Yw5ko@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:MbxDG0OenstzmWYmCTcchiupMACcR7aCgwe2qavbf0cjhekgKrN
 6uIjtP7CxGd18RZVi7JAdWAKcUIsXORN2fasxHU0yLVkgeciXukecqTQfKVpwdq3B7ey/CS
 7neHCWko9sDzx7aJgiwBC3kg17/8MOQPzhj+PS5yv7C07xvxWN56MLy5fD3UiBlOZk5jpRW
 5VBfQY9JEGA/1Jj7eR/dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DWmN9WIm+tg=:oSV6W1VFmmz3N/uw7kgFd2
 k/ikln7zwuQMMOwcyRWoUW+C7eMA7F5m45eyEb+kpBun4uhKCnFa5h6leuOxiOYWROLftg8eH
 3IHX72c0YQslG+PhpEWDZ0+Ev4ufYgZVzVwmzWhjjpr3LdPKEak1P04FbEVgEaMgG7OaooW/B
 1aRWmfOT03DwJg6k4ogSlcHqNpjNkF5sa0mjuz8crv907XIklfrbUkSmNJXWULp6YdBusb18g
 UvrAY2ol1ESshd8ygDLCGGoAho8n/RkjpoLRqJQmiYdXE87sUdyQd1bwVg8A3h01B6AwdpKfj
 iEQDeHtkPNCIL66hQSSsjl1cPZ4+CrLgXP7GpMtEq+UdVjDG45RtcJsEYUucYn6n6wP8IZm2y
 L9q3uXvmudHCRcWt0kTmYNzrwr4WBSbUNFh7Aw2CoY/tVVF9BesccWcBNnJi3D012J8ZWYGuf
 dq4vk+FSHZPnYY2y/N3eOApebIU8Ymn6dpzN34xDFksm6TKvFcBOxx1/i1e6JCkS3tl7t6VNF
 3JVzHk6OU5/UvmhwVeYgKLY+cSMv2uP39QhOomHXw4VKJjf3bhlPHDBFHT2lJYKwHHysFu+yn
 tFDaqquMedAYKYjeRr+hG73mvWuVTkHtGm4MP1DoYGeX+UVCBj4K+wL9qXl+PRBXDXZN8oCuo
 M4QdJPwOOfIoTtWqfb3mRD7Ntcgeop80rUkYAe83BvJTBUiNhOeihtLk/iGYLALdsk/mF6+L+
 pn27wIiMNXUYWvmGweuuxhxgA2GquwQyqhqEDccF/KyIgEf6/tRNKHhk7nfjYrNxPe6YQRXX0
 gVu2b/hJEwMSXj/ZwerveXIQL2v5UW66F9/fkGXnngX1ER6odDoovPGEZKPf/oeZqTsA8CpBz
 v1wCfgdQzjkvIcl4hWkg==
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
X-List-Received-Date: Wed, 21 Jul 2021 08:19:19 -0000

On Jul 19 17:31, Jon Turney wrote:
> I'm not sure this is the best idea, since it adds more configurations that
> aren't going to get tested often, but the idea is that this would enable
> proper and consistent control of the symlink type used from setup, as
> discussed in [1].
> 
> [1] https://cygwin.com/pipermail/cygwin-apps/2021-May/041327.html

Why isn't it sufficient to use 'winsymlinks:native' from setup?

The way we express symlinks shouldn't be a user choice, really.  The
winsymlinks thingy was only ever introduced in a desperate attempt to
improve access to symlinks from native tools, and I still don't see a
way around that.  But either way, what's the advantage in allowing the
user complete control over the type, even if the type is only useful in
Cygwin?


Corinna
