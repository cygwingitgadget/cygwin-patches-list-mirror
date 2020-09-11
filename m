Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 9CC36385703C
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 14:08:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9CC36385703C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MQMqN-1juY9O495N-00MKkT for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020
 16:08:48 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 620DCA803FC; Fri, 11 Sep 2020 16:08:47 +0200 (CEST)
Date: Fri, 11 Sep 2020 16:08:47 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: ldd: Also look for not found DLLs when exit
 status is non-zero
Message-ID: <20200911140847.GL4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200910122740.8534-1-jon.turney@dronecode.org.uk>
 <20200910140455.GC4127@calimero.vinschen.de>
 <50e65d21-e501-99fe-80ef-e3b9c04bb4ed@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50e65d21-e501-99fe-80ef-e3b9c04bb4ed@dronecode.org.uk>
X-Provags-ID: V03:K1:GtShr+BGufz2GvhEc8NpW066Vzyk0THKuFJiGRRWImvmhUFC1uC
 +IGgOXDyAnhTbErTzjfgs/VxYqPP4X0+z5hBi/gmZ3SfJqCfYxrXtkxKttqwIH+qcSkRmlz
 mot4e4cG2pZr8TOu79doAatusQQiEqjkYrNfcQ5QSDZ4+7Ot+LSbhnJ3K5KfJK4KYrp6GEM
 4jetot69i/zAYEBwPt8bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H0GJhCYc0cY=:YkgAuoJ4PHzlb0et+qZYr1
 +aZ74SiES3569G+kfHBOPSHc4qBwBxkVQXRLLmOrYJfPqz25fP4RwsKINqrssz1U5aWrx9tHD
 6v7n2WlGYuvmoymQtuR5nfEpTKCoCYDZgJn6vq6icci3mSjavuHTWKPsLvt4/fM2LXy4x48bA
 u3ojN9rIyY+yXEEBfTqxa7QiFV12kJ8qng1UuSPrm7z+s/g4rZZnxi13cFTrXul6MlsaKGMF6
 G+l0HpA4HpuNygwDtHFAmZCxX71M1TZt54lANOXdChzH7xU8ym/YUCeJDs8Z3kLfBl45DQtAo
 CrndvllydOVEU0IUyMlUaepfM0hM+LOAfpKU8knd3QQXitwffYtu2ksPOPGjaWAr1WAV1OPxI
 AE1V7fJY+9BKqlpsiMSdiAL/ahGEbwYcLhAXqMp2+n1BRt1FuyV4VpR4Dh7z89C4lqyi1NY+s
 ypdJnfQ9uiMx39iDWI3Yr95RCfmm1onmVjaDm01HxBP+B6d5ya372n1+Zjf3JELusjePkeeR7
 5pf5yb4I7/G6SHqm1NjtJ5P0a0y+FiIzMND92U793amSf6UpbPZ9JXZhxLUYhU10J4LztI4zK
 vfhXhf0Pk/dYTDC0/Cpvscdutl+AKP9gapg3+4NHdSH6coyhrvcb+jhPJjJ4ysgX1D2hs1k7s
 zmjUNY89421mc66DpmO9DEha4fIi0Y47zSA+nm9jVYU1jPduNpHcakghhYglgAFeg/iw7hkiK
 O5yZ+JRKZ5k8CZUJyYMl9Enyf1AiHbB5xySUjC1alFN1XJIXeoO0Lid0VpOYjWkSsbg+Xx5KN
 wYHnh6pKJD2PPBHVyK3mzax4rarosvesd5go41wcH7Uj0jvZGFcOpfpzFwMS+kcZIXR/SfnXG
 aSrcAVApHk/TBokQQnzw==
X-Spam-Status: No, score=-100.5 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Fri, 11 Sep 2020 14:08:51 -0000

On Sep 11 13:33, Jon Turney wrote:
> On 10/09/2020 15:04, Corinna Vinschen wrote:
> > On Sep 10 13:27, Jon Turney wrote:
> > > If the process exited with e.g. STATUS_DLL_NOT_FOUND, also process the
> > > file to look for not found DLLs.
> > > 
> > > (We currently only do this when a STATUS_DLL_NOT_FOUND exception occurs,
> > > which I haven't managed to observe)
> > > 
> > > This still isn't 100% correct, as it only examines the specified file
> > > for missing DLLs, not recursively on the DLLs it depends upon.
> > 
> > Better than nothing?
> 
> Well, except when people are misled when investigating problems because they
> assume the output is accurate. (e.g. [1])
> 
> [1] https://cygwin.com/pipermail/cygwin/2020-September/246164.html
> 
> I guess what's maybe needed is some indication that an error occurred and
> the output may be incomplete if the inferior process exited with a non-zero
> status.  But not sure how we can do that while keeping the output compatible
> with linux ldd.

I assume there *may* occur an error in ldd as well, so it might be
intersting to check the Linux ldd sources to see how it generates
error output.


Corinna
