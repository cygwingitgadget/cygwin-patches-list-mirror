Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 4E11F385703C
 for <cygwin-patches@cygwin.com>; Mon, 23 Aug 2021 18:09:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4E11F385703C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MwwqB-1nEcqo3uTD-00yNlB; Mon, 23 Aug 2021 20:08:57 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 789A4A80D9E; Mon, 23 Aug 2021 20:08:57 +0200 (CEST)
Date: Mon, 23 Aug 2021 20:08:57 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCc0LDQu9C40LrQvtCy?= <schn27@gmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix race condition in List_insert
Message-ID: <YSPkOY8WbIppas+R@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCc0LDQu9C40LrQvtCy?=
 <schn27@gmail.com>, cygwin-patches@cygwin.com
References: <20210823142748.1012-1-schn27@gmail.com>
 <YSO4hmZcdL/5w44q@calimero.vinschen.de>
 <CAGdYWrY=tydw+Bu_dYVef_enUh-_ndBC4kQGUgfL=D6AZuqb+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGdYWrY=tydw+Bu_dYVef_enUh-_ndBC4kQGUgfL=D6AZuqb+Q@mail.gmail.com>
X-Provags-ID: V03:K1:u1Jo1q8aSjZa7rAnWG6dKDrgk4vS8uiSF+KVktI5jpfj+RkXiH5
 eUTwEPfQbN63km629VcEHJ4YC7A78fB0lEAuu7AG6kOMj1muFg+phvjXMnSTtbUiVr1b/fH
 TycQuuDagvct5/UIbZLkoCIekbQxhAOwE0rn2aia0CX9dIaKuo1fcthwYRPlk4NAzOrfT3d
 EPf+whUPT1SCtEvsfp9aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lgxwsoz0lQw=:b2KyQaqJUes7rhAlUEulEj
 AHWmUGBkDq91qF9q/jpWU7a+kC6wUTk+XN4t0bW0v/BNrRGsZSNs+4lpV6ArREsHwBjUcCtn6
 W4JmBy04zTo0aYzpQg001C9AKv6g+oZxj+GVg54/7jyUP6n+PoinnpSxmfEvCCth3+KxI+Gjy
 bSb5HGrg8OKtF5lQJzePCQ5D4aDx4CvTIidsEhmbdFjJP47IyZ9Eu1kFKwl9rE3dSP2jb1Xpy
 8YcTTGyp4WOb8Kf4tNaehxISdQryONk7jYUEiiubRLd1f5mr4QRLRQYR9Z8kuKoH/6CcqnBp/
 R4l6Hni19l9Dqg4shMji3QK8QpsilZm7z5StVgiAkQIVJU/J6qzM1IYJj8GEcssI2MA5KV/cR
 g43qwaVcldwfQPap6J5weshwwGLmwEQNKwrmK1JsXcg9JNXUeacmrxLboYOmfjPhgPbtkzF1k
 6BvZSlRPhZcAC/W7OIzkLUt2vkPQCAWij+CSb/xt0aZkIZtRRjpqt7xUMQ2BvJDbhCNfXqkVf
 hUltAK3ea7DdS8Pwcy1ClLTjSlq3LPn+4HdunWxm3F+qvZRPI/opk0Kzj7SjW/sylC35GD0Or
 AUuV/jjqgaOv5Kzplwc05iduXtTV2kNH8/UpJ1KfPmTMnebCtkimKNNaE7CFk6LBm04fGRJY1
 ZMv3+upo0KDGiEeB7ghlc5ut6yG2Q/jHmIoNiVs51BjDaftZrsx3CgOAbbvl5L1KNf+TdWxEn
 Ee0I7Y9EBJQy2EgG09doqzK+wxvnkDu7mnTzrdN5pT4qbuSyvFbc2H5KxAIQQ6xzetsQwzw6T
 gGdLsbA3N34edu8sb4LvSOaXdU8nvEYtucEpPrNMPWZcZK/BXUbRbXzrwSdtVoTcQ9qxKqp/K
 I0BwQzqh0c9xwlGQ/Zug==
X-Spam-Status: No, score=-98.7 required=5.0 tests=BAYES_00, BODY_8BITS,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 23 Aug 2021 18:09:10 -0000

Hi Александр,

On Aug 23 18:48, Александр Маликов wrote:
> https://gist.github.com/schn27/23b47563b429aaaad5ac315d05a43a11
> 
> The test is failed if "Thread #X timeout" is printed and -1 returned. This
> happens on my laptop in about several minutes.
> The test is passed if it runs infinitely.

Yup, that shows the problem nicely.

> > LGTM.  Can you please provide a copyright waiver per
> > https://cygwin.com/contrib.html.  See the winsup/CONTRIBUTORS file.

Just provide your BSD-2 waiver and I'll push your patch.


Thanks,
Corinna
