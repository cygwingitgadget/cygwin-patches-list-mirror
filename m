Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 7A55C385AE78
 for <cygwin-patches@cygwin.com>; Thu,  9 Jun 2022 15:23:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7A55C385AE78
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mg6i8-1nXPQf3BR0-00hcgf; Thu, 09 Jun 2022 17:23:11 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 13731A807E3; Thu,  9 Jun 2022 17:23:11 +0200 (CEST)
Date: Thu, 9 Jun 2022 17:23:11 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 7/7] Cygwin: remove miscellaneous 32-bit code
Message-ID: <YqIQX4HJ8lXveQdx@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>, cygwin-patches@cygwin.com
References: <2de3539b-efc2-b6f1-b9e3-8429ecb24c0b@cornell.edu>
 <ce7de251-14d1-e54d-e2ef-5b67ad256a64@dronecode.org.uk>
 <c5bec956-6e71-083e-f3bf-f6b52726b218@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5bec956-6e71-083e-f3bf-f6b52726b218@cornell.edu>
X-Provags-ID: V03:K1:S+J0AtHkzSvTK9Z3+EP7pqjWx9fJBu2b84snztRYx/GAnODTNw8
 QAXm7bE8ry+wBlx06eCdcsZ9qq4IorCAX+zCf+D65m2US6grdKXUaK2JAxkPSi08Hp/Lw8W
 L5ZZ+7BjiCnj7upJxm+Evgdm1vx793Xas/nwTzSzxSND9/xKqEleymvWJveAXxgfEYkhLLl
 mTKTEQpjJRKu6Db4ZCetA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZbXcpnjFhAc=:KWGPAIZV4oTrOpczNrUnS4
 bYQgehOSGKL5tRrfHPRIzbZ2W+5uOT866NokfkkvjGavo20edjvMA5+sLN05cYUtCdYUvac8P
 ckUT5dodd8S5fzR2geMsGhZqLM4yX9XYojtR5zGtoabH+1s2qF3t+ge8E1I3/kJliBotsW0QX
 aBATO18iDg/zR7yicleZ/ELbMKaNeeXWK4QyrPvC6BZgGvtRPXQ2nWg8ryY+CqZHjUgGJu6p8
 70tqDMv1mxuqNLhDHtznM9ml7zA5TypajCqqbbtS3v/5AVJH5TArC8bAnq1iQHr8mY921t7ay
 eJcvaKuxsB5cv9uWxQOj3+lgQ6P1WbrulXISIr9+5ZbcWQgWkdXZ0hMQUS7iMKSvODUG7eiJT
 hKjz+9ohQA14Aw5yrn1SCay9YEN0YN0GEA/hxpFVvjEDI2534bVZhuzE18er4YK4apzb3RrO9
 Ednc+uUd5yXVCi3+vXxe6mt8lPH7Cr6G+kSmMbK8VOL+QHaMqoSGYxpcHHmuBLUk13iFCT194
 IyRJshBYnDbq51wgiuZenIuxkcGpBT7DMYbqcusgyinB1JhJg1ROvGgt+0wW+GKZ0GUw0TYJQ
 t53XH0xKTajg97PLWPtZ1wFn8qJ7h3AVcGY7HcrO48BYk6KaXyz3ZQswFvMb3xw2KjrRXBHbZ
 GPTuqxDPIC8q/IlU003d1FnLJAkVEDnW/K+2wJAxLK99Y4PzXVX4ggNQh3onXVSHftHlRT7pU
 Ahr6TPhq8frnAemhAQKTknPTauHZnJNKLj791E9fnvu2rHkW1WuhH6lxVa0=
X-Spam-Status: No, score=-93.6 required=5.0 tests=BAYES_00, BODY_8BITS,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 09 Jun 2022 15:23:18 -0000

On May 29 17:26, Ken Brown wrote:
> On 5/29/2022 9:39 AM, Jon Turney wrote:
> > On 26/05/2022 20:17, Ken Brown wrote:
> > >   winsup/cygwin/autoload.cc                | 136 -----------------------
> > 
> > Looks good.
> > 
> > I think that perhaps the stdcall decoration number n is unused on
> > x86_64, so can be removed also in a followup?
> 
> Thanks, I missed that.
> 
> Also, I guess most or all of the uses of __stdcall and __cdecl can be
> removed from the code.

Yes, that's right, given there's only one calling convention on 64 bit.

I have a minor objection in terms of this patch.

When implementing support for AMD64, there were basically 2 problems to
solve. One of them was to support 64 bit systems, the other one was to
support AMD64.  At that time, only IA-64 and AMD64 64 bit systems
existed, and since we never considered IA-64 to run Cygwin on, we
subsumed all 64 bit code paths under the __x86_64__ macro.

But should we *ever* support ARM64, as unlikely as it is, we have to
make sure to find all the places where the code is specificially AMD64.
That goes, for instance, for all places calling assembler code, or
for exception handling accessing CPU registers, etc.

I'm open to discussion, but I think the code being CPU-specific
should still be enclosed into #ifdef __x86_64__ brackets, with an
#else #error alternative.

Right?  Wrong?  Useless complication?


Thanks,
Corinna
