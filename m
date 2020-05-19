Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id A9A5A389781C
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 10:06:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A9A5A389781C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MBSJT-1jmD0k2AGt-00D0p5 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020
 12:06:53 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 39236A80F7E; Tue, 19 May 2020 12:06:53 +0200 (CEST)
Date: Tue, 19 May 2020 12:06:53 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Re [Cygwin PATCH */9] tzcode resync -- for discussion only
Message-ID: <20200519100653.GU3947@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.BSF.4.63.2005131531040.41959@m0.truegem.net>
 <20200519094830.GQ3947@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200519094830.GQ3947@calimero.vinschen.de>
X-Provags-ID: V03:K1:aMWV8RoDQ8H04o2h+DPU81mJcf+HIWbWK+DTadRcxu4JTkgjxX+
 3ouinMIeFDkvsEJWxeuIjrOAskOMhTRxzL+z6Rh4AT24C45vLrM0pv9kzuzVKBsQD+Of2YO
 yiA+9PwG1qOzxKdivLfqfbmvHwurdkUd99TA+1rfIxwovmU3vQ1W61fYAt0ZCkJc7nu4G24
 6xgUy/UjufB0wB9ZocTIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OMDzW23IeKQ=:5MqjBSqXj6pmnIwhcGikow
 fvk8K8XgnB5f6/yi/OX31oe9JzC94PQyMNgH9azdVi8pCo2Kja1hhx5KETiaMoCyGr5pFDPQm
 AqDJOq9xxSed9XrUx1tbWkmSpdZsqi91k6TeyNpuSL5eD3caILY0QEQylgz+OWKyWnltmK65O
 281TB++8QfamL/gubrkR4p9OPYTHMhiHSuE6eg5javF0CY9WLVwXjd+lfJIdrqhsELgkbfbj8
 aQR2PhmX5rENZRRoaEzXsG6i7EEuzV2TWy1bUQuDne+0xRTDBS2nduAqSZZvTrXyw3iKPn5sl
 Bswjv3scld7xdL9fJvZfKejiItk+76wYzXhrei8tQN+HH9xiagFPYwgD9Fd3KNvm7shjPKpOt
 8LLDBuHdAeyGZOnMXEiEjo31ER4nPMzqyu9gdswy5aNEVFp5bccQXC/hlK/SNnYFS9PNN0tek
 v5qujMVngnxnENvsey96kGkk09BgqnNol1VA96bRWBlNs4OaSlklDriTWxuaweIjRgN5EYlsk
 Dph1Ef5vqL24LsdoM1LGH4FTCoBLGT7aRXeFYPpAmf0NGbJq5aDxGL8B4ItDTRd00Tw7E3FNk
 1o0K0+gNlIon7r5H1+QuKRyePdaiWXqZfBYc4U19qFn0biTW9aQYJqga/ta8p1K+wO82VMZxy
 UBoZnoAhbl7Zg8X16yIDR0U1UQVTltbs+dkQM0pm87MpERgPz4QCfV1zeEwBXJG1fG1e/3Gqu
 4bdfgkC7FbIJyxPTXZ7bB4dBsmA6yFGo/MDbgUBgfFVP+MKUa7CVo+aXE38AH8q+D+8MJqqhK
 zDt6AGCcnd4vpjAC10z4kwZuj3WqqWV8oGMcVQYlhtZYB6vH4yHL3G/SVAsEix1LtpFf3yN
X-Spam-Status: No, score=-98.2 required=5.0 tests=BAYES_00,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 19 May 2020 10:06:56 -0000

On May 19 11:48, Corinna Vinschen wrote:
> On May 13 15:40, Mark Geisert wrote:
> > I'm not absolutely sure yet but I think this patch set isn't complete.
> > What's been posted is OK for discussion (on cygwin-developers?) but would
> > need to be augmented if you're going to apply as-is.
> > 
> > I had a git commit/revert mishap and these are recovered file versions.  I
> > belatedly discovered there's no record in the patches of my creating
> > directory winsup/cygwin/tzcode or of my deleting localtime.cc and
> > tz_posixrules.h from winsup/cygwin in my local repository.
> > 
> > When it becomes time to submit the final patch versions, I'll do so from a
> > brand new repository.  Sorry for any confusion.
> 
> Patchset discussions should stay on cygwin-patches as part of the set.
> 
> Please resend the patchset in the current state on top of current git.
> Please add a cover letter (git format-patch --cover-letter ...) and just
> start the discussion yourself in the cover letter.  Note what you
> think is missing from the patchset and what you think needs addition or
> change, so we're vaguely on the same level as you :)

Scratch that, I didn't see your v2 yet, sorry!


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
