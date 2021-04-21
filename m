Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 364D738460A2
 for <cygwin-patches@cygwin.com>; Wed, 21 Apr 2021 16:40:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 364D738460A2
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1McHM2-1l3V2u0qNg-00cgWw for <cygwin-patches@cygwin.com>; Wed, 21 Apr 2021
 18:40:04 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 80678A80EDD; Wed, 21 Apr 2021 18:40:03 +0200 (CEST)
Date: Wed, 21 Apr 2021 18:40:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use automake (v5)
Message-ID: <YIBVYytjWjpdFDTo@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210420201326.4876-1-jon.turney@dronecode.org.uk>
 <5d7176f9-8d82-9b2c-4717-fdc5041d95ce@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d7176f9-8d82-9b2c-4717-fdc5041d95ce@dronecode.org.uk>
X-Provags-ID: V03:K1:Wos6WGPGYyRXr7pb2FhNOarG12aO0Uv2t0lASnhu7o2KFdAV9xv
 NlLbiq7ecbwvdXhjrSUSryjt54ImzoYdgfm9dz+ZxuYkZ/1iI8Hy2ATSNt+R9qLRGvBuDkY
 a6b1NH+91QO6muFDWOsxX3ZC5L/nTlt6RgURotIGFwzgpJvVXYJIR5a03TyzAlP9gJynaXd
 61AkThhRt0erzd5OTLENA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/dwWkcEsnhI=:Iw23XruAzSCQMDrpd3ONTh
 foNINYMN1ZJxIAKHp78Ek60v/LR3Jn5K35GCIWUrXTaidtr+WCUIkrBI0b3PFQM4UiZ2RQaRv
 x28iKhAaE2vXlU0D4qQrERss3KcQyiMrpbXDnQwuHRpZloolTxaqWnyIE0GQBqX0KHDQYDuV7
 6fi4+vfBOyOFqdaugnBGiDAbpL5hX7zBK79TR+z7Gr8e/lsFTHjxMul5Gbsv6AGJdZ84yfnw9
 SOCSAyGgWl6aKKO2onnd8CAx3fxR946Ea/I8HZRH6Spqf8y5hbqhEVqG+Cg6AbwPzWfkGWfRJ
 AzdB76fyHg5Uvwbrq1YW1NBjzcADNNkJBLsohp2D0bTfjhAri9/E7T6GBUIusxMBNBi/EnRZs
 LKgVLmwxRKhKJ+Ub97Hw0Gf796Cq6U2MAuKpPZ292jlj1qVDd6/DRPim7M1L/0hU6GP8dhNM6
 m5Anf0inJmhnmhZiW2V+YQIGl1rHzCdNGBSSV5T7sdXuj3OlxsZHsvAcMgcIl2NRxOxhLk1CD
 FT57FYqOJmhacKRnUkNcTg=
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 21 Apr 2021 16:40:09 -0000

On Apr 20 21:15, Jon Turney wrote:
> On 20/04/2021 21:13, Jon Turney wrote:
> > For ease of reviewing, this patch doesn't contain changes to generated
> > files which would be made by running ./autogen.sh.
> 
> Sorry about getting distracted from this.  To summarize what I believe were
> the outstanding issues with v3 [1]:
> 
> [1] https://cygwin.com/pipermail/cygwin-patches/2020q4/010827.html
> 
> * 'INCLUDES' is the old name for 'AM_CPPFLAGS' warning from autogen.sh
> 
> I plan to clean this up in a future patch
> 
> * 'ps$(EXEEXT)' previously defined' warning from autogen.sh
> 
> It seems to be a shortcoming of automake that there's no way to suppress
> just that warning.
> 
> One possible solution is build ps.exe with a different name and rename it
> while installing, but I think that is counter-productive (in the sense that
> it trades this warning for making the build more complex to understand)
> 
> * some object files are in a unexpected places in the build file hierarchy
> (compared to naive expectations and/or the non-automake build)

This is the only minor qualm I have with this patch.  It would be nice
to have the mingw sources and .o files in the mingw subdir.  It would
simply be a bit cleaner.  The files shared between cygwin and mingw
(that's only path.cc, I think) could be handled by an include, i. e.

  utils/

    path.cc (full implementation)

  utils/mingw/

    path.cc:

      #include "../path.cc"

However, this isn't a showstopper, feel free to push what you're comfortable
with.

Still, wWhat do you think?  Any problem to move the mingw stuff to the
mingw subdir entirely?


Thanks,
Corinna
